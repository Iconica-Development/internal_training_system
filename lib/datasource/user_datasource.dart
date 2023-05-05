import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
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

  Future<void> createUser(UserDataModel userDataModel) async {
    _userCollection.doc().set(userDataModel);
  }
}
