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

abstract class Product
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Product._({
    this.id,
    required this.barcode,
    required this.name,
    this.brand,
    this.volumeML,
    this.containerType,
    this.defaultDepositCents,
    this.verifiedAt,
    this.communityConfidence,
  });

  factory Product({
    int? id,
    required String barcode,
    required String name,
    String? brand,
    int? volumeML,
    String? containerType,
    int? defaultDepositCents,
    DateTime? verifiedAt,
    double? communityConfidence,
  }) = _ProductImpl;

  factory Product.fromJson(Map<String, dynamic> jsonSerialization) {
    return Product(
      id: jsonSerialization['id'] as int?,
      barcode: jsonSerialization['barcode'] as String,
      name: jsonSerialization['name'] as String,
      brand: jsonSerialization['brand'] as String?,
      volumeML: jsonSerialization['volumeML'] as int?,
      containerType: jsonSerialization['containerType'] as String?,
      defaultDepositCents: jsonSerialization['defaultDepositCents'] as int?,
      verifiedAt: jsonSerialization['verifiedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['verifiedAt']),
      communityConfidence:
          (jsonSerialization['communityConfidence'] as num?)?.toDouble(),
    );
  }

  static final t = ProductTable();

  static const db = ProductRepository._();

  @override
  int? id;

  String barcode;

  String name;

  String? brand;

  int? volumeML;

  String? containerType;

  int? defaultDepositCents;

  DateTime? verifiedAt;

  double? communityConfidence;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Product]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Product copyWith({
    int? id,
    String? barcode,
    String? name,
    String? brand,
    int? volumeML,
    String? containerType,
    int? defaultDepositCents,
    DateTime? verifiedAt,
    double? communityConfidence,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'barcode': barcode,
      'name': name,
      if (brand != null) 'brand': brand,
      if (volumeML != null) 'volumeML': volumeML,
      if (containerType != null) 'containerType': containerType,
      if (defaultDepositCents != null)
        'defaultDepositCents': defaultDepositCents,
      if (verifiedAt != null) 'verifiedAt': verifiedAt?.toJson(),
      if (communityConfidence != null)
        'communityConfidence': communityConfidence,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'barcode': barcode,
      'name': name,
      if (brand != null) 'brand': brand,
      if (volumeML != null) 'volumeML': volumeML,
      if (containerType != null) 'containerType': containerType,
      if (defaultDepositCents != null)
        'defaultDepositCents': defaultDepositCents,
      if (verifiedAt != null) 'verifiedAt': verifiedAt?.toJson(),
      if (communityConfidence != null)
        'communityConfidence': communityConfidence,
    };
  }

  static ProductInclude include() {
    return ProductInclude._();
  }

  static ProductIncludeList includeList({
    _i1.WhereExpressionBuilder<ProductTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ProductTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ProductTable>? orderByList,
    ProductInclude? include,
  }) {
    return ProductIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Product.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Product.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ProductImpl extends Product {
  _ProductImpl({
    int? id,
    required String barcode,
    required String name,
    String? brand,
    int? volumeML,
    String? containerType,
    int? defaultDepositCents,
    DateTime? verifiedAt,
    double? communityConfidence,
  }) : super._(
          id: id,
          barcode: barcode,
          name: name,
          brand: brand,
          volumeML: volumeML,
          containerType: containerType,
          defaultDepositCents: defaultDepositCents,
          verifiedAt: verifiedAt,
          communityConfidence: communityConfidence,
        );

  /// Returns a shallow copy of this [Product]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Product copyWith({
    Object? id = _Undefined,
    String? barcode,
    String? name,
    Object? brand = _Undefined,
    Object? volumeML = _Undefined,
    Object? containerType = _Undefined,
    Object? defaultDepositCents = _Undefined,
    Object? verifiedAt = _Undefined,
    Object? communityConfidence = _Undefined,
  }) {
    return Product(
      id: id is int? ? id : this.id,
      barcode: barcode ?? this.barcode,
      name: name ?? this.name,
      brand: brand is String? ? brand : this.brand,
      volumeML: volumeML is int? ? volumeML : this.volumeML,
      containerType:
          containerType is String? ? containerType : this.containerType,
      defaultDepositCents: defaultDepositCents is int?
          ? defaultDepositCents
          : this.defaultDepositCents,
      verifiedAt: verifiedAt is DateTime? ? verifiedAt : this.verifiedAt,
      communityConfidence: communityConfidence is double?
          ? communityConfidence
          : this.communityConfidence,
    );
  }
}

