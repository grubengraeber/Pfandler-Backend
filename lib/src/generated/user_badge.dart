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

abstract class UserBadge
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  UserBadge._({
    this.id,
    required this.userId,
    required this.badgeId,
    required this.awardedAt,
  });

  factory UserBadge({
    int? id,
    required int userId,
    required int badgeId,
    required DateTime awardedAt,
  }) = _UserBadgeImpl;

  factory UserBadge.fromJson(Map<String, dynamic> jsonSerialization) {
    return UserBadge(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      badgeId: jsonSerialization['badgeId'] as int,
      awardedAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['awardedAt']),
    );
  }

  static final t = UserBadgeTable();

  static const db = UserBadgeRepository._();

  @override
  int? id;

  int userId;

  int badgeId;

  DateTime awardedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [UserBadge]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  UserBadge copyWith({
    int? id,
    int? userId,
    int? badgeId,
    DateTime? awardedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'userId': userId,
      'badgeId': badgeId,
      'awardedAt': awardedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'userId': userId,
      'badgeId': badgeId,
      'awardedAt': awardedAt.toJson(),
    };
  }

  static UserBadgeInclude include() {
    return UserBadgeInclude._();
  }

  static UserBadgeIncludeList includeList({
    _i1.WhereExpressionBuilder<UserBadgeTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<UserBadgeTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserBadgeTable>? orderByList,
    UserBadgeInclude? include,
  }) {
    return UserBadgeIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(UserBadge.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(UserBadge.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UserBadgeImpl extends UserBadge {
  _UserBadgeImpl({
    int? id,
    required int userId,
    required int badgeId,
    required DateTime awardedAt,
  }) : super._(
          id: id,
          userId: userId,
          badgeId: badgeId,
          awardedAt: awardedAt,
        );

  /// Returns a shallow copy of this [UserBadge]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  UserBadge copyWith({
    Object? id = _Undefined,
    int? userId,
    int? badgeId,
    DateTime? awardedAt,
  }) {
    return UserBadge(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      badgeId: badgeId ?? this.badgeId,
      awardedAt: awardedAt ?? this.awardedAt,
    );
  }
}

class UserBadgeTable extends _i1.Table<int?> {
  UserBadgeTable({super.tableRelation}) : super(tableName: 'user_badge') {
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    badgeId = _i1.ColumnInt(
      'badgeId',
      this,
    );
    awardedAt = _i1.ColumnDateTime(
      'awardedAt',
      this,
    );
  }

  late final _i1.ColumnInt userId;

  late final _i1.ColumnInt badgeId;

  late final _i1.ColumnDateTime awardedAt;

  @override
  List<_i1.Column> get columns => [
        id,
        userId,
        badgeId,
        awardedAt,
      ];
}

class UserBadgeInclude extends _i1.IncludeObject {
  UserBadgeInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => UserBadge.t;
}

class UserBadgeIncludeList extends _i1.IncludeList {
  UserBadgeIncludeList._({
    _i1.WhereExpressionBuilder<UserBadgeTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(UserBadge.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => UserBadge.t;
}

class UserBadgeRepository {
  const UserBadgeRepository._();

  /// Returns a list of [UserBadge]s matching the given query parameters.
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
  Future<List<UserBadge>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<UserBadgeTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<UserBadgeTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserBadgeTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<UserBadge>(
      where: where?.call(UserBadge.t),
      orderBy: orderBy?.call(UserBadge.t),
      orderByList: orderByList?.call(UserBadge.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [UserBadge] matching the given query parameters.
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
  Future<UserBadge?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<UserBadgeTable>? where,
    int? offset,
    _i1.OrderByBuilder<UserBadgeTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserBadgeTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<UserBadge>(
      where: where?.call(UserBadge.t),
      orderBy: orderBy?.call(UserBadge.t),
      orderByList: orderByList?.call(UserBadge.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [UserBadge] by its [id] or null if no such row exists.
  Future<UserBadge?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<UserBadge>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [UserBadge]s in the list and returns the inserted rows.
  ///
  /// The returned [UserBadge]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<UserBadge>> insert(
    _i1.Session session,
    List<UserBadge> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<UserBadge>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [UserBadge] and returns the inserted row.
  ///
  /// The returned [UserBadge] will have its `id` field set.
  Future<UserBadge> insertRow(
    _i1.Session session,
    UserBadge row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<UserBadge>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [UserBadge]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<UserBadge>> update(
    _i1.Session session,
    List<UserBadge> rows, {
    _i1.ColumnSelections<UserBadgeTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<UserBadge>(
      rows,
      columns: columns?.call(UserBadge.t),
      transaction: transaction,
    );
  }

  /// Updates a single [UserBadge]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<UserBadge> updateRow(
    _i1.Session session,
    UserBadge row, {
    _i1.ColumnSelections<UserBadgeTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<UserBadge>(
      row,
      columns: columns?.call(UserBadge.t),
      transaction: transaction,
    );
  }

  /// Deletes all [UserBadge]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<UserBadge>> delete(
    _i1.Session session,
    List<UserBadge> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<UserBadge>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [UserBadge].
  Future<UserBadge> deleteRow(
    _i1.Session session,
    UserBadge row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<UserBadge>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<UserBadge>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<UserBadgeTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<UserBadge>(
      where: where(UserBadge.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<UserBadgeTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<UserBadge>(
      where: where?.call(UserBadge.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
