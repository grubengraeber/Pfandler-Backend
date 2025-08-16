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

abstract class StatsResult
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  StatsResult._({
    required this.count,
    required this.depositCents,
  });

  factory StatsResult({
    required int count,
    required int depositCents,
  }) = _StatsResultImpl;

  factory StatsResult.fromJson(Map<String, dynamic> jsonSerialization) {
    return StatsResult(
      count: jsonSerialization['count'] as int,
      depositCents: jsonSerialization['depositCents'] as int,
    );
  }

  int count;

  int depositCents;

  /// Returns a shallow copy of this [StatsResult]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  StatsResult copyWith({
    int? count,
    int? depositCents,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'count': count,
      'depositCents': depositCents,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      'count': count,
      'depositCents': depositCents,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _StatsResultImpl extends StatsResult {
  _StatsResultImpl({
    required int count,
    required int depositCents,
  }) : super._(
          count: count,
          depositCents: depositCents,
        );

  /// Returns a shallow copy of this [StatsResult]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  StatsResult copyWith({
    int? count,
    int? depositCents,
  }) {
    return StatsResult(
      count: count ?? this.count,
      depositCents: depositCents ?? this.depositCents,
    );
  }
}
