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
import 'package:serverpod/protocol.dart' as _i2;
import 'package:serverpod_auth_server/serverpod_auth_server.dart' as _i3;
import 'greeting.dart' as _i4;
import 'auth_request.dart' as _i5;
import 'auth_response.dart' as _i6;
import 'badge.dart' as _i7;
import 'change_password_request.dart' as _i8;
import 'favorite_location.dart' as _i9;
import 'location.dart' as _i10;
import 'location_filter.dart' as _i11;
import 'location_report.dart' as _i12;
import 'pending_product.dart' as _i13;
import 'product.dart' as _i14;
import 'refresh_token_request.dart' as _i15;
import 'return_session.dart' as _i16;
import 'scan.dart' as _i17;
import 'scan_input.dart' as _i18;
import 'stats_breakdown.dart' as _i19;
import 'stats_result.dart' as _i20;
import 'user.dart' as _i21;
import 'user_badge.dart' as _i22;
import 'package:pfandler_backend_server/src/generated/product.dart' as _i23;
import 'package:pfandler_backend_server/src/generated/location.dart' as _i24;
import 'package:pfandler_backend_server/src/generated/favorite_location.dart'
    as _i25;
import 'package:pfandler_backend_server/src/generated/scan_input.dart' as _i26;
import 'package:pfandler_backend_server/src/generated/scan.dart' as _i27;
import 'package:pfandler_backend_server/src/generated/user_badge.dart' as _i28;
import 'package:pfandler_backend_server/src/generated/badge.dart' as _i29;
import 'package:pfandler_backend_server/src/generated/stats_breakdown.dart'
    as _i30;
export 'greeting.dart';
export 'auth_request.dart';
export 'auth_response.dart';
export 'badge.dart';
export 'change_password_request.dart';
export 'favorite_location.dart';
export 'location.dart';
export 'location_filter.dart';
export 'location_report.dart';
export 'pending_product.dart';
export 'product.dart';
export 'refresh_token_request.dart';
export 'return_session.dart';
export 'scan.dart';
export 'scan_input.dart';
export 'stats_breakdown.dart';
export 'stats_result.dart';
export 'user.dart';
export 'user_badge.dart';

class Protocol extends _i1.SerializationManagerServer {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._();

