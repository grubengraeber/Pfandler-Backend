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

abstract class PendingProduct
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  PendingProduct._({
    required this.barcode,
    required this.name,
    this.brand,
    this.volumeML,
    this.containerType,
    this.defaultDepositCents,
    required this.suggestedBy,
  });

  factory PendingProduct({
    required String barcode,
    required String name,
    String? brand,
    int? volumeML,
    String? containerType,
    int? defaultDepositCents,
    required int suggestedBy,
  }) = _PendingProductImpl;

  factory PendingProduct.fromJson(Map<String, dynamic> jsonSerialization) {
    return PendingProduct(
      barcode: jsonSerialization['barcode'] as String,
      name: jsonSerialization['name'] as String,
      brand: jsonSerialization['brand'] as String?,
      volumeML: jsonSerialization['volumeML'] as int?,
      containerType: jsonSerialization['containerType'] as String?,
      defaultDepositCents: jsonSerialization['defaultDepositCents'] as int?,
      suggestedBy: jsonSerialization['suggestedBy'] as int,
    );
  }

  String barcode;

  String name;

  String? brand;

  int? volumeML;

  String? containerType;

  int? defaultDepositCents;

  int suggestedBy;

  /// Returns a shallow copy of this [PendingProduct]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  PendingProduct copyWith({
    String? barcode,
    String? name,
    String? brand,
    int? volumeML,
    String? containerType,
    int? defaultDepositCents,
    int? suggestedBy,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'barcode': barcode,
      'name': name,
      if (brand != null) 'brand': brand,
      if (volumeML != null) 'volumeML': volumeML,
      if (containerType != null) 'containerType': containerType,
      if (defaultDepositCents != null)
        'defaultDepositCents': defaultDepositCents,
      'suggestedBy': suggestedBy,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      'barcode': barcode,
      'name': name,
      if (brand != null) 'brand': brand,
      if (volumeML != null) 'volumeML': volumeML,
      if (containerType != null) 'containerType': containerType,
      if (defaultDepositCents != null)
        'defaultDepositCents': defaultDepositCents,
      'suggestedBy': suggestedBy,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PendingProductImpl extends PendingProduct {
  _PendingProductImpl({
    required String barcode,
    required String name,
    String? brand,
    int? volumeML,
    String? containerType,
    int? defaultDepositCents,
    required int suggestedBy,
  }) : super._(
          barcode: barcode,
          name: name,
          brand: brand,
          volumeML: volumeML,
          containerType: containerType,
          defaultDepositCents: defaultDepositCents,
          suggestedBy: suggestedBy,
        );

  /// Returns a shallow copy of this [PendingProduct]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  PendingProduct copyWith({
    String? barcode,
    String? name,
    Object? brand = _Undefined,
    Object? volumeML = _Undefined,
    Object? containerType = _Undefined,
    Object? defaultDepositCents = _Undefined,
    int? suggestedBy,
  }) {
    return PendingProduct(
      barcode: barcode ?? this.barcode,
      name: name ?? this.name,
      brand: brand is String? ? brand : this.brand,
      volumeML: volumeML is int? ? volumeML : this.volumeML,
      containerType:
          containerType is String? ? containerType : this.containerType,
      defaultDepositCents: defaultDepositCents is int?
          ? defaultDepositCents
          : this.defaultDepositCents,
      suggestedBy: suggestedBy ?? this.suggestedBy,
    );
  }
}
