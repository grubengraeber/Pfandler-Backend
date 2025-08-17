import 'package:serverpod/serverpod.dart';
import 'dart:math';
import '../generated/protocol.dart';
import '../services/store_locations_service.dart';

class LocationEndpoint extends Endpoint {
  Future<List<Location>> nearby(
    Session session,
    double lat,
    double lng, {
    LocationFilter? filters,
  }) async {
    try {
      // Log the incoming request for debugging
      session.log('Location nearby request - lat: $lat, lng: $lng, filters: ${filters?.toJson()}');
      
      // Validate coordinates
      if (lat < -90 || lat > 90) {
        throw ArgumentError('Invalid latitude: $lat. Must be between -90 and 90.');
      }
      if (lng < -180 || lng > 180) {
        throw ArgumentError('Invalid longitude: $lng. Must be between -180 and 180.');
      }
      final maxDistance = filters?.maxDistance;
      
      // If no maxDistance specified or it's very large (>100km), search all of Austria
      if (maxDistance == null || maxDistance > 100.0) {
        return await searchAllAustria(session, lat, lng, filters: filters);
      }
      
      // For smaller radius, do local search first
      final allLocations = await Location.db.find(session);
      List<Location> locations = [];
      
      for (var location in allLocations) {
        final distance = _calculateDistance(lat, lng, location.lat, location.lng);
        
        if (distance <= maxDistance) {
          if (filters?.type != null && location.type != filters!.type) {
            continue;
          }
          locations.add(location);
        }
      }
      
      // If no cached locations found in radius, fetch from OpenStreetMap for all of Austria
      if (locations.isEmpty) {
        session.log('No cached locations found within ${maxDistance}km, fetching from OpenStreetMap across Austria...');
        
        final osmLocations = await StoreLocationsService.fetchAustrianStores(
          session,
          lat,
          lng,
          maxDistance,
        );
        
        // Cache the fetched locations in database for future use
        for (var osmLocation in osmLocations) {
          final existing = await Location.db.findFirstRow(
            session,
            where: (t) => t.lat.equals(osmLocation.lat) & t.lng.equals(osmLocation.lng),
          );
          
          if (existing == null) {
            await Location.db.insertRow(session, osmLocation);
          }
          
          // Apply filters
          if (filters?.type != null && osmLocation.type != filters!.type) {
            continue;
          }
          
          locations.add(osmLocation);
        }
      }
      
      // Sort by distance
      locations.sort((a, b) {
        final distA = _calculateDistance(lat, lng, a.lat, a.lng);
        final distB = _calculateDistance(lat, lng, b.lat, b.lng);
        return distA.compareTo(distB);
      });
      
      return locations;
    } catch (e, stackTrace) {
      session.log('Error getting nearby locations: $e\nStack trace: $stackTrace');
      
      // Return empty list for now but log the full error
      // In production, you might want to throw a proper exception
      // that Serverpod can handle and return as HTTP 500
      if (e is ArgumentError) {
        rethrow; // Re-throw validation errors
      }
      
      // For other errors, return empty list to prevent crash
      return [];
    }
  }

