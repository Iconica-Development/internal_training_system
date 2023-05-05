class UserDataModel {
  final String? id;
  final String firstName;
  final String lastName;
  final String userEmail;
  final String userPassword;

  UserDataModel(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.userEmail,
      required this.userPassword});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'firstName': firstName,
      'lastName': lastName,
      'userEmail': userEmail,
      'userPassword': userPassword,
    };
  }

  factory UserDataModel.fromMap(String id, Map<String, dynamic> map) {
    return UserDataModel(
      id: id,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      userEmail: map['userEmail'] as String,
      userPassword: map['userPassword'] as String,
    );
  }
}
