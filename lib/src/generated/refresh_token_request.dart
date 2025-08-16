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

abstract class RefreshTokenRequest
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  RefreshTokenRequest._({required this.refreshToken});

  factory RefreshTokenRequest({required String refreshToken}) =
      _RefreshTokenRequestImpl;

  factory RefreshTokenRequest.fromJson(Map<String, dynamic> jsonSerialization) {
    return RefreshTokenRequest(
        refreshToken: jsonSerialization['refreshToken'] as String);
  }

  String refreshToken;

  /// Returns a shallow copy of this [RefreshTokenRequest]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  RefreshTokenRequest copyWith({String? refreshToken});
  @override
  Map<String, dynamic> toJson() {
    return {'refreshToken': refreshToken};
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {'refreshToken': refreshToken};
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _RefreshTokenRequestImpl extends RefreshTokenRequest {
  _RefreshTokenRequestImpl({required String refreshToken})
      : super._(refreshToken: refreshToken);

  /// Returns a shallow copy of this [RefreshTokenRequest]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  RefreshTokenRequest copyWith({String? refreshToken}) {
    return RefreshTokenRequest(refreshToken: refreshToken ?? this.refreshToken);
  }
}
