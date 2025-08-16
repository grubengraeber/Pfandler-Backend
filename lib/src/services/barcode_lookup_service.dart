import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

class BarcodeLookupService {
  static const String openFoodFactsUrl = 'https://world.openfoodfacts.org/api/v2/product/';
  static const String openGtinDbUrl = 'https://opengtindb.org/api.php';
  static const String upcItemDbUrl = 'https://api.upcitemdb.com/prod/trial/lookup';
  
  /// Lookup product information from OpenFoodFacts API
  static Future<Product?> lookupFromOpenFoodFacts(
    Session session,
    String barcode,
  ) async {
    try {
      final url = Uri.parse('$openFoodFactsUrl$barcode.json');
      final response = await http.get(
        url,
        headers: {
          'User-Agent': 'Pfandler/1.0 (contact@pfandler.app)',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        
        if (data['status'] == 1 && data['product'] != null) {
          final productData = data['product'];
          
          // Extract relevant information
          final name = productData['product_name'] ?? 
                       productData['product_name_de'] ?? 
                       productData['product_name_en'] ?? 
                       'Unknown Product';
          
          final brand = productData['brands'] ?? 
                       productData['brands_tags']?.first ?? 
                       'Unknown Brand';
          
          // Try to extract volume from quantity field
          int? volumeML = _extractVolume(productData['quantity'] ?? '');
          
          // Determine container type from packaging
          String? containerType = _extractContainerType(
            productData['packaging'] ?? '',
            productData['packaging_tags'] ?? [],
            volumeML: volumeML,
          );
          
          // Default deposit for Germany (in cents)
          int? defaultDepositCents = _getDefaultDeposit(containerType, volumeML);
          
          final product = Product(
            barcode: barcode,
            name: name.toString(),
            brand: brand.toString(),
            volumeML: volumeML,
            containerType: containerType,
            defaultDepositCents: defaultDepositCents,
            verifiedAt: null,
            communityConfidence: 0.5, // Medium confidence for API data
          );
          
          session.log('Found product via OpenFoodFacts: $name');
          return product;
        }
      }
    } catch (e) {
      session.log('Error fetching from OpenFoodFacts: $e');
    }
    
    return null;
  }

  /// Lookup product from multiple sources
  static Future<Product?> lookupBarcode(
    Session session,
    String barcode,
  ) async {
    // First try OpenFoodFacts as it's free and comprehensive
    var product = await lookupFromOpenFoodFacts(session, barcode);
    
    if (product != null) {
      return product;
    }
    
    // If not found, try other sources
    product = await lookupFromOpenGTIN(session, barcode);
    
    if (product != null) {
      return product;
    }
    
    // Could add more API sources here
    
    return null;
  }

  /// Lookup from OpenGTIN Database
  static Future<Product?> lookupFromOpenGTIN(
    Session session,
    String barcode,
  ) async {
    try {
      final url = Uri.parse('$openGtinDbUrl?ean=$barcode&cmd=query&queryid=400000000');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        
        if (data['error'] == '0' && data['product'] != null) {
          final productData = data['product'];
          
          final product = Product(
            barcode: barcode,
            name: productData['name'] ?? 'Unknown Product',
            brand: productData['vendor'] ?? 'Unknown Brand',
            volumeML: _extractVolume(productData['description'] ?? ''),
            containerType: null,
            defaultDepositCents: null,
            verifiedAt: null,
            communityConfidence: 0.3, // Lower confidence for basic data
          );
          
          session.log('Found product via OpenGTIN: ${product.name}');
          return product;
        }
      }
    } catch (e) {
      session.log('Error fetching from OpenGTIN: $e');
    }
    
    return null;
  }

  /// Extract volume in ML from quantity string
  static int? _extractVolume(String quantity) {
    if (quantity.isEmpty) return null;
    
    // Common patterns: "500ml", "0.5l", "500 ml", "0,5 l", "1.5 L"
    final patterns = [
      RegExp(r'(\d+(?:\.\d+)?)\s*ml', caseSensitive: false),
      RegExp(r'(\d+(?:\.\d+)?)\s*cl', caseSensitive: false),
      RegExp(r'(\d+(?:\.\d+)?)\s*l(?:iter)?', caseSensitive: false),
      RegExp(r'(\d+(?:,\d+)?)\s*ml', caseSensitive: false),
      RegExp(r'(\d+(?:,\d+)?)\s*l(?:iter)?', caseSensitive: false),
    ];
    
    for (var pattern in patterns) {
      final match = pattern.firstMatch(quantity);
      if (match != null) {
        var value = match.group(1)!.replaceAll(',', '.');
        var numValue = double.tryParse(value);
        
        if (numValue != null) {
          // Convert to ML based on unit
          if (pattern.pattern.contains('cl')) {
            return (numValue * 10).round(); // cl to ml
          } else if (pattern.pattern.contains('l(?:iter)?')) {
            return (numValue * 1000).round(); // l to ml
          } else {
            return numValue.round(); // already in ml
          }
        }
      }
    }
    
    return null;
  }

