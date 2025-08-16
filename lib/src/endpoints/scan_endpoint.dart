import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

class ScanEndpoint extends Endpoint {
  Future<Scan> recordScan(
    Session session,
    ScanInput scanInput,
  ) async {
    final authInfo = await session.authenticated;
    if (authInfo == null) {
      throw Exception('User must be authenticated to record scans');
    }

    try {
      Product? product = await Product.db.findFirstRow(
        session,
        where: (t) => t.barcode.equals(scanInput.barcode),
      );

      final scan = Scan(
        sessionId: scanInput.sessionId,
        userId: authInfo.userId,
        productId: product?.id,
        barcode: scanInput.barcode,
        volumeML: scanInput.volumeML ?? product?.volumeML,
        containerType: scanInput.containerType ?? product?.containerType,
        depositCents: scanInput.depositCents ?? product?.defaultDepositCents,
        createdAt: DateTime.now(),
        source: scanInput.source,
      );

      await Scan.db.insertRow(session, scan);

      if (scanInput.sessionId != null) {
        await _updateSessionTotal(session, scanInput.sessionId!);
      }

      return scan;
    } catch (e) {
      session.log('Error recording scan: $e');
      rethrow;
    }
  }

  Future<ReturnSession> startSession(
    Session session, {
    int? locationId,
  }) async {
    final authInfo = await session.authenticated;
    if (authInfo == null) {
      throw Exception('User must be authenticated to start sessions');
    }

    try {
      final activeSession = await ReturnSession.db.findFirstRow(
        session,
        where: (t) => t.userId.equals(authInfo.userId) & t.endedAt.equals(null),
      );

      if (activeSession != null) {
        throw Exception('User already has an active session');
      }

      final returnSession = ReturnSession(
        userId: authInfo.userId,
        locationId: locationId,
        startedAt: DateTime.now(),
        totalDepositCents: 0,
      );

      await ReturnSession.db.insertRow(session, returnSession);
      return returnSession;
    } catch (e) {
      session.log('Error starting session: $e');
      rethrow;
    }
  }

  Future<ReturnSession> endSession(
    Session session,
    int sessionId,
  ) async {
    final authInfo = await session.authenticated;
    if (authInfo == null) {
      throw Exception('User must be authenticated to end sessions');
    }

    try {
      final returnSession = await ReturnSession.db.findById(session, sessionId);
      if (returnSession == null) {
        throw Exception('Session not found');
      }

      if (returnSession.userId != authInfo.userId) {
        throw Exception('Unauthorized to end this session');
      }

      if (returnSession.endedAt != null) {
        throw Exception('Session already ended');
      }

      returnSession.endedAt = DateTime.now();
      await _updateSessionTotal(session, sessionId);
      
      final updatedSession = await ReturnSession.db.findById(session, sessionId);
      return updatedSession!;
    } catch (e) {
      session.log('Error ending session: $e');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> bulkUpload(
    Session session,
    List<ScanInput> scans,
  ) async {
    final authInfo = await session.authenticated;
    if (authInfo == null) {
      throw Exception('User must be authenticated to bulk upload scans');
    }

    int successCount = 0;
    List<String> errors = [];

    for (var scanInput in scans) {
      try {
        await recordScan(session, scanInput);
        successCount++;
      } catch (e) {
        errors.add('Error processing barcode ${scanInput.barcode}: $e');
      }
    }

    return {
      'success': successCount,
      'failed': errors.length,
      'errors': errors,
    };
  }

  Future<List<Scan>> getUserScans(
    Session session, {
    int limit = 50,
    int offset = 0,
  }) async {
    final authInfo = await session.authenticated;
    if (authInfo == null) {
      throw Exception('User must be authenticated to view scans');
    }

    try {
      return await Scan.db.find(
        session,
        where: (t) => t.userId.equals(authInfo.userId),
        limit: limit,
        offset: offset,
        orderBy: (t) => t.createdAt,
        orderDescending: true,
      );
    } catch (e) {
      session.log('Error getting user scans: $e');
      return [];
    }
  }

  Future<void> _updateSessionTotal(Session session, int sessionId) async {
    final scans = await Scan.db.find(
      session,
      where: (t) => t.sessionId.equals(sessionId),
    );

    int total = 0;
    for (var scan in scans) {
      total += scan.depositCents ?? 0;
    }

    final returnSession = await ReturnSession.db.findById(session, sessionId);
    if (returnSession != null) {
      returnSession.totalDepositCents = total;
      await ReturnSession.db.updateRow(session, returnSession);
    }
  }
}