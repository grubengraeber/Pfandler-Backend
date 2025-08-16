import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

class SocialEndpoint extends Endpoint {
  Future<List<Map<String, dynamic>>> getFriends(Session session) async {
    final authInfo = await session.authenticated;
    if (authInfo == null) {
      throw Exception('User must be authenticated to view friends');
    }

    try {
      // Simplified friends list - in production you'd have a proper friends table
      final users = await User.db.find(
        session,
        limit: 10,
      );

      List<Map<String, dynamic>> friends = [];
      for (var user in users) {
        if (user.id == authInfo.userId) continue;
        
        // Get their stats
        final scans = await Scan.db.find(
          session,
          where: (t) => t.userId.equals(user.id!),
        );

        int totalDeposit = 0;
        for (var scan in scans) {
          totalDeposit += scan.depositCents ?? 0;
        }

        friends.add({
          'userId': user.id,
          'email': user.email,
          'scanCount': scans.length,
          'totalDepositCents': totalDeposit,
        });
      }

      return friends;
    } catch (e) {
      session.log('Error getting friends: $e');
      return [];
    }
  }

  Future<List<UserBadge>> getUserBadges(Session session) async {
    final authInfo = await session.authenticated;
    if (authInfo == null) {
      throw Exception('User must be authenticated to view badges');
    }

    try {
      return await UserBadge.db.find(
        session,
        where: (t) => t.userId.equals(authInfo.userId),
        orderBy: (t) => t.awardedAt,
        orderDescending: true,
      );
    } catch (e) {
      session.log('Error getting user badges: $e');
      return [];
    }
  }

  Future<UserBadge?> awardBadge(
    Session session,
    int userId,
    int badgeId,
  ) async {
    try {
      // Check if badge already awarded
      final existing = await UserBadge.db.findFirstRow(
        session,
        where: (t) => t.userId.equals(userId) & t.badgeId.equals(badgeId),
      );

      if (existing != null) {
        return existing;
      }

      final userBadge = UserBadge(
        userId: userId,
        badgeId: badgeId,
        awardedAt: DateTime.now(),
      );

      await UserBadge.db.insertRow(session, userBadge);
      return userBadge;
    } catch (e) {
      session.log('Error awarding badge: $e');
      return null;
    }
  }

  Future<void> checkAndAwardBadges(Session session, int userId) async {
    try {
      final user = await User.db.findById(session, userId);
      if (user == null) return;

      final scans = await Scan.db.find(
        session,
        where: (t) => t.userId.equals(userId),
      );

      int totalScans = scans.length;
      int totalDeposit = 0;
      Set<String> uniqueDays = {};
      
      for (var scan in scans) {
        totalDeposit += scan.depositCents ?? 0;
        uniqueDays.add('${scan.createdAt.year}-${scan.createdAt.month}-${scan.createdAt.day}');
      }

      // Check for various badge criteria
      final badges = await Badge.db.find(session);
      
      for (var badge in badges) {
        bool shouldAward = false;
        
        // Simple badge criteria based on name
        switch (badge.name) {
          case 'First Scan':
            shouldAward = totalScans >= 1;
            break;
          case 'Centurion':
            shouldAward = totalScans >= 100;
            break;
          case 'Deposit King':
            shouldAward = totalDeposit >= 10000; // 100 EUR
            break;
          case 'Week Streak':
            shouldAward = uniqueDays.length >= 7;
            break;
          case 'Month Master':
            shouldAward = uniqueDays.length >= 30;
            break;
        }

        if (shouldAward) {
          await awardBadge(session, userId, badge.id!);
        }
      }
    } catch (e) {
      session.log('Error checking and awarding badges: $e');
    }
  }

  Future<List<Badge>> getAllBadges(Session session) async {
    try {
      return await Badge.db.find(
        session,
        orderBy: (t) => t.name,
      );
    } catch (e) {
      session.log('Error getting all badges: $e');
      return [];
    }
  }

  Future<Badge> createBadge(
    Session session,
    String name,
    String description, {
    String? iconUrl,
    String? criteria,
  }) async {
    try {
      final badge = Badge(
        name: name,
        description: description,
        iconUrl: iconUrl,
        criteria: criteria,
      );

      await Badge.db.insertRow(session, badge);
      return badge;
    } catch (e) {
      session.log('Error creating badge: $e');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getLeaderboard(
    Session session, {
    String period = 'month',
    int limit = 10,
  }) async {
    try {
      DateTime startDate;
      switch (period) {
        case 'week':
          startDate = DateTime.now().subtract(Duration(days: 7));
          break;
        case 'month':
          startDate = DateTime(DateTime.now().year, DateTime.now().month, 1);
          break;
        case 'year':
          startDate = DateTime(DateTime.now().year, 1, 1);
          break;
        case 'all':
          startDate = DateTime(2000, 1, 1);
          break;
        default:
          startDate = DateTime.now().subtract(Duration(days: 30));
      }

      final scans = await Scan.db.find(
        session,
        where: (t) => t.createdAt > startDate,
      );

      Map<int, Map<String, dynamic>> userStats = {};
      
      for (var scan in scans) {
        if (!userStats.containsKey(scan.userId)) {
          final user = await User.db.findById(session, scan.userId);
          userStats[scan.userId] = {
            'userId': scan.userId,
            'email': user?.email ?? 'Unknown',
            'scanCount': 0,
            'totalDepositCents': 0,
          };
        }
        
        userStats[scan.userId]!['scanCount'] += 1;
        userStats[scan.userId]!['totalDepositCents'] += scan.depositCents ?? 0;
      }

      final leaderboard = userStats.values.toList();
      leaderboard.sort((a, b) => 
        b['totalDepositCents'].compareTo(a['totalDepositCents'])
      );

      return {
        'period': period,
        'startDate': startDate.toIso8601String(),
        'leaderboard': leaderboard.take(limit).toList(),
      };
    } catch (e) {
      session.log('Error getting leaderboard: $e');
      rethrow;
    }
  }
}