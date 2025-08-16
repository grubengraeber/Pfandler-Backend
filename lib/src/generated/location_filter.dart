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

abstract class LocationFilter
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  LocationFilter._({
    this.type,
    this.maxDistance,
    this.isOpen,
  });

  factory LocationFilter({
    String? type,
    double? maxDistance,
    bool? isOpen,
  }) = _LocationFilterImpl;

  factory LocationFilter.fromJson(Map<String, dynamic> jsonSerialization) {
    return LocationFilter(
      type: jsonSerialization['type'] as String?,
      maxDistance: (jsonSerialization['maxDistance'] as num?)?.toDouble(),
      isOpen: jsonSerialization['isOpen'] as bool?,
    );
  }

  String? type;

  double? maxDistance;

  bool? isOpen;

  /// Returns a shallow copy of this [LocationFilter]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  LocationFilter copyWith({
    String? type,
    double? maxDistance,
    bool? isOpen,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (type != null) 'type': type,
      if (maxDistance != null) 'maxDistance': maxDistance,
      if (isOpen != null) 'isOpen': isOpen,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (type != null) 'type': type,
      if (maxDistance != null) 'maxDistance': maxDistance,
      if (isOpen != null) 'isOpen': isOpen,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _LocationFilterImpl extends LocationFilter {
  _LocationFilterImpl({
    String? type,
    double? maxDistance,
    bool? isOpen,
  }) : super._(
          type: type,
          maxDistance: maxDistance,
          isOpen: isOpen,
        );

  /// Returns a shallow copy of this [LocationFilter]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  LocationFilter copyWith({
    Object? type = _Undefined,
    Object? maxDistance = _Undefined,
    Object? isOpen = _Undefined,
  }) {
    return LocationFilter(
      type: type is String? ? type : this.type,
      maxDistance: maxDistance is double? ? maxDistance : this.maxDistance,
      isOpen: isOpen is bool? ? isOpen : this.isOpen,
    );
  }
}
