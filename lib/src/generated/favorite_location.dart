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

abstract class FavoriteLocation
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  FavoriteLocation._({
    this.id,
    required this.userId,
    required this.locationId,
  });

  factory FavoriteLocation({
    int? id,
    required int userId,
    required int locationId,
  }) = _FavoriteLocationImpl;

  factory FavoriteLocation.fromJson(Map<String, dynamic> jsonSerialization) {
    return FavoriteLocation(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      locationId: jsonSerialization['locationId'] as int,
    );
  }

  static final t = FavoriteLocationTable();

  static const db = FavoriteLocationRepository._();

  @override
  int? id;

  int userId;

  int locationId;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [FavoriteLocation]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  FavoriteLocation copyWith({
    int? id,
    int? userId,
    int? locationId,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'userId': userId,
      'locationId': locationId,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'userId': userId,
      'locationId': locationId,
    };
  }

  static FavoriteLocationInclude include() {
    return FavoriteLocationInclude._();
  }

  static FavoriteLocationIncludeList includeList({
    _i1.WhereExpressionBuilder<FavoriteLocationTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<FavoriteLocationTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FavoriteLocationTable>? orderByList,
    FavoriteLocationInclude? include,
  }) {
    return FavoriteLocationIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(FavoriteLocation.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(FavoriteLocation.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FavoriteLocationImpl extends FavoriteLocation {
  _FavoriteLocationImpl({
    int? id,
    required int userId,
    required int locationId,
  }) : super._(
          id: id,
          userId: userId,
          locationId: locationId,
        );

  /// Returns a shallow copy of this [FavoriteLocation]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  FavoriteLocation copyWith({
    Object? id = _Undefined,
    int? userId,
    int? locationId,
  }) {
    return FavoriteLocation(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      locationId: locationId ?? this.locationId,
    );
  }
}

class FavoriteLocationTable extends _i1.Table<int?> {
  FavoriteLocationTable({super.tableRelation})
      : super(tableName: 'favorite_location') {
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    locationId = _i1.ColumnInt(
      'locationId',
      this,
    );
  }

  late final _i1.ColumnInt userId;

  late final _i1.ColumnInt locationId;

  @override
  List<_i1.Column> get columns => [
        id,
        userId,
        locationId,
      ];
}

class FavoriteLocationInclude extends _i1.IncludeObject {
  FavoriteLocationInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => FavoriteLocation.t;
}

class FavoriteLocationIncludeList extends _i1.IncludeList {
  FavoriteLocationIncludeList._({
    _i1.WhereExpressionBuilder<FavoriteLocationTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(FavoriteLocation.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => FavoriteLocation.t;
}

class FavoriteLocationRepository {
  const FavoriteLocationRepository._();

  /// Returns a list of [FavoriteLocation]s matching the given query parameters.
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
  Future<List<FavoriteLocation>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<FavoriteLocationTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<FavoriteLocationTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FavoriteLocationTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<FavoriteLocation>(
      where: where?.call(FavoriteLocation.t),
      orderBy: orderBy?.call(FavoriteLocation.t),
      orderByList: orderByList?.call(FavoriteLocation.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [FavoriteLocation] matching the given query parameters.
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
  Future<FavoriteLocation?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<FavoriteLocationTable>? where,
    int? offset,
    _i1.OrderByBuilder<FavoriteLocationTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FavoriteLocationTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<FavoriteLocation>(
      where: where?.call(FavoriteLocation.t),
      orderBy: orderBy?.call(FavoriteLocation.t),
      orderByList: orderByList?.call(FavoriteLocation.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [FavoriteLocation] by its [id] or null if no such row exists.
  Future<FavoriteLocation?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<FavoriteLocation>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [FavoriteLocation]s in the list and returns the inserted rows.
  ///
  /// The returned [FavoriteLocation]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<FavoriteLocation>> insert(
    _i1.Session session,
    List<FavoriteLocation> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<FavoriteLocation>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [FavoriteLocation] and returns the inserted row.
  ///
  /// The returned [FavoriteLocation] will have its `id` field set.
  Future<FavoriteLocation> insertRow(
    _i1.Session session,
    FavoriteLocation row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<FavoriteLocation>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [FavoriteLocation]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<FavoriteLocation>> update(
    _i1.Session session,
    List<FavoriteLocation> rows, {
    _i1.ColumnSelections<FavoriteLocationTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<FavoriteLocation>(
      rows,
      columns: columns?.call(FavoriteLocation.t),
      transaction: transaction,
    );
  }

  /// Updates a single [FavoriteLocation]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<FavoriteLocation> updateRow(
    _i1.Session session,
    FavoriteLocation row, {
    _i1.ColumnSelections<FavoriteLocationTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<FavoriteLocation>(
      row,
      columns: columns?.call(FavoriteLocation.t),
      transaction: transaction,
    );
  }

  /// Deletes all [FavoriteLocation]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<FavoriteLocation>> delete(
    _i1.Session session,
    List<FavoriteLocation> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<FavoriteLocation>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [FavoriteLocation].
  Future<FavoriteLocation> deleteRow(
    _i1.Session session,
    FavoriteLocation row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<FavoriteLocation>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<FavoriteLocation>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<FavoriteLocationTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<FavoriteLocation>(
      where: where(FavoriteLocation.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<FavoriteLocationTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<FavoriteLocation>(
      where: where?.call(FavoriteLocation.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
