import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';
import 'jwt_service.dart';

class AuthService {
  /// Get authenticated user from token
  /// Note: In Serverpod, we pass tokens as parameters since headers aren't directly accessible
  static Future<User?> getAuthenticatedUser(Session session, String? token) async {
    if (token == null || token.isEmpty) {
      return null;
    }

    try {
      // Remove Bearer prefix if present
      final cleanToken = token.startsWith('Bearer ') 
        ? token.substring(7) 
        : token;
      
      // Verify token and get user ID
      final userId = JWTService.getUserIdFromToken(
        session: session,
        token: cleanToken,
      );

      if (userId == null) {
        return null;
      }

      // Get and return user
      return await User.db.findById(session, userId);
    } catch (e) {
      session.log('Error getting authenticated user: $e');
      return null;
    }
  }

  /// Require authentication for an endpoint
  static Future<User> requireAuth(Session session, String? token) async {
    final user = await getAuthenticatedUser(session, token);
    if (user == null) {
      throw Exception('Authentication required');
    }
    return user;
  }
  
  /// Check if user is authenticated
  static Future<bool> isAuthenticated(Session session, String? token) async {
    final user = await getAuthenticatedUser(session, token);
    return user != null;
  }
}