class ProductTable extends _i1.Table<int?> {
  ProductTable({super.tableRelation}) : super(tableName: 'product') {
    barcode = _i1.ColumnString(
      'barcode',
      this,
    );
    name = _i1.ColumnString(
      'name',
      this,
    );
    brand = _i1.ColumnString(
      'brand',
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
    defaultDepositCents = _i1.ColumnInt(
      'defaultDepositCents',
      this,
    );
    verifiedAt = _i1.ColumnDateTime(
      'verifiedAt',
      this,
    );
    communityConfidence = _i1.ColumnDouble(
      'communityConfidence',
      this,
    );
  }

  late final _i1.ColumnString barcode;

  late final _i1.ColumnString name;

  late final _i1.ColumnString brand;

  late final _i1.ColumnInt volumeML;

  late final _i1.ColumnString containerType;

  late final _i1.ColumnInt defaultDepositCents;

  late final _i1.ColumnDateTime verifiedAt;

  late final _i1.ColumnDouble communityConfidence;

  @override
  List<_i1.Column> get columns => [
        id,
        barcode,
        name,
        brand,
        volumeML,
        containerType,
        defaultDepositCents,
        verifiedAt,
        communityConfidence,
      ];
}

class ProductInclude extends _i1.IncludeObject {
  ProductInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => Product.t;
}

class ProductIncludeList extends _i1.IncludeList {
  ProductIncludeList._({
    _i1.WhereExpressionBuilder<ProductTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Product.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Product.t;
}

class ProductRepository {
  const ProductRepository._();

  /// Returns a list of [Product]s matching the given query parameters.
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
  Future<List<Product>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ProductTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ProductTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ProductTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<Product>(
      where: where?.call(Product.t),
      orderBy: orderBy?.call(Product.t),
      orderByList: orderByList?.call(Product.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [Product] matching the given query parameters.
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
  Future<Product?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ProductTable>? where,
    int? offset,
    _i1.OrderByBuilder<ProductTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ProductTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<Product>(
      where: where?.call(Product.t),
      orderBy: orderBy?.call(Product.t),
      orderByList: orderByList?.call(Product.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [Product] by its [id] or null if no such row exists.
  Future<Product?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<Product>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [Product]s in the list and returns the inserted rows.
  ///
  /// The returned [Product]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<Product>> insert(
    _i1.Session session,
    List<Product> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Product>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [Product] and returns the inserted row.
  ///
  /// The returned [Product] will have its `id` field set.
  Future<Product> insertRow(
    _i1.Session session,
    Product row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Product>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Product]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Product>> update(
    _i1.Session session,
    List<Product> rows, {
    _i1.ColumnSelections<ProductTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Product>(
      rows,
      columns: columns?.call(Product.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Product]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Product> updateRow(
    _i1.Session session,
    Product row, {
    _i1.ColumnSelections<ProductTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Product>(
      row,
      columns: columns?.call(Product.t),
      transaction: transaction,
    );
  }

  /// Deletes all [Product]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Product>> delete(
    _i1.Session session,
    List<Product> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Product>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Product].
  Future<Product> deleteRow(
    _i1.Session session,
    Product row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Product>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Product>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<ProductTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Product>(
      where: where(Product.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ProductTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Product>(
      where: where?.call(Product.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