  Future<List<Location>> searchAllAustria(
    Session session,
    double lat,
    double lng, {
    LocationFilter? filters,
  }) async {
    try {
      session.log('Searching all of Austria for deposit locations...');
      
      // Get all cached locations from Austria
      final allLocations = await Location.db.find(session);
      List<Location> locations = [];
      
      // Apply filters to cached locations
      for (var location in allLocations) {
        if (filters?.type != null && location.type != filters!.type) {
          continue;
        }
        locations.add(location);
      }
      
      // If we have very few cached locations, fetch more from major Austrian cities
      if (locations.length < 100) {
        session.log('Found only ${locations.length} cached locations, fetching more from major Austrian cities...');
        
        // Major Austrian cities to fetch from
        final majorCities = [
          {'name': 'Vienna', 'lat': 48.2082, 'lng': 16.3738},
          {'name': 'Graz', 'lat': 47.0707, 'lng': 15.4395},
          {'name': 'Linz', 'lat': 48.3069, 'lng': 14.2858},
          {'name': 'Salzburg', 'lat': 47.8095, 'lng': 13.0550},
          {'name': 'Innsbruck', 'lat': 47.2692, 'lng': 11.4041},
          {'name': 'Klagenfurt', 'lat': 46.6247, 'lng': 14.3056},
          {'name': 'St. Pölten', 'lat': 48.2058, 'lng': 15.6232},
          {'name': 'Bregenz', 'lat': 47.5037, 'lng': 9.7471},
        ];
        
        for (var city in majorCities) {
          session.log('Fetching locations around ${city['name']}...');
          
          final cityLocations = await StoreLocationsService.fetchAustrianStores(
            session,
            city['lat'] as double,
            city['lng'] as double,
            20.0, // 20km radius around each major city
          );
          
          // Cache and add new locations
          for (var cityLocation in cityLocations) {
            final existing = await Location.db.findFirstRow(
              session,
              where: (t) => t.lat.equals(cityLocation.lat) & t.lng.equals(cityLocation.lng),
            );
            
            if (existing == null) {
              await Location.db.insertRow(session, cityLocation);
              
              // Apply filters
              if (filters?.type != null && cityLocation.type != filters!.type) {
                continue;
              }
              
              locations.add(cityLocation);
            }
          }
        }
      }
      
      // Sort by distance from user's location
      locations.sort((a, b) {
        final distA = _calculateDistance(lat, lng, a.lat, a.lng);
        final distB = _calculateDistance(lat, lng, b.lat, b.lng);
        return distA.compareTo(distB);
      });
      
      session.log('Found ${locations.length} deposit locations across Austria');
      return locations;
    } catch (e, stackTrace) {
      session.log('Error searching all Austria: $e\nStack trace: $stackTrace');
      return [];
    }
  }

  Future<LocationReport> reportStatus(
    Session session,
    int locationId,
    String status, {
    String? note,
  }) async {
    final authInfo = await session.authenticated;
    if (authInfo == null) {
      throw Exception('User must be authenticated to report location status');
    }

    try {
      final validStatuses = ['busy', 'full', 'out-of-order', 'operational'];
      if (!validStatuses.contains(status)) {
        throw Exception('Invalid status. Must be one of: ${validStatuses.join(', ')}');
      }

      final report = LocationReport(
        locationId: locationId,
        userId: authInfo.userId,
        status: status,
        note: note,
        createdAt: DateTime.now(),
      );

      await LocationReport.db.insertRow(session, report);
      return report;
    } catch (e, stackTrace) {
      session.log('Error reporting location status: $e\nStack trace: $stackTrace');
      rethrow;
    }
  }

  Future<Location> addLocation(
    Session session,
    Location suggestedLocation,
  ) async {
    final authInfo = await session.authenticated;
    if (authInfo == null) {
      throw Exception('User must be authenticated to add locations');
    }

    try {
      final existingLocation = await Location.db.findFirstRow(
        session,
        where: (t) => t.lat.equals(suggestedLocation.lat) & 
                      t.lng.equals(suggestedLocation.lng),
      );

      if (existingLocation != null) {
        throw Exception('Location already exists at these coordinates');
      }

      await Location.db.insertRow(session, suggestedLocation);
      return suggestedLocation;
    } catch (e, stackTrace) {
      session.log('Error adding location: $e\nStack trace: $stackTrace');
      rethrow;
    }
  }

  Future<List<FavoriteLocation>> getFavorites(Session session) async {
    final authInfo = await session.authenticated;
    if (authInfo == null) {
      throw Exception('User must be authenticated to get favorite locations');
    }

    try {
      return await FavoriteLocation.db.find(
        session,
        where: (t) => t.userId.equals(authInfo.userId),
      );
    } catch (e, stackTrace) {
      session.log('Error getting favorite locations: $e\nStack trace: $stackTrace');
      return [];
    }
  }

  Future<FavoriteLocation> addFavorite(
    Session session,
    int locationId,
  ) async {
    final authInfo = await session.authenticated;
    if (authInfo == null) {
      throw Exception('User must be authenticated to add favorite locations');
    }

    try {
      final existing = await FavoriteLocation.db.findFirstRow(
        session,
        where: (t) => t.userId.equals(authInfo.userId) & 
                      t.locationId.equals(locationId),
      );

      if (existing != null) {
        throw Exception('Location is already in favorites');
      }

      final favorite = FavoriteLocation(
        userId: authInfo.userId,
        locationId: locationId,
      );

      await FavoriteLocation.db.insertRow(session, favorite);
      return favorite;
    } catch (e, stackTrace) {
      session.log('Error adding favorite location: $e\nStack trace: $stackTrace');
      rethrow;
    }
  }