  /// Extract container type from packaging information with volume-based inference
  static String? _extractContainerType(String packaging, List<dynamic> packagingTags, {int? volumeML}) {
    final packagingLower = packaging.toLowerCase();
    final allTags = packagingTags.map((e) => e.toString().toLowerCase()).toList();
    allTags.add(packagingLower);
    
    final tagString = allTags.join(' ');
    
    // First try to detect from packaging tags
    if (tagString.contains('can') || 
        tagString.contains('aluminum') || 
        tagString.contains('aluminium') ||
        tagString.contains('dose') ||
        tagString.contains('metal') ||
        tagString.contains('tin')) {
      return 'can';
    }
    
    if (tagString.contains('plastic') || 
        tagString.contains('pet') || 
        tagString.contains('plastik') ||
        tagString.contains('kunststoff')) {
      // Determine specific plastic bottle type based on volume
      if (volumeML != null) {
        if (volumeML <= 500) {
          return 'plastic_bottle_small'; // <= 0.5L
        } else if (volumeML <= 1000) {
          return 'plastic_bottle_medium'; // 0.5L - 1L
        } else {
          return 'plastic_bottle_large'; // > 1L
        }
      }
      return 'plastic_bottle';
    }
    
    if (tagString.contains('glass') || 
        tagString.contains('glas') ||
        tagString.contains('bottle-glass')) {
      // Determine specific glass bottle type based on volume
      if (volumeML != null) {
        if (volumeML <= 330) {
          return 'glass_bottle_beer_small'; // Standard beer bottle
        } else if (volumeML <= 500) {
          return 'glass_bottle_medium';
        } else {
          return 'glass_bottle_large';
        }
      }
      return 'glass_bottle';
    }
    
    if (tagString.contains('tetra') || 
        tagString.contains('carton') ||
        tagString.contains('karton')) {
      return 'carton'; // Usually no deposit
    }
    
    // If no packaging info, try to infer from volume (common sizes)
    if (volumeML != null) {
      // Common can sizes: 250ml, 330ml, 355ml, 473ml, 500ml
      if ([250, 330, 355, 473, 500].contains(volumeML)) {
        return 'can';
      }
      // Common plastic bottle sizes: 500ml, 750ml, 1000ml, 1500ml, 2000ml
      if ([500, 750, 1000, 1500, 2000].contains(volumeML)) {
        if (volumeML <= 500) {
          return 'plastic_bottle_small';
        } else if (volumeML <= 1000) {
          return 'plastic_bottle_medium';
        } else {
          return 'plastic_bottle_large';
        }
      }
      // Common glass bottle sizes: 330ml (beer), 500ml
      if (volumeML == 330) {
        return 'glass_bottle_beer_small';
      }
    }
    
    return null;
  }

  /// Get default deposit amount based on Austrian Pfand system (as of 2025)
  static int? _getDefaultDeposit(String? containerType, int? volumeML) {
    if (containerType == null) return null;
    
    // Austria has a unified 25 cents deposit for all single-use containers
    // (PET bottles and cans) between 0.1L and 3L as of January 2025
    
    // Check if volume is within the deposit range (100ml - 3000ml)
    if (volumeML != null && (volumeML < 100 || volumeML > 3000)) {
      return 0; // No deposit for containers outside this range
    }
    
    switch (containerType) {
      case 'can':
      case 'plastic_bottle':
      case 'plastic_bottle_small':
      case 'plastic_bottle_medium':
      case 'plastic_bottle_large':
        // Austria: 25 cents for all cans and plastic bottles (0.1L - 3L)
        return 25;
      
      case 'glass_bottle':
      case 'glass_bottle_beer_small':
      case 'glass_bottle_medium':
      case 'glass_bottle_large':
        // Glass bottles in Austria:
        // - Reusable glass bottles (Mehrweg): typically 9-15 cents
        // - Single-use glass: currently not in the deposit system
        // For now, assume reusable glass with conservative estimate
        if (volumeML != null && volumeML <= 330) {
          return 9; // Small beer bottles (Mehrweg)
        }
        return 15; // Larger glass bottles (Mehrweg)
      
      case 'carton':
        // Cartons are excluded from Austrian deposit system
        return 0;
      
      // Legacy German system types (kept for compatibility)
      case 'plastic':
        return 25;
      case 'aluminum':
        return 25;
      case 'glass':
        if (volumeML != null && volumeML <= 330) {
          return 9;
        }
        return 15;
      
      default:
        // If container type is unknown but volume suggests it's a beverage
        // container within deposit range, assume 25 cents
        if (volumeML != null && volumeML >= 100 && volumeML <= 3000) {
          return 25;
        }
        return null;
    }
  }

  /// Create a pending product suggestion from barcode lookup
  static Future<PendingProduct?> createPendingProductFromLookup(
    Session session,
    String barcode,
    int suggestedBy,
  ) async {
    final product = await lookupBarcode(session, barcode);
    
    if (product == null) {
      return null;
    }
    
    return PendingProduct(
      barcode: product.barcode,
      name: product.name,
      brand: product.brand,
      volumeML: product.volumeML,
      containerType: product.containerType,
      defaultDepositCents: product.defaultDepositCents,
      suggestedBy: suggestedBy,
    );
  }
}