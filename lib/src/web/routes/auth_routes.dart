import 'dart:convert';
import 'dart:io';
import 'package:serverpod/serverpod.dart';
import '../../generated/protocol.dart';
import '../../services/jwt_service.dart';

class AuthRoutes extends Route {
  @override
  Future<bool> handleCall(Session session, HttpRequest request) async {
    final path = request.uri.path;
    final method = request.method;

    if (method == 'POST') {
      switch (path) {
        case '/api/auth/register':
          return await _handleRegister(session, request);
        case '/api/auth/login':
          return await _handleLogin(session, request);
        case '/api/auth/refresh':
          return await _handleRefresh(session, request);
        case '/api/auth/change-password':
          return await _handleChangePassword(session, request);
        default:
          return false;
      }
    } else if (method == 'GET' && path == '/api/auth/user') {
      return await _handleGetUser(session, request);
    }
    
    return false;
  }

  Future<bool> _handleRegister(Session session, HttpRequest request) async {
    try {
      // Read JSON body
      final body = await _readJsonBody(request);
      final email = body['email'] as String?;
      final password = body['password'] as String?;

      if (email == null || password == null) {
        await _sendJsonError(request, 'Email and password are required', 400);
        return true;
      }

      // Validate input
      if (email.isEmpty || !email.contains('@')) {
        await _sendJsonError(request, 'Invalid email address', 400);
        return true;
      }
      
      if (password.length < 8) {
        await _sendJsonError(request, 'Password must be at least 8 characters', 400);
        return true;
      }

      // Check if user already exists
      final existingUser = await User.db.findFirstRow(
        session,
        where: (t) => t.email.equals(email.toLowerCase()),
      );
      
      if (existingUser != null) {
        await _sendJsonError(request, 'User with this email already exists', 409);
        return true;
      }

      // Generate salt and hash password
      final salt = JWTService.generateSalt();
      final passwordHash = JWTService.hashPassword(password, salt);

      // Create new user
      final user = User(
        email: email.toLowerCase(),
        passwordHash: passwordHash,
        salt: salt,
        createdAt: DateTime.now(),
        lastLoginAt: DateTime.now(),
      );

      final savedUser = await User.db.insertRow(session, user);

      // Generate tokens
      final token = JWTService.generateToken(
        session: session,
        userId: savedUser.id!,
        email: savedUser.email,
      );

      final refreshToken = JWTService.generateRefreshToken(
        session: session,
        userId: savedUser.id!,
      );

      // Send response
      await _sendJsonResponse(request, {
        'user': {
          'id': savedUser.id,
          'email': savedUser.email,
          'createdAt': savedUser.createdAt.toIso8601String(),
          'lastLoginAt': savedUser.lastLoginAt?.toIso8601String(),
        },
        'token': token,
        'refreshToken': refreshToken,
        'expiresIn': 7 * 24 * 60 * 60, // 7 days in seconds
      });
      
      return true;
    } catch (e) {
      session.log('Error registering user: $e');
      await _sendJsonError(request, 'Registration failed: ${e.toString()}', 500);
      return true;
    }
  }

  Future<bool> _handleLogin(Session session, HttpRequest request) async {
    try {
      // Read JSON body
      final body = await _readJsonBody(request);
      final email = body['email'] as String?;
      final password = body['password'] as String?;

      if (email == null || password == null) {
        await _sendJsonError(request, 'Email and password are required', 400);
        return true;
      }

      // Find user by email
      final user = await User.db.findFirstRow(
        session,
        where: (t) => t.email.equals(email.toLowerCase()),
      );

      if (user == null) {
        await _sendJsonError(request, 'Invalid email or password', 401);
        return true;
      }

      // Verify password
      if (user.passwordHash == null || user.salt == null) {
        await _sendJsonError(request, 'Invalid email or password', 401);
        return true;
      }
      
      final isValidPassword = JWTService.verifyPassword(
        password,
        user.passwordHash!,
        user.salt!,
      );

      if (!isValidPassword) {
        await _sendJsonError(request, 'Invalid email or password', 401);
        return true;
      }

      // Update last login
      user.lastLoginAt = DateTime.now();
      await User.db.updateRow(session, user);

      // Generate tokens
      final token = JWTService.generateToken(
        session: session,
        userId: user.id!,
        email: user.email,
      );

      final refreshToken = JWTService.generateRefreshToken(
        session: session,
        userId: user.id!,
      );

      // Send response
      await _sendJsonResponse(request, {
        'user': {
          'id': user.id,
          'email': user.email,
          'createdAt': user.createdAt.toIso8601String(),
          'lastLoginAt': user.lastLoginAt?.toIso8601String(),
        },
        'token': token,
        'refreshToken': refreshToken,
        'expiresIn': 7 * 24 * 60 * 60, // 7 days in seconds
      });
      
      return true;
    } catch (e) {
      session.log('Error logging in user: $e');
      await _sendJsonError(request, 'Login failed: ${e.toString()}', 500);
      return true;
    }
  }

