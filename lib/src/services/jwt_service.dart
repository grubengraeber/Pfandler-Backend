import 'dart:convert';
import 'dart:io';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:serverpod/serverpod.dart';
import 'package:crypto/crypto.dart';

class JWTService {
  // Get secret from environment or config
  static String _getJWTSecret(Session session) {
    // In production, this should come from environment variables
    final secret = session.serverpod.getPassword('jwt_secret') ??
        Platform.environment['JWT_SECRET'] ??
        'your-super-secret-jwt-key-change-in-production';
    return secret;
  }

  /// Generate a JWT token for a user
  static String generateToken({
    required Session session,
    required int userId,
    required String email,
    Duration expiry = const Duration(days: 7),
  }) {
    final jwt = JWT(
      {
        'userId': userId,
        'email': email,
        'iat': DateTime.now().millisecondsSinceEpoch ~/ 1000,
        'exp': DateTime.now().add(expiry).millisecondsSinceEpoch ~/ 1000,
      },
      subject: userId.toString(),
      issuer: 'pfandler-backend',
    );

    final token = jwt.sign(
      SecretKey(_getJWTSecret(session)),
      algorithm: JWTAlgorithm.HS256,
    );

    return token;
  }

  /// Generate a refresh token
  static String generateRefreshToken({
    required Session session,
    required int userId,
  }) {
    final jwt = JWT(
      {
        'userId': userId,
        'type': 'refresh',
        'iat': DateTime.now().millisecondsSinceEpoch ~/ 1000,
        'exp': DateTime.now().add(Duration(days: 30)).millisecondsSinceEpoch ~/
            1000,
      },
      subject: userId.toString(),
      issuer: 'pfandler-backend',
    );

    final token = jwt.sign(
      SecretKey('${_getJWTSecret(session)}-refresh'),
      algorithm: JWTAlgorithm.HS256,
    );

    return token;
  }

  /// Verify and decode a JWT token
  static Map<String, dynamic>? verifyToken({
    required Session session,
    required String token,
    bool isRefreshToken = false,
  }) {
    try {
      final secret = isRefreshToken
          ? '${_getJWTSecret(session)}-refresh'
          : _getJWTSecret(session);

      final jwt = JWT.verify(
        token,
        SecretKey(secret),
        checkExpiresIn: true,
        issuer: 'pfandler-backend',
      );

      return jwt.payload as Map<String, dynamic>;
    } catch (e) {
      session.log('JWT verification failed: $e');
      return null;
    }
  }

  /// Extract user ID from token
  static int? getUserIdFromToken({
    required Session session,
    required String token,
  }) {
    final payload = verifyToken(session: session, token: token);
    if (payload == null) return null;

    return payload['userId'] as int?;
  }

  /// Hash password using SHA256
  static String hashPassword(String password, String salt) {
    final bytes = utf8.encode(password + salt);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  /// Generate a random salt
  static String generateSalt() {
    final bytes = List<int>.generate(
        32, (i) => DateTime.now().millisecondsSinceEpoch * i % 256);
    return base64.encode(bytes);
  }

  /// Verify password
  static bool verifyPassword(String password, String hash, String salt) {
    final computedHash = hashPassword(password, salt);
    return computedHash == hash;
  }
}
