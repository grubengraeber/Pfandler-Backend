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

abstract class ChangePasswordRequest
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  ChangePasswordRequest._({
    required this.token,
    required this.currentPassword,
    required this.newPassword,
  });

  factory ChangePasswordRequest({
    required String token,
    required String currentPassword,
    required String newPassword,
  }) = _ChangePasswordRequestImpl;

  factory ChangePasswordRequest.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return ChangePasswordRequest(
      token: jsonSerialization['token'] as String,
      currentPassword: jsonSerialization['currentPassword'] as String,
      newPassword: jsonSerialization['newPassword'] as String,
    );
  }

  String token;

  String currentPassword;

  String newPassword;

  /// Returns a shallow copy of this [ChangePasswordRequest]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ChangePasswordRequest copyWith({
    String? token,
    String? currentPassword,
    String? newPassword,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'currentPassword': currentPassword,
      'newPassword': newPassword,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      'token': token,
      'currentPassword': currentPassword,
      'newPassword': newPassword,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _ChangePasswordRequestImpl extends ChangePasswordRequest {
  _ChangePasswordRequestImpl({
    required String token,
    required String currentPassword,
    required String newPassword,
  }) : super._(
          token: token,
          currentPassword: currentPassword,
          newPassword: newPassword,
        );

  /// Returns a shallow copy of this [ChangePasswordRequest]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ChangePasswordRequest copyWith({
    String? token,
    String? currentPassword,
    String? newPassword,
  }) {
    return ChangePasswordRequest(
      token: token ?? this.token,
      currentPassword: currentPassword ?? this.currentPassword,
      newPassword: newPassword ?? this.newPassword,
    );
  }
}
