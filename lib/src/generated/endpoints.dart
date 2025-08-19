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
import '../endpoints/auth_endpoint.dart' as _i2;
import '../endpoints/catalog_endpoint.dart' as _i3;
import '../endpoints/location_endpoint.dart' as _i4;
import '../endpoints/scan_endpoint.dart' as _i5;
import '../endpoints/social_endpoint.dart' as _i6;
import '../endpoints/stats_endpoint.dart' as _i7;
import '../greeting_endpoint.dart' as _i8;
import 'package:pfandler_backend_server/src/generated/auth_request.dart' as _i9;
import 'package:pfandler_backend_server/src/generated/refresh_token_request.dart'
    as _i10;
import 'package:pfandler_backend_server/src/generated/change_password_request.dart'
    as _i11;
import 'package:pfandler_backend_server/src/generated/pending_product.dart'
    as _i12;
import 'package:pfandler_backend_server/src/generated/location_filter.dart'
    as _i13;
import 'package:pfandler_backend_server/src/generated/location.dart' as _i14;
import 'package:pfandler_backend_server/src/generated/scan_input.dart' as _i15;
import 'package:serverpod_auth_server/serverpod_auth_server.dart' as _i16;

class Endpoints extends _i1.EndpointDispatch {
  @override
  void initializeEndpoints(_i1.Server server) {
    var endpoints = <String, _i1.Endpoint>{
      'auth': _i2.AuthEndpoint()
        ..initialize(
          server,
          'auth',
          null,
        ),
      'catalog': _i3.CatalogEndpoint()
        ..initialize(
          server,
          'catalog',
          null,
        ),
      'location': _i4.LocationEndpoint()
        ..initialize(
          server,
          'location',
          null,
        ),
      'scan': _i5.ScanEndpoint()
        ..initialize(
          server,
          'scan',
          null,
        ),
      'social': _i6.SocialEndpoint()
        ..initialize(
          server,
          'social',
          null,
        ),
      'stats': _i7.StatsEndpoint()
        ..initialize(
          server,
          'stats',
          null,
        ),
      'greeting': _i8.GreetingEndpoint()
        ..initialize(
          server,
          'greeting',
          null,
        ),
    };
    connectors['auth'] = _i1.EndpointConnector(
      name: 'auth',
      endpoint: endpoints['auth']!,
      methodConnectors: {
        'registerWithEmail': _i1.MethodConnector(
          name: 'registerWithEmail',
          params: {
            'request': _i1.ParameterDescription(
              name: 'request',
              type: _i1.getType<_i9.AuthRequest>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['auth'] as _i2.AuthEndpoint).registerWithEmail(
            session,
            params['request'],
          ),
        ),
        'loginWithEmail': _i1.MethodConnector(
          name: 'loginWithEmail',
          params: {
            'request': _i1.ParameterDescription(
              name: 'request',
              type: _i1.getType<_i9.AuthRequest>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['auth'] as _i2.AuthEndpoint).loginWithEmail(
            session,
            params['request'],
          ),
        ),
        'refreshToken': _i1.MethodConnector(
          name: 'refreshToken',
          params: {
            'request': _i1.ParameterDescription(
              name: 'request',
              type: _i1.getType<_i10.RefreshTokenRequest>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['auth'] as _i2.AuthEndpoint).refreshToken(
            session,
            params['request'],
          ),
        ),
        'getCurrentUser': _i1.MethodConnector(
          name: 'getCurrentUser',
          params: {
            'token': _i1.ParameterDescription(
              name: 'token',
              type: _i1.getType<String>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['auth'] as _i2.AuthEndpoint).getCurrentUser(
            session,
            params['token'],
          ),
        ),
        'linkDevice': _i1.MethodConnector(
          name: 'linkDevice',
          params: {
            'token': _i1.ParameterDescription(
              name: 'token',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'deviceId': _i1.ParameterDescription(
              name: 'deviceId',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'deviceName': _i1.ParameterDescription(
              name: 'deviceName',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['auth'] as _i2.AuthEndpoint).linkDevice(
            session,
            params['token'],
            params['deviceId'],
            params['deviceName'],
          ),
        ),
        'logout': _i1.MethodConnector(
          name: 'logout',
          params: {
            'token': _i1.ParameterDescription(
              name: 'token',
              type: _i1.getType<String>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['auth'] as _i2.AuthEndpoint).logout(
            session,
            params['token'],
          ),
        ),
        'changePassword': _i1.MethodConnector(
          name: 'changePassword',
          params: {
            'request': _i1.ParameterDescription(
              name: 'request',
              type: _i1.getType<_i11.ChangePasswordRequest>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['auth'] as _i2.AuthEndpoint).changePassword(
            session,
            params['request'],
          ),
        ),
      },
    );
    connectors['catalog'] = _i1.EndpointConnector(
      name: 'catalog',
      endpoint: endpoints['catalog']!,
      methodConnectors: {
        'getProductByBarcode': _i1.MethodConnector(
          name: 'getProductByBarcode',
          params: {
            'barcode': _i1.ParameterDescription(
              name: 'barcode',
              type: _i1.getType<String>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['catalog'] as _i3.CatalogEndpoint).getProductByBarcode(
            session,
            params['barcode'],
          ),
        ),
        'suggestProduct': _i1.MethodConnector(
          name: 'suggestProduct',
          params: {
            'data': _i1.ParameterDescription(
              name: 'data',
              type: _i1.getType<_i12.PendingProduct>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['catalog'] as _i3.CatalogEndpoint).suggestProduct(
            session,
            params['data'],
          ),
        ),
        'searchProducts': _i1.MethodConnector(
          name: 'searchProducts',
          params: {
            'query': _i1.ParameterDescription(
              name: 'query',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'offset': _i1.ParameterDescription(
              name: 'offset',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['catalog'] as _i3.CatalogEndpoint).searchProducts(
            session,
            params['query'],
            limit: params['limit'],
            offset: params['offset'],
          ),
        ),
        'verifyProduct': _i1.MethodConnector(
          name: 'verifyProduct',
          params: {
            'productId': _i1.ParameterDescription(
              name: 'productId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['catalog'] as _i3.CatalogEndpoint).verifyProduct(
            session,
            params['productId'],
          ),
        ),
        'lookupProductExternal': _i1.MethodConnector(
          name: 'lookupProductExternal',
          params: {
            'barcode': _i1.ParameterDescription(
              name: 'barcode',
              type: _i1.getType<String>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['catalog'] as _i3.CatalogEndpoint)
                  .lookupProductExternal(
            session,
            params['barcode'],
          ),
        ),
        'enrichProductData': _i1.MethodConnector(
          name: 'enrichProductData',
          params: {
            'productId': _i1.ParameterDescription(
              name: 'productId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['catalog'] as _i3.CatalogEndpoint).enrichProductData(
            session,
            params['productId'],
          ),
        ),
      },
    );
    connectors['location'] = _i1.EndpointConnector(
      name: 'location',
      endpoint: endpoints['location']!,
      methodConnectors: {
        'findNearbyLocations': _i1.MethodConnector(
          name: 'findNearbyLocations',
          params: {
            'latitude': _i1.ParameterDescription(
              name: 'latitude',
              type: _i1.getType<double>(),
              nullable: false,
            ),
            'longitude': _i1.ParameterDescription(
              name: 'longitude',
              type: _i1.getType<double>(),
              nullable: false,
            ),
            'maxDistance': _i1.ParameterDescription(
              name: 'maxDistance',
              type: _i1.getType<double?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['location'] as _i4.LocationEndpoint)
                  .findNearbyLocations(
            session,
            params['latitude'],
            params['longitude'],
            maxDistance: params['maxDistance'],
          ),
        ),
        'nearby': _i1.MethodConnector(
          name: 'nearby',
          params: {
            'lat': _i1.ParameterDescription(
              name: 'lat',
              type: _i1.getType<double>(),
              nullable: false,
            ),
            'lng': _i1.ParameterDescription(
              name: 'lng',
              type: _i1.getType<double>(),
              nullable: false,
            ),
            'filters': _i1.ParameterDescription(
              name: 'filters',
              type: _i1.getType<_i13.LocationFilter?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['location'] as _i4.LocationEndpoint).nearby(
            session,
            params['lat'],
            params['lng'],
            filters: params['filters'],
          ),
        ),
        'searchAllAustria': _i1.MethodConnector(
          name: 'searchAllAustria',
          params: {
            'lat': _i1.ParameterDescription(
              name: 'lat',
              type: _i1.getType<double>(),
              nullable: false,
            ),
            'lng': _i1.ParameterDescription(
              name: 'lng',
              type: _i1.getType<double>(),
              nullable: false,
            ),
            'filters': _i1.ParameterDescription(
              name: 'filters',
              type: _i1.getType<_i13.LocationFilter?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['location'] as _i4.LocationEndpoint).searchAllAustria(
            session,
            params['lat'],
            params['lng'],
            filters: params['filters'],
          ),
        ),
        'reportStatus': _i1.MethodConnector(
          name: 'reportStatus',
          params: {
            'locationId': _i1.ParameterDescription(
              name: 'locationId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'status': _i1.ParameterDescription(
              name: 'status',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'note': _i1.ParameterDescription(
              name: 'note',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['location'] as _i4.LocationEndpoint).reportStatus(
            session,
            params['locationId'],
            params['status'],
            note: params['note'],
          ),
        ),
        'addLocation': _i1.MethodConnector(
          name: 'addLocation',
          params: {
            'suggestedLocation': _i1.ParameterDescription(
              name: 'suggestedLocation',
              type: _i1.getType<_i14.Location>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['location'] as _i4.LocationEndpoint).addLocation(
            session,
            params['suggestedLocation'],
          ),
        ),
        'getFavorites': _i1.MethodConnector(
          name: 'getFavorites',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['location'] as _i4.LocationEndpoint)
                  .getFavorites(session),
        ),
        'addFavorite': _i1.MethodConnector(
          name: 'addFavorite',
          params: {
            'locationId': _i1.ParameterDescription(
              name: 'locationId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['location'] as _i4.LocationEndpoint).addFavorite(
            session,
            params['locationId'],
          ),
        ),
        'removeFavorite': _i1.MethodConnector(
          name: 'removeFavorite',
          params: {
            'locationId': _i1.ParameterDescription(
              name: 'locationId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['location'] as _i4.LocationEndpoint).removeFavorite(
            session,
            params['locationId'],
          ),
        ),
        'importAustrianStores': _i1.MethodConnector(
          name: 'importAustrianStores',
          params: {
            'lat': _i1.ParameterDescription(
              name: 'lat',
              type: _i1.getType<double>(),
              nullable: false,
            ),
            'lng': _i1.ParameterDescription(
              name: 'lng',
              type: _i1.getType<double>(),
              nullable: false,
            ),
            'radiusKm': _i1.ParameterDescription(
              name: 'radiusKm',
              type: _i1.getType<double>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['location'] as _i4.LocationEndpoint)
                  .importAustrianStores(
            session,
            params['lat'],
            params['lng'],
            radiusKm: params['radiusKm'],
          ),
        ),
        'getAustrianDepositLocations': _i1.MethodConnector(
          name: 'getAustrianDepositLocations',
          params: {
            'lat': _i1.ParameterDescription(
              name: 'lat',
              type: _i1.getType<double>(),
              nullable: false,
            ),
            'lng': _i1.ParameterDescription(
              name: 'lng',
              type: _i1.getType<double>(),
              nullable: false,
            ),
            'maxDistanceKm': _i1.ParameterDescription(
              name: 'maxDistanceKm',
              type: _i1.getType<double>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['location'] as _i4.LocationEndpoint)
                  .getAustrianDepositLocations(
            session,
            params['lat'],
            params['lng'],
            maxDistanceKm: params['maxDistanceKm'],
          ),
        ),
      },
    );
    connectors['scan'] = _i1.EndpointConnector(
      name: 'scan',
      endpoint: endpoints['scan']!,
      methodConnectors: {
        'recordScan': _i1.MethodConnector(
          name: 'recordScan',
          params: {
            'scanInput': _i1.ParameterDescription(
              name: 'scanInput',
              type: _i1.getType<_i15.ScanInput>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['scan'] as _i5.ScanEndpoint).recordScan(
            session,
            params['scanInput'],
          ),
        ),
        'startSession': _i1.MethodConnector(
          name: 'startSession',
          params: {
            'locationId': _i1.ParameterDescription(
              name: 'locationId',
              type: _i1.getType<int?>(),
              nullable: true,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['scan'] as _i5.ScanEndpoint).startSession(
            session,
            locationId: params['locationId'],
          ),
        ),
        'endSession': _i1.MethodConnector(
          name: 'endSession',
          params: {
            'sessionId': _i1.ParameterDescription(
              name: 'sessionId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['scan'] as _i5.ScanEndpoint).endSession(
            session,
            params['sessionId'],
          ),
        ),
        'bulkUpload': _i1.MethodConnector(
          name: 'bulkUpload',
          params: {
            'scans': _i1.ParameterDescription(
              name: 'scans',
              type: _i1.getType<List<_i15.ScanInput>>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['scan'] as _i5.ScanEndpoint).bulkUpload(
            session,
            params['scans'],
          ),
        ),
        'getUserScans': _i1.MethodConnector(
          name: 'getUserScans',
          params: {
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'offset': _i1.ParameterDescription(
              name: 'offset',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['scan'] as _i5.ScanEndpoint).getUserScans(
            session,
            limit: params['limit'],
            offset: params['offset'],
          ),
        ),
      },
    );
    connectors['social'] = _i1.EndpointConnector(
      name: 'social',
      endpoint: endpoints['social']!,
      methodConnectors: {
        'getFriends': _i1.MethodConnector(
          name: 'getFriends',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['social'] as _i6.SocialEndpoint).getFriends(session),
        ),
        'getUserBadges': _i1.MethodConnector(
          name: 'getUserBadges',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['social'] as _i6.SocialEndpoint)
                  .getUserBadges(session),
        ),
        'awardBadge': _i1.MethodConnector(
          name: 'awardBadge',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'badgeId': _i1.ParameterDescription(
              name: 'badgeId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['social'] as _i6.SocialEndpoint).awardBadge(
            session,
            params['userId'],
            params['badgeId'],
          ),
        ),
        'checkAndAwardBadges': _i1.MethodConnector(
          name: 'checkAndAwardBadges',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['social'] as _i6.SocialEndpoint).checkAndAwardBadges(
            session,
            params['userId'],
          ),
        ),
        'getAllBadges': _i1.MethodConnector(
          name: 'getAllBadges',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['social'] as _i6.SocialEndpoint).getAllBadges(session),
        ),
        'createBadge': _i1.MethodConnector(
          name: 'createBadge',
          params: {
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'description': _i1.ParameterDescription(
              name: 'description',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'iconUrl': _i1.ParameterDescription(
              name: 'iconUrl',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'criteria': _i1.ParameterDescription(
              name: 'criteria',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['social'] as _i6.SocialEndpoint).createBadge(
            session,
            params['name'],
            params['description'],
            iconUrl: params['iconUrl'],
            criteria: params['criteria'],
          ),
        ),
        'getLeaderboard': _i1.MethodConnector(
          name: 'getLeaderboard',
          params: {
            'period': _i1.ParameterDescription(
              name: 'period',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['social'] as _i6.SocialEndpoint).getLeaderboard(
            session,
            period: params['period'],
            limit: params['limit'],
          ),
        ),
      },
    );
    connectors['stats'] = _i1.EndpointConnector(
      name: 'stats',
      endpoint: endpoints['stats']!,
      methodConnectors: {
        'totals': _i1.MethodConnector(
          name: 'totals',
          params: {
            'startDate': _i1.ParameterDescription(
              name: 'startDate',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
            'endDate': _i1.ParameterDescription(
              name: 'endDate',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['stats'] as _i7.StatsEndpoint).totals(
            session,
            startDate: params['startDate'],
            endDate: params['endDate'],
          ),
        ),
        'breakdown': _i1.MethodConnector(
          name: 'breakdown',
          params: {
            'breakdownBy': _i1.ParameterDescription(
              name: 'breakdownBy',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'startDate': _i1.ParameterDescription(
              name: 'startDate',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
            'endDate': _i1.ParameterDescription(
              name: 'endDate',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['stats'] as _i7.StatsEndpoint).breakdown(
            session,
            params['breakdownBy'],
            startDate: params['startDate'],
            endDate: params['endDate'],
          ),
        ),
        'exportCSV': _i1.MethodConnector(
          name: 'exportCSV',
          params: {
            'startDate': _i1.ParameterDescription(
              name: 'startDate',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
            'endDate': _i1.ParameterDescription(
              name: 'endDate',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['stats'] as _i7.StatsEndpoint).exportCSV(
            session,
            startDate: params['startDate'],
            endDate: params['endDate'],
          ),
        ),
        'getLeaderboard': _i1.MethodConnector(
          name: 'getLeaderboard',
          params: {
            'period': _i1.ParameterDescription(
              name: 'period',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['stats'] as _i7.StatsEndpoint).getLeaderboard(
            session,
            period: params['period'],
            limit: params['limit'],
          ),
        ),
      },
    );
    connectors['greeting'] = _i1.EndpointConnector(
      name: 'greeting',
      endpoint: endpoints['greeting']!,
      methodConnectors: {
        'hello': _i1.MethodConnector(
          name: 'hello',
          params: {
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['greeting'] as _i8.GreetingEndpoint).hello(
            session,
            params['name'],
          ),
        )
      },
    );
    modules['serverpod_auth'] = _i16.Endpoints()..initializeEndpoints(server);
  }
}