  Future<bool> removeFavorite(
    Session session,
    int locationId,
  ) async {
    final authInfo = await session.authenticated;
    if (authInfo == null) {
      throw Exception('User must be authenticated to remove favorite locations');
    }

    try {
      final result = await FavoriteLocation.db.deleteWhere(
        session,
        where: (t) => t.userId.equals(authInfo.userId) & 
                      t.locationId.equals(locationId),
      );
      return result.isNotEmpty;
    } catch (e, stackTrace) {
      session.log('Error removing favorite location: $e\nStack trace: $stackTrace');
      return false;
    }
  }

  double _calculateDistance(double lat1, double lng1, double lat2, double lng2) {
    const double earthRadius = 6371;
    
    double dLat = _toRadians(lat2 - lat1);
    double dLng = _toRadians(lng2 - lng1);
    
    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_toRadians(lat1)) * cos(_toRadians(lat2)) *
        sin(dLng / 2) * sin(dLng / 2);
    
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    
    return earthRadius * c;
  }

  double _toRadians(double degree) {
    return degree * pi / 180;
  }

  Future<List<Location>> importAustrianStores(
    Session session,
    double lat,
    double lng, {
    double radiusKm = 10.0,
  }) async {
    final authInfo = await session.authenticated;
    if (authInfo == null) {
      throw Exception('User must be authenticated to import stores');
    }

    try {
      session.log('Fetching Austrian stores from OpenStreetMap...');
      
      // Fetch stores from OSM
      final stores = await StoreLocationsService.fetchAustrianStores(
        session,
        lat,
        lng,
        radiusKm,
      );
      
      session.log('Found ${stores.length} stores, importing to database...');
      
      // Import to database
      int imported = 0;
      for (var store in stores) {
        // Check if store already exists
        final existing = await Location.db.findFirstRow(
          session,
          where: (t) => t.lat.equals(store.lat) & t.lng.equals(store.lng),
        );
        
        if (existing == null) {
          await Location.db.insertRow(session, store);
          imported++;
        }
      }
      
      session.log('Successfully imported $imported new store locations');
      return stores;
    } catch (e, stackTrace) {
      session.log('Error importing Austrian stores: $e\nStack trace: $stackTrace');
      rethrow;
    }
  }

  Future<List<Location>> getAustrianDepositLocations(
    Session session,
    double lat,
    double lng, {
    double maxDistanceKm = 5.0,
  }) async {
    try {
      // First check database for cached locations
      final cachedLocations = await Location.db.find(session);
      
      List<Location> nearbyLocations = [];
      
      for (var location in cachedLocations) {
        final distance = _calculateDistance(lat, lng, location.lat, location.lng);
        if (distance <= maxDistanceKm) {
          nearbyLocations.add(location);
        }
      }
      
      // If no cached locations nearby, fetch from OSM
      if (nearbyLocations.isEmpty) {
        session.log('No cached locations found, fetching from OpenStreetMap...');
        nearbyLocations = await StoreLocationsService.fetchAustrianStores(
          session,
          lat,
          lng,
          maxDistanceKm,
        );
        
        // Save fetched locations to database for future use
        for (var location in nearbyLocations) {
          final existing = await Location.db.findFirstRow(
            session,
            where: (t) => t.lat.equals(location.lat) & t.lng.equals(location.lng),
          );
          
          if (existing == null) {
            await Location.db.insertRow(session, location);
          }
        }
      }
      
      // Sort by distance
      nearbyLocations.sort((a, b) {
        final distA = _calculateDistance(lat, lng, a.lat, a.lng);
        final distB = _calculateDistance(lat, lng, b.lat, b.lng);
        return distA.compareTo(distB);
      });
      
      return nearbyLocations;
    } catch (e, stackTrace) {
      session.log('Error getting Austrian deposit locations: $e\nStack trace: $stackTrace');
      return [];
    }
  }
}