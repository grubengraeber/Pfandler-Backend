/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;

abstract class ReturnSession
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  ReturnSession._({
    this.id,
    required this.userId,
    this.locationId,
    required this.startedAt,
    this.endedAt,
    this.totalDepositCents,
    this.note,
  });

  factory ReturnSession({
    int? id,
    required int userId,
    int? locationId,
    required DateTime startedAt,
    DateTime? endedAt,
    int? totalDepositCents,
    String? note,
  }) = _ReturnSessionImpl;

  factory ReturnSession.fromJson(Map<String, dynamic> jsonSerialization) {
    return ReturnSession(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      locationId: jsonSerialization['locationId'] as int?,
      startedAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['startedAt']),
      endedAt: jsonSerialization['endedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['endedAt']),
      totalDepositCents: jsonSerialization['totalDepositCents'] as int?,
      note: jsonSerialization['note'] as String?,
    );
  }

  static final t = ReturnSessionTable();

  static const db = ReturnSessionRepository._();

  @override
  int? id;

  int userId;

  int? locationId;

  DateTime startedAt;

  DateTime? endedAt;

  int? totalDepositCents;

  String? note;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [ReturnSession]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ReturnSession copyWith({
    int? id,
    int? userId,
    int? locationId,
    DateTime? startedAt,
    DateTime? endedAt,
    int? totalDepositCents,
    String? note,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'userId': userId,
      if (locationId != null) 'locationId': locationId,
      'startedAt': startedAt.toJson(),
      if (endedAt != null) 'endedAt': endedAt?.toJson(),
      if (totalDepositCents != null) 'totalDepositCents': totalDepositCents,
      if (note != null) 'note': note,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'userId': userId,
      if (locationId != null) 'locationId': locationId,
      'startedAt': startedAt.toJson(),
      if (endedAt != null) 'endedAt': endedAt?.toJson(),
      if (totalDepositCents != null) 'totalDepositCents': totalDepositCents,
      if (note != null) 'note': note,
    };
  }

  static ReturnSessionInclude include() {
    return ReturnSessionInclude._();
  }

  static ReturnSessionIncludeList includeList({
    _i1.WhereExpressionBuilder<ReturnSessionTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ReturnSessionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ReturnSessionTable>? orderByList,
    ReturnSessionInclude? include,
  }) {
    return ReturnSessionIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ReturnSession.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(ReturnSession.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ReturnSessionImpl extends ReturnSession {
  _ReturnSessionImpl({
    int? id,
    required int userId,
    int? locationId,
    required DateTime startedAt,
    DateTime? endedAt,
    int? totalDepositCents,
    String? note,
  }) : super._(
          id: id,
          userId: userId,
          locationId: locationId,
          startedAt: startedAt,
          endedAt: endedAt,
          totalDepositCents: totalDepositCents,
          note: note,
        );

  /// Returns a shallow copy of this [ReturnSession]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ReturnSession copyWith({
    Object? id = _Undefined,
    int? userId,
    Object? locationId = _Undefined,
    DateTime? startedAt,
    Object? endedAt = _Undefined,
    Object? totalDepositCents = _Undefined,
    Object? note = _Undefined,
  }) {
    return ReturnSession(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      locationId: locationId is int? ? locationId : this.locationId,
      startedAt: startedAt ?? this.startedAt,
      endedAt: endedAt is DateTime? ? endedAt : this.endedAt,
      totalDepositCents: totalDepositCents is int?
          ? totalDepositCents
          : this.totalDepositCents,
      note: note is String? ? note : this.note,
    );
  }
}

class ReturnSessionTable extends _i1.Table<int?> {
  ReturnSessionTable({super.tableRelation})
      : super(tableName: 'return_session') {
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    locationId = _i1.ColumnInt(
      'locationId',
      this,
    );
    startedAt = _i1.ColumnDateTime(
      'startedAt',
      this,
    );
    endedAt = _i1.ColumnDateTime(
      'endedAt',
      this,
    );
    totalDepositCents = _i1.ColumnInt(
      'totalDepositCents',
      this,
    );
    note = _i1.ColumnString(
      'note',
      this,
    );
  }

  late final _i1.ColumnInt userId;

  late final _i1.ColumnInt locationId;

  late final _i1.ColumnDateTime startedAt;

  late final _i1.ColumnDateTime endedAt;

  late final _i1.ColumnInt totalDepositCents;

  late final _i1.ColumnString note;

  @override
  List<_i1.Column> get columns => [
        id,
        userId,
        locationId,
        startedAt,
        endedAt,
        totalDepositCents,
        note,
      ];
}

class ReturnSessionInclude extends _i1.IncludeObject {
  ReturnSessionInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => ReturnSession.t;
}

class ReturnSessionIncludeList extends _i1.IncludeList {
  ReturnSessionIncludeList._({
    _i1.WhereExpressionBuilder<ReturnSessionTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ReturnSession.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => ReturnSession.t;
}

class ReturnSessionRepository {
  const ReturnSessionRepository._();

  /// Returns a list of [ReturnSession]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<ReturnSession>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ReturnSessionTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ReturnSessionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ReturnSessionTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<ReturnSession>(
      where: where?.call(ReturnSession.t),
      orderBy: orderBy?.call(ReturnSession.t),
      orderByList: orderByList?.call(ReturnSession.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [ReturnSession] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<ReturnSession?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ReturnSessionTable>? where,
    int? offset,
    _i1.OrderByBuilder<ReturnSessionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ReturnSessionTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<ReturnSession>(
      where: where?.call(ReturnSession.t),
      orderBy: orderBy?.call(ReturnSession.t),
      orderByList: orderByList?.call(ReturnSession.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [ReturnSession] by its [id] or null if no such row exists.
  Future<ReturnSession?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<ReturnSession>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [ReturnSession]s in the list and returns the inserted rows.
  ///
  /// The returned [ReturnSession]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<ReturnSession>> insert(
    _i1.Session session,
    List<ReturnSession> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<ReturnSession>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [ReturnSession] and returns the inserted row.
  ///
  /// The returned [ReturnSession] will have its `id` field set.
  Future<ReturnSession> insertRow(
    _i1.Session session,
    ReturnSession row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<ReturnSession>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [ReturnSession]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<ReturnSession>> update(
    _i1.Session session,
    List<ReturnSession> rows, {
    _i1.ColumnSelections<ReturnSessionTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<ReturnSession>(
      rows,
      columns: columns?.call(ReturnSession.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ReturnSession]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ReturnSession> updateRow(
    _i1.Session session,
    ReturnSession row, {
    _i1.ColumnSelections<ReturnSessionTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<ReturnSession>(
      row,
      columns: columns?.call(ReturnSession.t),
      transaction: transaction,
    );
  }

  /// Deletes all [ReturnSession]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<ReturnSession>> delete(
    _i1.Session session,
    List<ReturnSession> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<ReturnSession>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [ReturnSession].
  Future<ReturnSession> deleteRow(
    _i1.Session session,
    ReturnSession row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ReturnSession>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<ReturnSession>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<ReturnSessionTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<ReturnSession>(
      where: where(ReturnSession.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ReturnSessionTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<ReturnSession>(
      where: where?.call(ReturnSession.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