  Future<bool> _handleRefresh(Session session, HttpRequest request) async {
    try {
      // Read JSON body
      final body = await _readJsonBody(request);
      final refreshToken = body['refreshToken'] as String?;

      if (refreshToken == null) {
        await _sendJsonError(request, 'Refresh token is required', 400);
        return true;
      }

      // Verify refresh token
      final payload = JWTService.verifyToken(
        session: session,
        token: refreshToken,
        isRefreshToken: true,
      );

      if (payload == null) {
        await _sendJsonError(request, 'Invalid refresh token', 401);
        return true;
      }

      final userId = payload['userId'] as int;

      // Get user
      final user = await User.db.findById(session, userId);
      if (user == null) {
        await _sendJsonError(request, 'User not found', 404);
        return true;
      }

      // Generate new tokens
      final newToken = JWTService.generateToken(
        session: session,
        userId: user.id!,
        email: user.email,
      );

      final newRefreshToken = JWTService.generateRefreshToken(
        session: session,
        userId: user.id!,
      );

      // Send response
      await _sendJsonResponse(request, {
        'user': {
          'id': user.id,
          'email': user.email,
          'createdAt': user.createdAt.toIso8601String(),
          'lastLoginAt': user.lastLoginAt?.toIso8601String(),
        },
        'token': newToken,
        'refreshToken': newRefreshToken,
        'expiresIn': 7 * 24 * 60 * 60, // 7 days in seconds
      });
      
      return true;
    } catch (e) {
      session.log('Error refreshing token: $e');
      await _sendJsonError(request, 'Token refresh failed: ${e.toString()}', 500);
      return true;
    }
  }

  Future<bool> _handleChangePassword(Session session, HttpRequest request) async {
    try {
      // Get bearer token from header
      final authHeader = request.headers.value('authorization');
      if (authHeader == null || !authHeader.startsWith('Bearer ')) {
        await _sendJsonError(request, 'Authorization required', 401);
        return true;
      }

      final token = authHeader.substring(7);

      // Read JSON body
      final body = await _readJsonBody(request);
      final currentPassword = body['currentPassword'] as String?;
      final newPassword = body['newPassword'] as String?;

      if (currentPassword == null || newPassword == null) {
        await _sendJsonError(request, 'Current and new passwords are required', 400);
        return true;
      }

      // Verify token and get user ID
      final userId = JWTService.getUserIdFromToken(
        session: session,
        token: token,
      );

      if (userId == null) {
        await _sendJsonError(request, 'Invalid or expired token', 401);
        return true;
      }

      // Get user
      final user = await User.db.findById(session, userId);
      if (user == null) {
        await _sendJsonError(request, 'User not found', 404);
        return true;
      }

      // Verify current password
      if (user.passwordHash == null || user.salt == null) {
        await _sendJsonError(request, 'User password not set', 400);
        return true;
      }
      
      final isValidPassword = JWTService.verifyPassword(
        currentPassword,
        user.passwordHash!,
        user.salt!,
      );

      if (!isValidPassword) {
        await _sendJsonError(request, 'Current password is incorrect', 401);
        return true;
      }

      // Validate new password
      if (newPassword.length < 8) {
        await _sendJsonError(request, 'New password must be at least 8 characters', 400);
        return true;
      }

      // Generate new salt and hash
      final newSalt = JWTService.generateSalt();
      final newPasswordHash = JWTService.hashPassword(newPassword, newSalt);

      // Update user
      user.passwordHash = newPasswordHash;
      user.salt = newSalt;
      await User.db.updateRow(session, user);

      // Send success response
      await _sendJsonResponse(request, {
        'success': true,
        'message': 'Password changed successfully'
      });
      
      return true;
    } catch (e) {
      session.log('Error changing password: $e');
      await _sendJsonError(request, 'Password change failed: ${e.toString()}', 500);
      return true;
    }
  }

  Future<bool> _handleGetUser(Session session, HttpRequest request) async {
    try {
      // Get bearer token from header
      final authHeader = request.headers.value('authorization');
      if (authHeader == null || !authHeader.startsWith('Bearer ')) {
        await _sendJsonError(request, 'Authorization required', 401);
        return true;
      }

      final token = authHeader.substring(7);

      // Verify token and get user ID
      final userId = JWTService.getUserIdFromToken(
        session: session,
        token: token,
      );

      if (userId == null) {
        await _sendJsonError(request, 'Invalid or expired token', 401);
        return true;
      }

      // Get user
      final user = await User.db.findById(session, userId);
      if (user == null) {
        await _sendJsonError(request, 'User not found', 404);
        return true;
      }

      // Send user data
      await _sendJsonResponse(request, {
        'user': {
          'id': user.id,
          'email': user.email,
          'createdAt': user.createdAt.toIso8601String(),
          'lastLoginAt': user.lastLoginAt?.toIso8601String(),
        }
      });
      
      return true;
    } catch (e) {
      session.log('Error getting user: $e');
      await _sendJsonError(request, 'Failed to get user: ${e.toString()}', 500);
      return true;
    }
  }

  Future<Map<String, dynamic>> _readJsonBody(HttpRequest request) async {
    final content = await utf8.decoder.bind(request).join();
    if (content.isEmpty) {
      return {};
    }
    return jsonDecode(content) as Map<String, dynamic>;
  }

  Future<void> _sendJsonResponse(HttpRequest request, Map<String, dynamic> data) async {
    request.response
      ..statusCode = HttpStatus.ok
      ..headers.contentType = ContentType.json
      ..headers.add('Access-Control-Allow-Origin', '*')
      ..headers.add('Access-Control-Allow-Methods', 'POST, GET, OPTIONS')
      ..headers.add('Access-Control-Allow-Headers', 'Content-Type, Authorization')
      ..write(jsonEncode(data));
    await request.response.close();
  }

  Future<void> _sendJsonError(HttpRequest request, String message, int statusCode) async {
    request.response
      ..statusCode = statusCode
      ..headers.contentType = ContentType.json
      ..headers.add('Access-Control-Allow-Origin', '*')
      ..headers.add('Access-Control-Allow-Methods', 'POST, GET, OPTIONS')
      ..headers.add('Access-Control-Allow-Headers', 'Content-Type, Authorization')
      ..write(jsonEncode({'error': message}));
    await request.response.close();
  }
}