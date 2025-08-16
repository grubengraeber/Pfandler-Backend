import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

class StoreLocationsService {
  // Major Austrian grocery chains that accept deposit containers
  static const List<Map<String, String>> austrianChains = [
    {'name': 'Billa', 'osmTag': 'shop=supermarket', 'brand': 'Billa'},
    {'name': 'Billa Plus', 'osmTag': 'shop=supermarket', 'brand': 'Billa Plus'},
    {'name': 'Spar', 'osmTag': 'shop=supermarket', 'brand': 'Spar'},
    {'name': 'Eurospar', 'osmTag': 'shop=supermarket', 'brand': 'Eurospar'},
    {'name': 'Interspar', 'osmTag': 'shop=supermarket', 'brand': 'Interspar'},
    {'name': 'Hofer', 'osmTag': 'shop=supermarket', 'brand': 'Hofer'},
    {'name': 'Lidl', 'osmTag': 'shop=supermarket', 'brand': 'Lidl'},
    {'name': 'Penny', 'osmTag': 'shop=supermarket', 'brand': 'Penny'},
    {'name': 'MPreis', 'osmTag': 'shop=supermarket', 'brand': 'MPreis'},
    {'name': 'Merkur', 'osmTag': 'shop=supermarket', 'brand': 'Merkur'},
  ];

  /// Fetch stores from OpenStreetMap Overpass API
  static Future<List<Location>> fetchAustrianStores(
    Session session,
    double lat,
    double lng,
    double radiusKm,
  ) async {
    try {
      // Build Overpass API query for Austrian stores
      final overpassQuery = _buildOverpassQuery(lat, lng, radiusKm);
      
      final url = Uri.parse('https://overpass-api.de/api/interpreter');
      session.log('Fetching from Overpass API with radius ${radiusKm}km...');
      
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: 'data=${Uri.encodeComponent(overpassQuery)}',
      ).timeout(Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final elements = data['elements'] as List<dynamic>;
        
        session.log('Received ${elements.length} elements from Overpass API');
        List<Location> locations = [];
        
        for (var element in elements) {
          final tags = Map<String, dynamic>.from(element['tags'] ?? {});
          final name = tags['name'] ?? tags['brand'] ?? 'Unknown Store';
          final brand = (tags['brand'] ?? '').toString();
          
          // Determine if this store accepts deposits (all major chains do as of 2025)
          bool acceptsDeposit = _isDepositAcceptingStore(brand, tags);
          
          double? storeLat;
          double? storeLng;
          
          if (element['type'] == 'node') {
            storeLat = element['lat']?.toDouble();
            storeLng = element['lon']?.toDouble();
          } else if (element['type'] == 'way' && element['center'] != null) {
            storeLat = element['center']['lat']?.toDouble();
            storeLng = element['center']['lon']?.toDouble();
          }
          
          if (storeLat != null && storeLng != null) {
            if (acceptsDeposit) {
              // Create opening hours JSON
              final openingHours = _parseOpeningHours((tags['opening_hours'] ?? '').toString());
              
              // Create accepts JSON (what types of containers they accept)
              final acceptsJson = json.encode({
                'plastic_bottles': true,
                'cans': true,
                'glass_bottles': brand != 'Hofer', // Some stores may not accept glass
                'has_reverse_vending_machine': _hasReverseVendingMachine(brand),
              });
              
              // Generate address from OSM data
              final address = _buildAddress(tags);
              
              // Generate Google Maps URL
              final googleMapsUrl = 'https://www.google.com/maps?q=$storeLat,$storeLng';
              
              final location = Location(
                name: name.toString(),
                type: 'supermarket',
                lat: storeLat,
                lng: storeLng,
                address: address,
                googleMapsUrl: googleMapsUrl,
                acceptsJson: acceptsJson,
                openingHoursJson: openingHours,
              );
              
              locations.add(location);
              session.log('Added location: ${name.toString()} at $storeLat, $storeLng');
            } else {
              session.log('Skipped non-deposit store: ${name.toString()}');
            }
          } else {
            session.log('Skipped element without coordinates');
          }
        }
        
        // Sort by distance
        locations.sort((a, b) {
          final distA = _calculateDistance(lat, lng, a.lat, a.lng);
          final distB = _calculateDistance(lat, lng, b.lat, b.lng);
          return distA.compareTo(distB);
        });
        
        session.log('Found ${locations.length} deposit locations in Austria');
        return locations;
      } else {
        session.log('Error fetching from Overpass API: ${response.statusCode}');
      }
    } catch (e) {
      session.log('Error fetching Austrian stores: $e');
    }
    
