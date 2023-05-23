import 'package:web_application/datasource/user_datasource.dart';
import 'package:web_application/services/flutter_rbac_users_data_model.dart';
import 'package:web_application/services/user_data_model.dart';

class UserService {
  final UserDatasource _datasource;

  UserService(UserDatasource datasource) : _datasource = datasource;

  Future<void> createUser(String firstName, String lastName, String userName,
      String userPassword) async {
    UserDataModel userDataModel = UserDataModel(
      id: '',
      firstName: firstName,
      lastName: lastName,
      userEmail: userName,
      userPassword: userPassword,
    );

    FlutterRbacUsersDataModel flutterRbacUsersDataModel =
        FlutterRbacUsersDataModel(
      id: '',
      permissions: [],
      roles: [],
    );

    _datasource.createUser(userDataModel, flutterRbacUsersDataModel);
  }
}
