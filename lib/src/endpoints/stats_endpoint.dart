import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

class StatsEndpoint extends Endpoint {
  Future<StatsResult> totals(
    Session session, {
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final authInfo = await session.authenticated;
    if (authInfo == null) {
      throw Exception('User must be authenticated to view stats');
    }

    try {
      var whereClause = Scan.t.userId.equals(authInfo.userId);
      
      if (startDate != null) {
        whereClause = whereClause & (Scan.t.createdAt > startDate);
      }
      if (endDate != null) {
        whereClause = whereClause & (Scan.t.createdAt < endDate);
      }

      final scans = await Scan.db.find(
        session,
        where: (_) => whereClause,
      );

      int totalCount = scans.length;
      int totalDeposit = 0;
      
      for (var scan in scans) {
        totalDeposit += scan.depositCents ?? 0;
      }

      return StatsResult(
        count: totalCount,
        depositCents: totalDeposit,
      );
    } catch (e) {
      session.log('Error getting totals: $e');
      rethrow;
    }
  }

  Future<List<StatsBreakdown>> breakdown(
    Session session,
    String breakdownBy, {
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final authInfo = await session.authenticated;
    if (authInfo == null) {
      throw Exception('User must be authenticated to view stats');
    }

    try {
      var whereClause = Scan.t.userId.equals(authInfo.userId);
      
      if (startDate != null) {
        whereClause = whereClause & (Scan.t.createdAt > startDate);
      }
      if (endDate != null) {
        whereClause = whereClause & (Scan.t.createdAt < endDate);
      }

      final scans = await Scan.db.find(
        session,
        where: (_) => whereClause,
      );

      Map<String, StatsBreakdown> breakdownMap = {};

      for (var scan in scans) {
        String key = '';
        
        switch (breakdownBy) {
          case 'containerType':
            key = scan.containerType ?? 'Unknown';
            break;
          case 'month':
            key = '${scan.createdAt.year}-${scan.createdAt.month.toString().padLeft(2, '0')}';
            break;
          case 'location':
            if (scan.sessionId != null) {
              final returnSession = await ReturnSession.db.findById(session, scan.sessionId!);
              if (returnSession?.locationId != null) {
                final location = await Location.db.findById(session, returnSession!.locationId!);
                key = location?.name ?? 'Unknown Location';
              } else {
                key = 'No Location';
              }
            } else {
              key = 'No Session';
            }
            break;
          case 'brand':
            if (scan.productId != null) {
              final product = await Product.db.findById(session, scan.productId!);
              key = product?.brand ?? 'Unknown Brand';
            } else {
              key = 'Unknown Brand';
            }
            break;
          default:
            throw Exception('Invalid breakdown type');
        }

        if (!breakdownMap.containsKey(key)) {
          breakdownMap[key] = StatsBreakdown(
            label: key,
            count: 0,
            depositCents: 0,
          );
        }

        breakdownMap[key]!.count += 1;
        breakdownMap[key]!.depositCents += scan.depositCents ?? 0;
      }

      final results = breakdownMap.values.toList();
      results.sort((a, b) => b.depositCents.compareTo(a.depositCents));
      
      return results;
    } catch (e) {
      session.log('Error getting breakdown: $e');
      rethrow;
    }
  }

  Future<String> exportCSV(
    Session session, {
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final authInfo = await session.authenticated;
    if (authInfo == null) {
      throw Exception('User must be authenticated to export data');
    }

    try {
      var whereClause = Scan.t.userId.equals(authInfo.userId);
      
      if (startDate != null) {
        whereClause = whereClause & (Scan.t.createdAt > startDate);
      }
      if (endDate != null) {
        whereClause = whereClause & (Scan.t.createdAt < endDate);
      }

      final scans = await Scan.db.find(
        session,
        where: (_) => whereClause,
        orderBy: (t) => t.createdAt,
      );

      StringBuffer csv = StringBuffer();
      csv.writeln('Date,Barcode,Container Type,Volume (ml),Deposit (cents),Source');
      
      for (var scan in scans) {
        csv.writeln('${scan.createdAt.toIso8601String()},'
            '${scan.barcode},'
            '${scan.containerType ?? ""},'
            '${scan.volumeML ?? ""},'
            '${scan.depositCents ?? ""},'
            '${scan.source}');
      }

      return csv.toString();
    } catch (e) {
      session.log('Error exporting CSV: $e');
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

      // Using ORM approach for leaderboard
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
      
      var results = userStats.values.toList();
      results.sort((a, b) => b['totalDepositCents'].compareTo(a['totalDepositCents']));
      results = results.take(limit).toList();

      List<Map<String, dynamic>> leaderboard = results;

      return {
        'period': period,
        'startDate': startDate.toIso8601String(),
        'leaderboard': leaderboard,
      };
    } catch (e) {
      session.log('Error getting leaderboard: $e');
      rethrow;
    }
  }
}