import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';
import '../services/barcode_lookup_service.dart';

class CatalogEndpoint extends Endpoint {
  Future<Product?> getProductByBarcode(
    Session session,
    String barcode,
  ) async {
    try {
      // First check local database
      var product = await Product.db.findFirstRow(
        session,
        where: (t) => t.barcode.equals(barcode),
      );
      
      // If not found locally, try external lookup
      if (product == null) {
        session.log('Product not found locally, attempting external lookup for: $barcode');
        product = await BarcodeLookupService.lookupBarcode(session, barcode);
        
        // If found externally, save to database
        if (product != null) {
          session.log('Product found externally: ${product.name}');
          await Product.db.insertRow(session, product);
        }
      }
      
      return product;
    } catch (e) {
      session.log('Error getting product by barcode: $e');
      return null;
    }
  }

  Future<PendingProduct?> suggestProduct(
    Session session,
    PendingProduct data,
  ) async {
    final authInfo = await session.authenticated;
    if (authInfo == null) {
      throw Exception('User must be authenticated to suggest products');
    }

    try {
      final existingProduct = await Product.db.findFirstRow(
        session,
        where: (t) => t.barcode.equals(data.barcode),
      );

      if (existingProduct != null) {
        throw Exception('Product with this barcode already exists');
      }

      data.suggestedBy = authInfo.userId;
      
      return data;
    } catch (e) {
      session.log('Error suggesting product: $e');
      rethrow;
    }
  }

  Future<List<Product>> searchProducts(
    Session session,
    String query, {
    int limit = 20,
    int offset = 0,
  }) async {
    try {
      return await Product.db.find(
        session,
        where: (t) => t.name.like('%$query%') | t.brand.like('%$query%'),
        limit: limit,
        offset: offset,
        orderBy: (t) => t.name,
      );
    } catch (e) {
      session.log('Error searching products: $e');
      return [];
    }
  }

  Future<Product?> verifyProduct(
    Session session,
    int productId,
  ) async {
    final authInfo = await session.authenticated;
    if (authInfo == null) {
      throw Exception('User must be authenticated to verify products');
    }

    try {
      final product = await Product.db.findById(session, productId);
      if (product == null) return null;

      product.verifiedAt = DateTime.now();
      product.communityConfidence = (product.communityConfidence ?? 0) + 0.1;
      if (product.communityConfidence! > 1.0) {
        product.communityConfidence = 1.0;
      }

      await Product.db.updateRow(session, product);
      return product;
    } catch (e) {
      session.log('Error verifying product: $e');
      rethrow;
    }
  }

  Future<Product?> lookupProductExternal(
    Session session,
    String barcode,
  ) async {
    try {
      session.log('Performing external lookup for barcode: $barcode');
      
      // Try to lookup from external sources
      final product = await BarcodeLookupService.lookupBarcode(session, barcode);
      
      if (product != null) {
        session.log('External lookup successful: ${product.name}');
        
        // Check if it already exists in database
        final existing = await Product.db.findFirstRow(
          session,
          where: (t) => t.barcode.equals(barcode),
        );
        
        if (existing == null) {
          // Save new product to database
          await Product.db.insertRow(session, product);
          session.log('Product saved to database');
        } else {
          session.log('Product already exists in database');
          return existing;
        }
      } else {
        session.log('No product found in external sources');
      }
      
      return product;
    } catch (e) {
      session.log('Error in external product lookup: $e');
      return null;
    }
  }

  Future<Product?> enrichProductData(
    Session session,
    int productId,
  ) async {
    try {
      final product = await Product.db.findById(session, productId);
      if (product == null) return null;
      
      // Lookup additional data from external sources
      final externalData = await BarcodeLookupService.lookupBarcode(
        session, 
        product.barcode,
      );
      
      if (externalData != null) {
        // Update product with missing information
        if (product.brand == null && externalData.brand != null) {
          product.brand = externalData.brand;
        }
        if (product.volumeML == null && externalData.volumeML != null) {
          product.volumeML = externalData.volumeML;
        }
        if (product.containerType == null && externalData.containerType != null) {
          product.containerType = externalData.containerType;
        }
        if (product.defaultDepositCents == null && externalData.defaultDepositCents != null) {
          product.defaultDepositCents = externalData.defaultDepositCents;
        }
        
        await Product.db.updateRow(session, product);
        session.log('Product data enriched from external sources');
      }
      
      return product;
    } catch (e) {
      session.log('Error enriching product data: $e');
      return null;
    }
  }
}