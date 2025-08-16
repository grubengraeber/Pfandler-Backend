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

abstract class Scan implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Scan._({
    this.id,
    this.sessionId,
    required this.userId,
    this.productId,
    required this.barcode,
    this.volumeML,
    this.containerType,
    this.depositCents,
    required this.createdAt,
    required this.source,
  });

  factory Scan({
    int? id,
    int? sessionId,
    required int userId,
    int? productId,
    required String barcode,
    int? volumeML,
    String? containerType,
    int? depositCents,
    required DateTime createdAt,
    required String source,
  }) = _ScanImpl;

  factory Scan.fromJson(Map<String, dynamic> jsonSerialization) {
    return Scan(
      id: jsonSerialization['id'] as int?,
      sessionId: jsonSerialization['sessionId'] as int?,
      userId: jsonSerialization['userId'] as int,
      productId: jsonSerialization['productId'] as int?,
      barcode: jsonSerialization['barcode'] as String,
      volumeML: jsonSerialization['volumeML'] as int?,
      containerType: jsonSerialization['containerType'] as String?,
      depositCents: jsonSerialization['depositCents'] as int?,
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      source: jsonSerialization['source'] as String,
    );
  }

  static final t = ScanTable();

  static const db = ScanRepository._();

  @override
  int? id;

  int? sessionId;

  int userId;

  int? productId;

  String barcode;

  int? volumeML;

  String? containerType;

  int? depositCents;

  DateTime createdAt;

  String source;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Scan]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Scan copyWith({
    int? id,
    int? sessionId,
    int? userId,
    int? productId,
    String? barcode,
    int? volumeML,
    String? containerType,
    int? depositCents,
    DateTime? createdAt,
    String? source,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (sessionId != null) 'sessionId': sessionId,
      'userId': userId,
      if (productId != null) 'productId': productId,
      'barcode': barcode,
      if (volumeML != null) 'volumeML': volumeML,
      if (containerType != null) 'containerType': containerType,
      if (depositCents != null) 'depositCents': depositCents,
      'createdAt': createdAt.toJson(),
      'source': source,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      if (sessionId != null) 'sessionId': sessionId,
      'userId': userId,
      if (productId != null) 'productId': productId,
      'barcode': barcode,
      if (volumeML != null) 'volumeML': volumeML,
      if (containerType != null) 'containerType': containerType,
      if (depositCents != null) 'depositCents': depositCents,
      'createdAt': createdAt.toJson(),
      'source': source,
    };
  }

  static ScanInclude include() {
    return ScanInclude._();
  }

  static ScanIncludeList includeList({
    _i1.WhereExpressionBuilder<ScanTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ScanTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ScanTable>? orderByList,
    ScanInclude? include,
  }) {
    return ScanIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Scan.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Scan.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ScanImpl extends Scan {
  _ScanImpl({
    int? id,
    int? sessionId,
    required int userId,
    int? productId,
    required String barcode,
    int? volumeML,
    String? containerType,
    int? depositCents,
    required DateTime createdAt,
    required String source,
  }) : super._(
          id: id,
          sessionId: sessionId,
          userId: userId,
          productId: productId,
          barcode: barcode,
          volumeML: volumeML,
          containerType: containerType,
          depositCents: depositCents,
          createdAt: createdAt,
          source: source,
        );

  /// Returns a shallow copy of this [Scan]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Scan copyWith({
    Object? id = _Undefined,
    Object? sessionId = _Undefined,
    int? userId,
    Object? productId = _Undefined,
    String? barcode,
    Object? volumeML = _Undefined,
    Object? containerType = _Undefined,
    Object? depositCents = _Undefined,
    DateTime? createdAt,
    String? source,
  }) {
    return Scan(
      id: id is int? ? id : this.id,
      sessionId: sessionId is int? ? sessionId : this.sessionId,
      userId: userId ?? this.userId,
      productId: productId is int? ? productId : this.productId,
      barcode: barcode ?? this.barcode,
      volumeML: volumeML is int? ? volumeML : this.volumeML,
      containerType:
          containerType is String? ? containerType : this.containerType,
      depositCents: depositCents is int? ? depositCents : this.depositCents,
      createdAt: createdAt ?? this.createdAt,
      source: source ?? this.source,
    );
  }
}

class ScanTable extends _i1.Table<int?> {
  ScanTable({super.tableRelation}) : super(tableName: 'scan') {
    sessionId = _i1.ColumnInt(
      'sessionId',
      this,
    );
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    productId = _i1.ColumnInt(
      'productId',
      this,
    );
    barcode = _i1.ColumnString(
      'barcode',
      this,
    );
    volumeML = _i1.ColumnInt(
      'volumeML',
      this,
    );
    containerType = _i1.ColumnString(
      'containerType',
      this,
    );
    depositCents = _i1.ColumnInt(
      'depositCents',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
    source = _i1.ColumnString(
      'source',
      this,
    );
  }

  late final _i1.ColumnInt sessionId;

  late final _i1.ColumnInt userId;

  late final _i1.ColumnInt productId;

  late final _i1.ColumnString barcode;

  late final _i1.ColumnInt volumeML;

  late final _i1.ColumnString containerType;

  late final _i1.ColumnInt depositCents;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnString source;

  @override
  List<_i1.Column> get columns => [
        id,
        sessionId,
        userId,
        productId,
        barcode,
        volumeML,
        containerType,
        depositCents,
        createdAt,
        source,
      ];
}

class ScanInclude extends _i1.IncludeObject {
  ScanInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => Scan.t;
}

class ScanIncludeList extends _i1.IncludeList {
  ScanIncludeList._({
    _i1.WhereExpressionBuilder<ScanTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Scan.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Scan.t;
}

class ScanRepository {
  const ScanRepository._();

  /// Returns a list of [Scan]s matching the given query parameters.
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
  Future<List<Scan>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ScanTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ScanTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ScanTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<Scan>(
      where: where?.call(Scan.t),
      orderBy: orderBy?.call(Scan.t),
      orderByList: orderByList?.call(Scan.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [Scan] matching the given query parameters.
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
  Future<Scan?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ScanTable>? where,
    int? offset,
    _i1.OrderByBuilder<ScanTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ScanTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<Scan>(
      where: where?.call(Scan.t),
      orderBy: orderBy?.call(Scan.t),
      orderByList: orderByList?.call(Scan.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [Scan] by its [id] or null if no such row exists.
  Future<Scan?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<Scan>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [Scan]s in the list and returns the inserted rows.
  ///
  /// The returned [Scan]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<Scan>> insert(
    _i1.Session session,
    List<Scan> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Scan>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [Scan] and returns the inserted row.
  ///
  /// The returned [Scan] will have its `id` field set.
  Future<Scan> insertRow(
    _i1.Session session,
    Scan row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Scan>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Scan]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Scan>> update(
    _i1.Session session,
    List<Scan> rows, {
    _i1.ColumnSelections<ScanTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Scan>(
      rows,
      columns: columns?.call(Scan.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Scan]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Scan> updateRow(
    _i1.Session session,
    Scan row, {
    _i1.ColumnSelections<ScanTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Scan>(
      row,
      columns: columns?.call(Scan.t),
      transaction: transaction,
    );
  }

  /// Deletes all [Scan]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Scan>> delete(
    _i1.Session session,
    List<Scan> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Scan>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Scan].
  Future<Scan> deleteRow(
    _i1.Session session,
    Scan row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Scan>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Scan>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<ScanTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Scan>(
      where: where(Scan.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ScanTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Scan>(
      where: where?.call(Scan.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
