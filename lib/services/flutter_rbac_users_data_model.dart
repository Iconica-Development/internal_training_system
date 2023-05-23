class FlutterRbacUsersDataModel {
  final String? id;
  final List<String>? permissions;
  final List<String>? roles;

  FlutterRbacUsersDataModel({
    required this.id,
    required this.permissions,
    required this.roles,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'permissions': permissions,
      'roles': roles,
    };
  }

  factory FlutterRbacUsersDataModel.fromMap(
      String id, Map<String, dynamic> map) {
    return FlutterRbacUsersDataModel(
      id: id,
      permissions: map['permissions'] as List<String>?,
      roles: map['roles'] as List<String>?,
    );
  }
}
