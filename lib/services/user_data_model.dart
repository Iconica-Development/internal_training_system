class UserDataModel {
  final String? id;
  final String userName;
  final String userPassword;

  UserDataModel(
      {required this.id, required this.userName, required this.userPassword});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userName': userName,
      'userPassword': userPassword,
    };
  }

  factory UserDataModel.fromMap(String id, Map<String, dynamic> map) {
    return UserDataModel(
      id: id,
      userName: map['userName'] as String,
      userPassword: map['userPassword'] as String,
    );
  }
}
