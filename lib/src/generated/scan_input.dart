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

abstract class ScanInput
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  ScanInput._({
    this.sessionId,
    required this.barcode,
    this.volumeML,
    this.containerType,
    this.depositCents,
    required this.source,
  });

  factory ScanInput({
    int? sessionId,
    required String barcode,
    int? volumeML,
    String? containerType,
    int? depositCents,
    required String source,
  }) = _ScanInputImpl;

  factory ScanInput.fromJson(Map<String, dynamic> jsonSerialization) {
    return ScanInput(
      sessionId: jsonSerialization['sessionId'] as int?,
      barcode: jsonSerialization['barcode'] as String,
      volumeML: jsonSerialization['volumeML'] as int?,
      containerType: jsonSerialization['containerType'] as String?,
      depositCents: jsonSerialization['depositCents'] as int?,
      source: jsonSerialization['source'] as String,
    );
  }

  int? sessionId;

  String barcode;

  int? volumeML;

  String? containerType;

  int? depositCents;

  String source;

  /// Returns a shallow copy of this [ScanInput]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ScanInput copyWith({
    int? sessionId,
    String? barcode,
    int? volumeML,
    String? containerType,
    int? depositCents,
    String? source,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (sessionId != null) 'sessionId': sessionId,
      'barcode': barcode,
      if (volumeML != null) 'volumeML': volumeML,
      if (containerType != null) 'containerType': containerType,
      if (depositCents != null) 'depositCents': depositCents,
      'source': source,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (sessionId != null) 'sessionId': sessionId,
      'barcode': barcode,
      if (volumeML != null) 'volumeML': volumeML,
      if (containerType != null) 'containerType': containerType,
      if (depositCents != null) 'depositCents': depositCents,
      'source': source,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ScanInputImpl extends ScanInput {
  _ScanInputImpl({
    int? sessionId,
    required String barcode,
    int? volumeML,
    String? containerType,
    int? depositCents,
    required String source,
  }) : super._(
          sessionId: sessionId,
          barcode: barcode,
          volumeML: volumeML,
          containerType: containerType,
          depositCents: depositCents,
          source: source,
        );

  /// Returns a shallow copy of this [ScanInput]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ScanInput copyWith({
    Object? sessionId = _Undefined,
    String? barcode,
    Object? volumeML = _Undefined,
    Object? containerType = _Undefined,
    Object? depositCents = _Undefined,
    String? source,
  }) {
    return ScanInput(
      sessionId: sessionId is int? ? sessionId : this.sessionId,
      barcode: barcode ?? this.barcode,
      volumeML: volumeML is int? ? volumeML : this.volumeML,
      containerType:
          containerType is String? ? containerType : this.containerType,
      depositCents: depositCents is int? ? depositCents : this.depositCents,
      source: source ?? this.source,
    );
  }
}
