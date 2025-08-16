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
import 'user.dart' as _i2;

abstract class AuthResponse
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  AuthResponse._({
    required this.user,
    required this.token,
    this.refreshToken,
    required this.expiresIn,
  });

  factory AuthResponse({
    required _i2.User user,
    required String token,
    String? refreshToken,
    required int expiresIn,
  }) = _AuthResponseImpl;

  factory AuthResponse.fromJson(Map<String, dynamic> jsonSerialization) {
    return AuthResponse(
      user: _i2.User.fromJson(
          (jsonSerialization['user'] as Map<String, dynamic>)),
      token: jsonSerialization['token'] as String,
      refreshToken: jsonSerialization['refreshToken'] as String?,
      expiresIn: jsonSerialization['expiresIn'] as int,
    );
  }

  _i2.User user;

  String token;

  String? refreshToken;

  int expiresIn;

  /// Returns a shallow copy of this [AuthResponse]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AuthResponse copyWith({
    _i2.User? user,
    String? token,
    String? refreshToken,
    int? expiresIn,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'user': user.toJson(),
      'token': token,
      if (refreshToken != null) 'refreshToken': refreshToken,
      'expiresIn': expiresIn,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      'user': user.toJsonForProtocol(),
      'token': token,
      if (refreshToken != null) 'refreshToken': refreshToken,
      'expiresIn': expiresIn,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AuthResponseImpl extends AuthResponse {
  _AuthResponseImpl({
    required _i2.User user,
    required String token,
    String? refreshToken,
    required int expiresIn,
  }) : super._(
          user: user,
          token: token,
          refreshToken: refreshToken,
          expiresIn: expiresIn,
        );

  /// Returns a shallow copy of this [AuthResponse]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AuthResponse copyWith({
    _i2.User? user,
    String? token,
    Object? refreshToken = _Undefined,
    int? expiresIn,
  }) {
    return AuthResponse(
      user: user ?? this.user.copyWith(),
      token: token ?? this.token,
      refreshToken: refreshToken is String? ? refreshToken : this.refreshToken,
      expiresIn: expiresIn ?? this.expiresIn,
    );
  }
}
