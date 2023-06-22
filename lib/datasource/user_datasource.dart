import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:web_application/services/flutter_rbac_users_data_model.dart';
import 'package:web_application/services/user_data_model.dart';

class UserDatasource {
  UserDatasource({
    required this.firebaseApp,
  });

  final FirebaseApp firebaseApp;

  late final _userCollection = FirebaseFirestore.instanceFor(app: firebaseApp)
      .collection('users')
      .withConverter(
    fromFirestore: (snapshot, options) {
      return UserDataModel.fromMap(snapshot.id, snapshot.data()!);
    },
    toFirestore: (object, options) {
      return object.toMap();
    },
  );

  late final _userRbacCollection =
      FirebaseFirestore.instanceFor(app: firebaseApp)
          .collection('flutter_rbac_users')
          .withConverter(
    fromFirestore: (snapshot, options) {
      return FlutterRbacUsersDataModel.fromMap(snapshot.id, snapshot.data()!);
    },
    toFirestore: (object, options) {
      return object.toMap();
    },
  );

  Future<void> createUser(UserDataModel userDataModel,
      FlutterRbacUsersDataModel rbacUsersDataModel) async {
    _userCollection.doc(userDataModel.id).set(userDataModel);
    _userRbacCollection.doc(userDataModel.id).set(rbacUsersDataModel);
  }
}
