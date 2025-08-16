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

abstract class Location
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Location._({
    this.id,
    required this.name,
    required this.type,
    required this.lat,
    required this.lng,
    this.address,
    this.googleMapsUrl,
    this.acceptsJson,
    this.openingHoursJson,
  });

  factory Location({
    int? id,
    required String name,
    required String type,
    required double lat,
    required double lng,
    String? address,
    String? googleMapsUrl,
    String? acceptsJson,
    String? openingHoursJson,
  }) = _LocationImpl;

  factory Location.fromJson(Map<String, dynamic> jsonSerialization) {
    return Location(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      type: jsonSerialization['type'] as String,
      lat: (jsonSerialization['lat'] as num).toDouble(),
      lng: (jsonSerialization['lng'] as num).toDouble(),
      address: jsonSerialization['address'] as String?,
      googleMapsUrl: jsonSerialization['googleMapsUrl'] as String?,
      acceptsJson: jsonSerialization['acceptsJson'] as String?,
      openingHoursJson: jsonSerialization['openingHoursJson'] as String?,
    );
  }

  static final t = LocationTable();

  static const db = LocationRepository._();

  @override
  int? id;

  String name;

  String type;

  double lat;

  double lng;

  String? address;

  String? googleMapsUrl;

  String? acceptsJson;

  String? openingHoursJson;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Location]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Location copyWith({
    int? id,
    String? name,
    String? type,
    double? lat,
    double? lng,
    String? address,
    String? googleMapsUrl,
    String? acceptsJson,
    String? openingHoursJson,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'type': type,
      'lat': lat,
      'lng': lng,
      if (address != null) 'address': address,
      if (googleMapsUrl != null) 'googleMapsUrl': googleMapsUrl,
      if (acceptsJson != null) 'acceptsJson': acceptsJson,
      if (openingHoursJson != null) 'openingHoursJson': openingHoursJson,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'type': type,
      'lat': lat,
      'lng': lng,
      if (address != null) 'address': address,
      if (googleMapsUrl != null) 'googleMapsUrl': googleMapsUrl,
      if (acceptsJson != null) 'acceptsJson': acceptsJson,
      if (openingHoursJson != null) 'openingHoursJson': openingHoursJson,
    };
  }

  static LocationInclude include() {
    return LocationInclude._();
  }

  static LocationIncludeList includeList({
    _i1.WhereExpressionBuilder<LocationTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<LocationTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<LocationTable>? orderByList,
    LocationInclude? include,
  }) {
    return LocationIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Location.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Location.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _LocationImpl extends Location {
  _LocationImpl({
    int? id,
    required String name,
    required String type,
    required double lat,
    required double lng,
    String? address,
    String? googleMapsUrl,
    String? acceptsJson,
    String? openingHoursJson,
  }) : super._(
          id: id,
          name: name,
          type: type,
          lat: lat,
          lng: lng,
          address: address,
          googleMapsUrl: googleMapsUrl,
          acceptsJson: acceptsJson,
          openingHoursJson: openingHoursJson,
        );

  /// Returns a shallow copy of this [Location]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Location copyWith({
    Object? id = _Undefined,
    String? name,
    String? type,
    double? lat,
    double? lng,
    Object? address = _Undefined,
    Object? googleMapsUrl = _Undefined,
    Object? acceptsJson = _Undefined,
    Object? openingHoursJson = _Undefined,
  }) {
    return Location(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      address: address is String? ? address : this.address,
      googleMapsUrl:
          googleMapsUrl is String? ? googleMapsUrl : this.googleMapsUrl,
      acceptsJson: acceptsJson is String? ? acceptsJson : this.acceptsJson,
      openingHoursJson: openingHoursJson is String?
          ? openingHoursJson
          : this.openingHoursJson,
    );
  }
}

class LocationTable extends _i1.Table<int?> {
  LocationTable({super.tableRelation}) : super(tableName: 'location') {
    name = _i1.ColumnString(
      'name',
      this,
    );
    type = _i1.ColumnString(
      'type',
      this,
    );
    lat = _i1.ColumnDouble(
      'lat',
      this,
    );
    lng = _i1.ColumnDouble(
      'lng',
      this,
    );
    address = _i1.ColumnString(
      'address',
      this,
    );
    googleMapsUrl = _i1.ColumnString(
      'googleMapsUrl',
      this,
    );
    acceptsJson = _i1.ColumnString(
      'acceptsJson',
      this,
    );
    openingHoursJson = _i1.ColumnString(
      'openingHoursJson',
      this,
    );
  }

  late final _i1.ColumnString name;

  late final _i1.ColumnString type;

  late final _i1.ColumnDouble lat;

  late final _i1.ColumnDouble lng;

  late final _i1.ColumnString address;

  late final _i1.ColumnString googleMapsUrl;

  late final _i1.ColumnString acceptsJson;

  late final _i1.ColumnString openingHoursJson;

  @override
  List<_i1.Column> get columns => [
        id,
        name,
        type,
        lat,
        lng,
        address,
        googleMapsUrl,
        acceptsJson,
        openingHoursJson,
      ];
}

class LocationInclude extends _i1.IncludeObject {
  LocationInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => Location.t;
}

class LocationIncludeList extends _i1.IncludeList {
  LocationIncludeList._({
    _i1.WhereExpressionBuilder<LocationTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Location.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Location.t;
}

class LocationRepository {
  const LocationRepository._();

  /// Returns a list of [Location]s matching the given query parameters.
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
  Future<List<Location>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<LocationTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<LocationTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<LocationTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<Location>(
      where: where?.call(Location.t),
      orderBy: orderBy?.call(Location.t),
      orderByList: orderByList?.call(Location.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [Location] matching the given query parameters.
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
  Future<Location?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<LocationTable>? where,
    int? offset,
    _i1.OrderByBuilder<LocationTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<LocationTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<Location>(
      where: where?.call(Location.t),
      orderBy: orderBy?.call(Location.t),
      orderByList: orderByList?.call(Location.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [Location] by its [id] or null if no such row exists.
  Future<Location?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<Location>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [Location]s in the list and returns the inserted rows.
  ///
  /// The returned [Location]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<Location>> insert(
    _i1.Session session,
    List<Location> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Location>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [Location] and returns the inserted row.
  ///
  /// The returned [Location] will have its `id` field set.
  Future<Location> insertRow(
    _i1.Session session,
    Location row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Location>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Location]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Location>> update(
    _i1.Session session,
    List<Location> rows, {
    _i1.ColumnSelections<LocationTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Location>(
      rows,
      columns: columns?.call(Location.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Location]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Location> updateRow(
    _i1.Session session,
    Location row, {
    _i1.ColumnSelections<LocationTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Location>(
      row,
      columns: columns?.call(Location.t),
      transaction: transaction,
    );
  }

  /// Deletes all [Location]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Location>> delete(
    _i1.Session session,
    List<Location> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Location>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Location].
  Future<Location> deleteRow(
    _i1.Session session,
    Location row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Location>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Location>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<LocationTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Location>(
      where: where(Location.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<LocationTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Location>(
      where: where?.call(Location.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
