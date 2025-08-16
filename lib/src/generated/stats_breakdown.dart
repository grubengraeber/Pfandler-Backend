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

abstract class StatsBreakdown
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  StatsBreakdown._({
    required this.label,
    required this.count,
    required this.depositCents,
  });

  factory StatsBreakdown({
    required String label,
    required int count,
    required int depositCents,
  }) = _StatsBreakdownImpl;

  factory StatsBreakdown.fromJson(Map<String, dynamic> jsonSerialization) {
    return StatsBreakdown(
      label: jsonSerialization['label'] as String,
      count: jsonSerialization['count'] as int,
      depositCents: jsonSerialization['depositCents'] as int,
    );
  }

  String label;

  int count;

  int depositCents;

  /// Returns a shallow copy of this [StatsBreakdown]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  StatsBreakdown copyWith({
    String? label,
    int? count,
    int? depositCents,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'label': label,
      'count': count,
      'depositCents': depositCents,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      'label': label,
      'count': count,
      'depositCents': depositCents,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _StatsBreakdownImpl extends StatsBreakdown {
  _StatsBreakdownImpl({
    required String label,
    required int count,
    required int depositCents,
  }) : super._(
          label: label,
          count: count,
          depositCents: depositCents,
        );

  /// Returns a shallow copy of this [StatsBreakdown]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  StatsBreakdown copyWith({
    String? label,
    int? count,
    int? depositCents,
  }) {
    return StatsBreakdown(
      label: label ?? this.label,
      count: count ?? this.count,
      depositCents: depositCents ?? this.depositCents,
    );
  }
}
