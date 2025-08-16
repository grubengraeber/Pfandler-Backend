import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';
import '../services/jwt_service.dart';

class AuthEndpoint extends Endpoint {
  @override
  bool get requireLogin => false;

  Future<AuthResponse?> registerWithEmail(
    Session session,
    AuthRequest request,
  ) async {
    try {
      // Validate input
      if (request.email.isEmpty || !request.email.contains('@')) {
        throw Exception('Invalid email address');
      }
      
      if (request.password.length < 8) {
        throw Exception('Password must be at least 8 characters');
      }

      // Check if user already exists
      final existingUser = await User.db.findFirstRow(
        session,
        where: (t) => t.email.equals(request.email.toLowerCase()),
      );
      
      if (existingUser != null) {
        throw Exception('User with this email already exists');
      }

      // Generate salt and hash password
      final salt = JWTService.generateSalt();
      final passwordHash = JWTService.hashPassword(request.password, salt);

      // Create new user
      final user = User(
        email: request.email.toLowerCase(),
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

      // Create and return auth response
      return AuthResponse(
        user: savedUser,
        token: token,
        refreshToken: refreshToken,
        expiresIn: 7 * 24 * 60 * 60, // 7 days in seconds
      );
    } catch (e) {
      session.log('Error registering user: $e');
      throw Exception('Registration failed: ${e.toString()}');
    }
  }

  Future<AuthResponse?> loginWithEmail(
    Session session,
    AuthRequest request,
  ) async {
    try {
      // Find user by email
      final user = await User.db.findFirstRow(
        session,
        where: (t) => t.email.equals(request.email.toLowerCase()),
      );

      if (user == null) {
        throw Exception('Invalid email or password');
      }

      // Verify password
      if (user.passwordHash == null || user.salt == null) {
        throw Exception('Invalid email or password');
      }
      
      final isValidPassword = JWTService.verifyPassword(
        request.password,
        user.passwordHash!,
        user.salt!,
      );

      if (!isValidPassword) {
        throw Exception('Invalid email or password');
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

      // Create and return auth response
      return AuthResponse(
        user: user,
        token: token,
        refreshToken: refreshToken,
        expiresIn: 7 * 24 * 60 * 60, // 7 days in seconds
      );
    } catch (e) {
      session.log('Error logging in user: $e');
      throw Exception('Login failed: ${e.toString()}');
    }
  }

  Future<AuthResponse?> refreshToken(
    Session session,
    RefreshTokenRequest request,
  ) async {
    try {
      // Verify refresh token
      final payload = JWTService.verifyToken(
        session: session,
        token: request.refreshToken,
        isRefreshToken: true,
      );

      if (payload == null) {
        throw Exception('Invalid refresh token');
      }

      final userId = payload['userId'] as int;

      // Get user
      final user = await User.db.findById(session, userId);
      if (user == null) {
        throw Exception('User not found');
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

      // Return new auth response
      return AuthResponse(
        user: user,
        token: newToken,
        refreshToken: newRefreshToken,
        expiresIn: 7 * 24 * 60 * 60, // 7 days in seconds
      );
    } catch (e) {
      session.log('Error refreshing token: $e');
      throw Exception('Token refresh failed: ${e.toString()}');
    }
  }

  Future<User?> getCurrentUser(
    Session session,
    String token,
  ) async {
    try {
      // Verify token and get user ID
      final userId = JWTService.getUserIdFromToken(
        session: session,
        token: token,
      );

      if (userId == null) {
        throw Exception('Invalid or expired token');
      }

      // Get and return user
      return await User.db.findById(session, userId);
    } catch (e) {
      session.log('Error getting current user: $e');
      throw Exception('Authentication failed: ${e.toString()}');
    }
  }

  Future<bool> linkDevice(
    Session session,
    String token,
    String deviceId,
    String deviceName,
  ) async {
    try {
      // Verify token and get user ID
      final userId = JWTService.getUserIdFromToken(
        session: session,
        token: token,
      );

      if (userId == null) {
        throw Exception('Invalid or expired token');
      }

      // TODO: Implement device linking logic
      // For now, just log and return success
      session.log('Linking device $deviceId for user $userId');
      
      return true;
    } catch (e) {
      session.log('Error linking device: $e');
      return false;
    }
  }

  Future<bool> logout(
    Session session,
    String token,
  ) async {
    try {
      // Verify token to ensure it's valid
      final userId = JWTService.getUserIdFromToken(
        session: session,
        token: token,
      );

      if (userId == null) {
        return false;
      }

      // TODO: In production, you might want to blacklist the token
      // or store it in a revoked tokens list
      session.log('User $userId logged out');
      
      return true;
    } catch (e) {
      session.log('Error during logout: $e');
      return false;
    }
  }

  Future<bool> changePassword(
    Session session,
    ChangePasswordRequest request,
  ) async {
    try {
      // Verify token and get user ID
      final userId = JWTService.getUserIdFromToken(
        session: session,
        token: request.token,
      );

      if (userId == null) {
        throw Exception('Invalid or expired token');
      }

      // Get user
      final user = await User.db.findById(session, userId);
      if (user == null) {
        throw Exception('User not found');
      }

      // Verify current password
      if (user.passwordHash == null || user.salt == null) {
        throw Exception('User password not set');
      }
      
      final isValidPassword = JWTService.verifyPassword(
        request.currentPassword,
        user.passwordHash!,
        user.salt!,
      );

      if (!isValidPassword) {
        throw Exception('Current password is incorrect');
      }

      // Validate new password
      if (request.newPassword.length < 8) {
        throw Exception('New password must be at least 8 characters');
      }

      // Generate new salt and hash
      final newSalt = JWTService.generateSalt();
      final newPasswordHash = JWTService.hashPassword(request.newPassword, newSalt);

      // Update user
      user.passwordHash = newPasswordHash;
      user.salt = newSalt;
      await User.db.updateRow(session, user);

      return true;
    } catch (e) {
      session.log('Error changing password: $e');
      throw Exception('Password change failed: ${e.toString()}');
    }
  }
}