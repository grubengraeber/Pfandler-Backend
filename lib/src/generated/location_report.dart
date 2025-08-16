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

abstract class LocationReport
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  LocationReport._({
    this.id,
    required this.locationId,
    required this.userId,
    required this.status,
    this.note,
    required this.createdAt,
  });

  factory LocationReport({
    int? id,
    required int locationId,
    required int userId,
    required String status,
    String? note,
    required DateTime createdAt,
  }) = _LocationReportImpl;

  factory LocationReport.fromJson(Map<String, dynamic> jsonSerialization) {
    return LocationReport(
      id: jsonSerialization['id'] as int?,
      locationId: jsonSerialization['locationId'] as int,
      userId: jsonSerialization['userId'] as int,
      status: jsonSerialization['status'] as String,
      note: jsonSerialization['note'] as String?,
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = LocationReportTable();

  static const db = LocationReportRepository._();

  @override
  int? id;

  int locationId;

  int userId;

  String status;

  String? note;

  DateTime createdAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [LocationReport]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  LocationReport copyWith({
    int? id,
    int? locationId,
    int? userId,
    String? status,
    String? note,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'locationId': locationId,
      'userId': userId,
      'status': status,
      if (note != null) 'note': note,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'locationId': locationId,
      'userId': userId,
      'status': status,
      if (note != null) 'note': note,
      'createdAt': createdAt.toJson(),
    };
  }

  static LocationReportInclude include() {
    return LocationReportInclude._();
  }

  static LocationReportIncludeList includeList({
    _i1.WhereExpressionBuilder<LocationReportTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<LocationReportTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<LocationReportTable>? orderByList,
    LocationReportInclude? include,
  }) {
    return LocationReportIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(LocationReport.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(LocationReport.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _LocationReportImpl extends LocationReport {
  _LocationReportImpl({
    int? id,
    required int locationId,
    required int userId,
    required String status,
    String? note,
    required DateTime createdAt,
  }) : super._(
          id: id,
          locationId: locationId,
          userId: userId,
          status: status,
          note: note,
          createdAt: createdAt,
        );

  /// Returns a shallow copy of this [LocationReport]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  LocationReport copyWith({
    Object? id = _Undefined,
    int? locationId,
    int? userId,
    String? status,
    Object? note = _Undefined,
    DateTime? createdAt,
  }) {
    return LocationReport(
      id: id is int? ? id : this.id,
      locationId: locationId ?? this.locationId,
      userId: userId ?? this.userId,
      status: status ?? this.status,
      note: note is String? ? note : this.note,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class LocationReportTable extends _i1.Table<int?> {
  LocationReportTable({super.tableRelation})
      : super(tableName: 'location_report') {
    locationId = _i1.ColumnInt(
      'locationId',
      this,
    );
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    status = _i1.ColumnString(
      'status',
      this,
    );
    note = _i1.ColumnString(
      'note',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final _i1.ColumnInt locationId;

  late final _i1.ColumnInt userId;

  late final _i1.ColumnString status;

  late final _i1.ColumnString note;

  late final _i1.ColumnDateTime createdAt;

  @override
  List<_i1.Column> get columns => [
        id,
        locationId,
        userId,
        status,
        note,
        createdAt,
      ];
}

class LocationReportInclude extends _i1.IncludeObject {
  LocationReportInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => LocationReport.t;
}

class LocationReportIncludeList extends _i1.IncludeList {
  LocationReportIncludeList._({
    _i1.WhereExpressionBuilder<LocationReportTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(LocationReport.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => LocationReport.t;
}

class LocationReportRepository {
  const LocationReportRepository._();

  /// Returns a list of [LocationReport]s matching the given query parameters.
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
  Future<List<LocationReport>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<LocationReportTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<LocationReportTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<LocationReportTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<LocationReport>(
      where: where?.call(LocationReport.t),
      orderBy: orderBy?.call(LocationReport.t),
      orderByList: orderByList?.call(LocationReport.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [LocationReport] matching the given query parameters.
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
  Future<LocationReport?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<LocationReportTable>? where,
    int? offset,
    _i1.OrderByBuilder<LocationReportTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<LocationReportTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<LocationReport>(
      where: where?.call(LocationReport.t),
      orderBy: orderBy?.call(LocationReport.t),
      orderByList: orderByList?.call(LocationReport.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [LocationReport] by its [id] or null if no such row exists.
  Future<LocationReport?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<LocationReport>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [LocationReport]s in the list and returns the inserted rows.
  ///
  /// The returned [LocationReport]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<LocationReport>> insert(
    _i1.Session session,
    List<LocationReport> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<LocationReport>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [LocationReport] and returns the inserted row.
  ///
  /// The returned [LocationReport] will have its `id` field set.
  Future<LocationReport> insertRow(
    _i1.Session session,
    LocationReport row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<LocationReport>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [LocationReport]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<LocationReport>> update(
    _i1.Session session,
    List<LocationReport> rows, {
    _i1.ColumnSelections<LocationReportTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<LocationReport>(
      rows,
      columns: columns?.call(LocationReport.t),
      transaction: transaction,
    );
  }

  /// Updates a single [LocationReport]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<LocationReport> updateRow(
    _i1.Session session,
    LocationReport row, {
    _i1.ColumnSelections<LocationReportTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<LocationReport>(
      row,
      columns: columns?.call(LocationReport.t),
      transaction: transaction,
    );
  }

  /// Deletes all [LocationReport]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<LocationReport>> delete(
    _i1.Session session,
    List<LocationReport> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<LocationReport>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [LocationReport].
  Future<LocationReport> deleteRow(
    _i1.Session session,
    LocationReport row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<LocationReport>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<LocationReport>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<LocationReportTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<LocationReport>(
      where: where(LocationReport.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<LocationReportTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<LocationReport>(
      where: where?.call(LocationReport.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