  static final List<_i2.TableDefinition> targetTableDefinitions = [
    _i2.TableDefinition(
      name: 'badge',
      dartName: 'Badge',
      schema: 'public',
      module: 'pfandler_backend',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'badge_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'description',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'iconUrl',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'criteria',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'badge_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'favorite_location',
      dartName: 'FavoriteLocation',
      schema: 'public',
      module: 'pfandler_backend',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'favorite_location_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'locationId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'favorite_location_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'favorite_location_unique_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'userId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'locationId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'location',
      dartName: 'Location',
      schema: 'public',
      module: 'pfandler_backend',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'location_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'type',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'lat',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'lng',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'address',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'googleMapsUrl',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'acceptsJson',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'openingHoursJson',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'location_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'location_coords_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'lat',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'lng',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'location_report',
      dartName: 'LocationReport',
      schema: 'public',
      module: 'pfandler_backend',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'location_report_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'locationId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'status',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'note',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'location_report_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'product',
      dartName: 'Product',
      schema: 'public',
      module: 'pfandler_backend',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'product_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'barcode',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'brand',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'volumeML',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'containerType',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'defaultDepositCents',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'verifiedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'communityConfidence',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: true,
          dartType: 'double?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'product_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'product_barcode_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'barcode',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'return_session',
      dartName: 'ReturnSession',
      schema: 'public',
      module: 'pfandler_backend',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'return_session_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'locationId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'startedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'endedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'totalDepositCents',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'note',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'return_session_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'return_session_user_started_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'userId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'startedAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'scan',
      dartName: 'Scan',
      schema: 'public',
      module: 'pfandler_backend',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'scan_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'sessionId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'productId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'barcode',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'volumeML',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'containerType',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'depositCents',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'source',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'scan_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'scan_user_created_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'userId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'createdAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'user',
      dartName: 'User',
      schema: 'public',
      module: 'pfandler_backend',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'user_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'email',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'passwordHash',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'salt',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'lastLoginAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'settingsJson',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'user_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'user_email_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'email',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'user_badge',
      dartName: 'UserBadge',
      schema: 'public',
      module: 'pfandler_backend',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'user_badge_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'badgeId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'awardedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'user_badge_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'user_badge_unique_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'userId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'badgeId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    ..._i3.Protocol.targetTableDefinitions,
    ..._i2.Protocol.targetTableDefinitions,
  ];

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;
    if (t == _i4.Greeting) {
      return _i4.Greeting.fromJson(data) as T;
    }
    if (t == _i5.AuthRequest) {
      return _i5.AuthRequest.fromJson(data) as T;
    }
    if (t == _i6.AuthResponse) {
      return _i6.AuthResponse.fromJson(data) as T;
    }
    if (t == _i7.Badge) {
      return _i7.Badge.fromJson(data) as T;
    }
    if (t == _i8.ChangePasswordRequest) {
      return _i8.ChangePasswordRequest.fromJson(data) as T;
    }
    if (t == _i9.FavoriteLocation) {
      return _i9.FavoriteLocation.fromJson(data) as T;
    }
    if (t == _i10.Location) {
      return _i10.Location.fromJson(data) as T;
    }
    if (t == _i11.LocationFilter) {
      return _i11.LocationFilter.fromJson(data) as T;
    }
    if (t == _i12.LocationReport) {
      return _i12.LocationReport.fromJson(data) as T;
    }
    if (t == _i13.PendingProduct) {
      return _i13.PendingProduct.fromJson(data) as T;
    }
    if (t == _i14.Product) {
      return _i14.Product.fromJson(data) as T;
    }
    if (t == _i15.RefreshTokenRequest) {
      return _i15.RefreshTokenRequest.fromJson(data) as T;
    }
    if (t == _i16.ReturnSession) {
      return _i16.ReturnSession.fromJson(data) as T;
    }
    if (t == _i17.Scan) {
      return _i17.Scan.fromJson(data) as T;
    }
    if (t == _i18.ScanInput) {
      return _i18.ScanInput.fromJson(data) as T;
    }
    if (t == _i19.StatsBreakdown) {
      return _i19.StatsBreakdown.fromJson(data) as T;
    }
    if (t == _i20.StatsResult) {
      return _i20.StatsResult.fromJson(data) as T;
    }
    if (t == _i21.User) {
      return _i21.User.fromJson(data) as T;
    }
    if (t == _i22.UserBadge) {
      return _i22.UserBadge.fromJson(data) as T;
    }
    if (t == _i1.getType<_i4.Greeting?>()) {
      return (data != null ? _i4.Greeting.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i5.AuthRequest?>()) {
      return (data != null ? _i5.AuthRequest.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.AuthResponse?>()) {
      return (data != null ? _i6.AuthResponse.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.Badge?>()) {
      return (data != null ? _i7.Badge.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.ChangePasswordRequest?>()) {
      return (data != null ? _i8.ChangePasswordRequest.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i9.FavoriteLocation?>()) {
      return (data != null ? _i9.FavoriteLocation.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i10.Location?>()) {
      return (data != null ? _i10.Location.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i11.LocationFilter?>()) {
      return (data != null ? _i11.LocationFilter.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i12.LocationReport?>()) {
      return (data != null ? _i12.LocationReport.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i13.PendingProduct?>()) {
      return (data != null ? _i13.PendingProduct.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i14.Product?>()) {
      return (data != null ? _i14.Product.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i15.RefreshTokenRequest?>()) {
      return (data != null ? _i15.RefreshTokenRequest.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i16.ReturnSession?>()) {
      return (data != null ? _i16.ReturnSession.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i17.Scan?>()) {
      return (data != null ? _i17.Scan.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i18.ScanInput?>()) {
      return (data != null ? _i18.ScanInput.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i19.StatsBreakdown?>()) {
      return (data != null ? _i19.StatsBreakdown.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i20.StatsResult?>()) {
      return (data != null ? _i20.StatsResult.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i21.User?>()) {
      return (data != null ? _i21.User.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i22.UserBadge?>()) {
      return (data != null ? _i22.UserBadge.fromJson(data) : null) as T;
    }
    if (t == List<_i23.Product>) {
      return (data as List).map((e) => deserialize<_i23.Product>(e)).toList()
          as T;
    }
    if (t == List<_i24.Location>) {
      return (data as List).map((e) => deserialize<_i24.Location>(e)).toList()
          as T;
    }
    if (t == List<_i25.FavoriteLocation>) {
      return (data as List)
          .map((e) => deserialize<_i25.FavoriteLocation>(e))
          .toList() as T;
    }
    if (t == Map<String, dynamic>) {
      return (data as Map).map((k, v) =>
          MapEntry(deserialize<String>(k), deserialize<dynamic>(v))) as T;
    }
    if (t == List<_i26.ScanInput>) {
      return (data as List).map((e) => deserialize<_i26.ScanInput>(e)).toList()
          as T;
    }
    if (t == List<_i27.Scan>) {
      return (data as List).map((e) => deserialize<_i27.Scan>(e)).toList() as T;
    }
    if (t == List<Map<String, dynamic>>) {
      return (data as List)
          .map((e) => deserialize<Map<String, dynamic>>(e))
          .toList() as T;
    }
    if (t == List<_i28.UserBadge>) {
      return (data as List).map((e) => deserialize<_i28.UserBadge>(e)).toList()
          as T;
    }
    if (t == List<_i29.Badge>) {
      return (data as List).map((e) => deserialize<_i29.Badge>(e)).toList()
          as T;
    }
    if (t == List<_i30.StatsBreakdown>) {
      return (data as List)
          .map((e) => deserialize<_i30.StatsBreakdown>(e))
          .toList() as T;
    }
    try {
      return _i3.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i2.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;
    if (data is _i4.Greeting) {
      return 'Greeting';
    }
    if (data is _i5.AuthRequest) {
      return 'AuthRequest';
    }
    if (data is _i6.AuthResponse) {
      return 'AuthResponse';
    }
    if (data is _i7.Badge) {
      return 'Badge';
    }
    if (data is _i8.ChangePasswordRequest) {
      return 'ChangePasswordRequest';
    }
    if (data is _i9.FavoriteLocation) {
      return 'FavoriteLocation';
    }
    if (data is _i10.Location) {
      return 'Location';
    }
    if (data is _i11.LocationFilter) {
      return 'LocationFilter';
    }
    if (data is _i12.LocationReport) {
      return 'LocationReport';
    }
    if (data is _i13.PendingProduct) {
      return 'PendingProduct';
    }
    if (data is _i14.Product) {
      return 'Product';
    }
    if (data is _i15.RefreshTokenRequest) {
      return 'RefreshTokenRequest';
    }
    if (data is _i16.ReturnSession) {
      return 'ReturnSession';
    }
    if (data is _i17.Scan) {
      return 'Scan';
    }
    if (data is _i18.ScanInput) {
      return 'ScanInput';
    }
    if (data is _i19.StatsBreakdown) {
      return 'StatsBreakdown';
    }
    if (data is _i20.StatsResult) {
      return 'StatsResult';
    }
    if (data is _i21.User) {
      return 'User';
    }
    if (data is _i22.UserBadge) {
      return 'UserBadge';
    }
    className = _i2.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod.$className';
    }
    className = _i3.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'Greeting') {
      return deserialize<_i4.Greeting>(data['data']);
    }
    if (dataClassName == 'AuthRequest') {
      return deserialize<_i5.AuthRequest>(data['data']);
    }
    if (dataClassName == 'AuthResponse') {
      return deserialize<_i6.AuthResponse>(data['data']);
    }
    if (dataClassName == 'Badge') {
      return deserialize<_i7.Badge>(data['data']);
    }
    if (dataClassName == 'ChangePasswordRequest') {
      return deserialize<_i8.ChangePasswordRequest>(data['data']);
    }
    if (dataClassName == 'FavoriteLocation') {
      return deserialize<_i9.FavoriteLocation>(data['data']);
    }
    if (dataClassName == 'Location') {
      return deserialize<_i10.Location>(data['data']);
    }
    if (dataClassName == 'LocationFilter') {
      return deserialize<_i11.LocationFilter>(data['data']);
    }
    if (dataClassName == 'LocationReport') {
      return deserialize<_i12.LocationReport>(data['data']);
    }
    if (dataClassName == 'PendingProduct') {
      return deserialize<_i13.PendingProduct>(data['data']);
    }
    if (dataClassName == 'Product') {
      return deserialize<_i14.Product>(data['data']);
    }
    if (dataClassName == 'RefreshTokenRequest') {
      return deserialize<_i15.RefreshTokenRequest>(data['data']);
    }
    if (dataClassName == 'ReturnSession') {
      return deserialize<_i16.ReturnSession>(data['data']);
    }
    if (dataClassName == 'Scan') {
      return deserialize<_i17.Scan>(data['data']);
    }
    if (dataClassName == 'ScanInput') {
      return deserialize<_i18.ScanInput>(data['data']);
    }
    if (dataClassName == 'StatsBreakdown') {
      return deserialize<_i19.StatsBreakdown>(data['data']);
    }
    if (dataClassName == 'StatsResult') {
      return deserialize<_i20.StatsResult>(data['data']);
    }
    if (dataClassName == 'User') {
      return deserialize<_i21.User>(data['data']);
    }
    if (dataClassName == 'UserBadge') {
      return deserialize<_i22.UserBadge>(data['data']);
    }
    if (dataClassName.startsWith('serverpod.')) {
      data['className'] = dataClassName.substring(10);
      return _i2.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth.')) {
      data['className'] = dataClassName.substring(15);
      return _i3.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  @override
  _i1.Table? getTableForType(Type t) {
    {
      var table = _i3.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _i2.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    switch (t) {
      case _i7.Badge:
        return _i7.Badge.t;
      case _i9.FavoriteLocation:
        return _i9.FavoriteLocation.t;
      case _i10.Location:
        return _i10.Location.t;
      case _i12.LocationReport:
        return _i12.LocationReport.t;
      case _i14.Product:
        return _i14.Product.t;
      case _i16.ReturnSession:
        return _i16.ReturnSession.t;
      case _i17.Scan:
        return _i17.Scan.t;
      case _i21.User:
        return _i21.User.t;
      case _i22.UserBadge:
        return _i22.UserBadge.t;
    }
    return null;
  }

  @override
  List<_i2.TableDefinition> getTargetTableDefinitions() =>
      targetTableDefinitions;

  @override
  String getModuleName() => 'pfandler_backend';
}