    return [];
  }

  /// Build Overpass API query for Austrian supermarkets
  static String _buildOverpassQuery(double lat, double lng, double radiusKm) {
    final radiusMeters = (radiusKm * 1000).round();
    
    // Query for all supermarkets in the radius
    return '''
[out:json][timeout:25];
(
  node["shop"="supermarket"](around:$radiusMeters,$lat,$lng);
  way["shop"="supermarket"](around:$radiusMeters,$lat,$lng);
  relation["shop"="supermarket"](around:$radiusMeters,$lat,$lng);
);
out body;
>;
out skel qt;
''';
  }

  /// Check if store accepts deposit containers
  static bool _isDepositAcceptingStore(String brand, Map tags) {
    // All major Austrian chains must accept deposits as of 2025
    final majorChains = [
      'Billa', 'Billa Plus', 'Spar', 'Eurospar', 'Interspar',
      'Hofer', 'Lidl', 'Penny', 'MPreis', 'Merkur', 'REWE', 'ADEG'
    ];
    
    for (var chain in majorChains) {
      if (brand.toLowerCase().contains(chain.toLowerCase()) ||
          (tags['name'] ?? '').toString().toLowerCase().contains(chain.toLowerCase())) {
        return true;
      }
    }
    
    // Check for small stores (must accept if they sell deposit containers)
    if (tags['shop'] == 'convenience' || tags['shop'] == 'kiosk') {
      // Small stores over 200m² must accept returns
      return true; // Assume they accept for now
    }
    
    return false;
  }

  /// Check if store likely has reverse vending machine
  static bool _hasReverseVendingMachine(String brand) {
    // Larger chains typically have reverse vending machines
    final chainsWithMachines = [
      'Billa Plus', 'Interspar', 'Eurospar', 'Merkur', 'REWE'
    ];
    
    for (var chain in chainsWithMachines) {
      if (brand.toLowerCase().contains(chain.toLowerCase())) {
        return true;
      }
    }
    
    return false;
  }

  /// Parse opening hours to JSON format
  static String _parseOpeningHours(String openingHours) {
    if (openingHours.isEmpty) {
      // Default opening hours for Austrian supermarkets
      return json.encode({
        'monday': '07:00-19:30',
        'tuesday': '07:00-19:30',
        'wednesday': '07:00-19:30',
        'thursday': '07:00-19:30',
        'friday': '07:00-19:30',
        'saturday': '07:00-18:00',
        'sunday': 'closed',
      });
    }
    
    // Parse OSM opening_hours format
    // Example: "Mo-Fr 07:00-19:30; Sa 07:00-18:00"
    Map<String, String> hours = {};
    
    try {
      final parts = openingHours.split(';');
      for (var part in parts) {
        part = part.trim();
        if (part.contains('Mo')) hours['monday'] = _extractTime(part);
        if (part.contains('Tu')) hours['tuesday'] = _extractTime(part);
        if (part.contains('We')) hours['wednesday'] = _extractTime(part);
        if (part.contains('Th')) hours['thursday'] = _extractTime(part);
        if (part.contains('Fr')) hours['friday'] = _extractTime(part);
        if (part.contains('Sa')) hours['saturday'] = _extractTime(part);
        if (part.contains('Su')) hours['sunday'] = _extractTime(part);
      }
    } catch (e) {
      // If parsing fails, return default hours
      return json.encode({
        'raw': openingHours,
        'parsed': false,
      });
    }
    
    return json.encode(hours);
  }

  /// Extract time from opening hours string
  static String _extractTime(String part) {
    final timeMatch = RegExp(r'(\d{2}:\d{2})-(\d{2}:\d{2})').firstMatch(part);
    if (timeMatch != null) {
      return '${timeMatch.group(1)}-${timeMatch.group(2)}';
    }
    return 'unknown';
  }

  /// Calculate distance between two coordinates in km
  static double _calculateDistance(double lat1, double lng1, double lat2, double lng2) {
    const double earthRadius = 6371;
    
    double dLat = _toRadians(lat2 - lat1);
    double dLng = _toRadians(lng2 - lng1);
    
    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_toRadians(lat1)) * cos(_toRadians(lat2)) *
        sin(dLng / 2) * sin(dLng / 2);
    
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    
    return earthRadius * c;
  }

  static double _toRadians(double degree) {
    return degree * pi / 180;
  }

  /// Build address string from OpenStreetMap tags
  static String? _buildAddress(Map tags) {
    List<String> addressParts = [];
    
    // Street and house number
    final street = tags['addr:street']?.toString();
    final houseNumber = tags['addr:housenumber']?.toString();
    if (street != null) {
      if (houseNumber != null) {
        addressParts.add('$street $houseNumber');
      } else {
        addressParts.add(street);
      }
    }
    
    // Postal code and city
    final postcode = tags['addr:postcode']?.toString();
    final city = tags['addr:city']?.toString();
    if (postcode != null && city != null) {
      addressParts.add('$postcode $city');
    } else if (city != null) {
      addressParts.add(city);
    }
    
    // Country (should be Austria for Austrian stores)
    final country = tags['addr:country']?.toString() ?? 'Austria';
    if (country.isNotEmpty && country != 'AT') {
      addressParts.add(country);
    }
    
    return addressParts.isNotEmpty ? addressParts.join(', ') : null;
  }

  /// Import Austrian stores to database
  static Future<int> importAustrianStoresToDatabase(
    Session session,
    double centerLat,
    double centerLng,
    double radiusKm,
  ) async {
    try {
      final stores = await fetchAustrianStores(session, centerLat, centerLng, radiusKm);
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
      
      session.log('Imported $imported new Austrian store locations');
      return imported;
    } catch (e) {
      session.log('Error importing Austrian stores: $e');
      return 0;
    }
  }
}