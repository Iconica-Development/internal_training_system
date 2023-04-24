import 'package:firebase_core/firebase_core.dart';
import 'package:web_application/firebase_options.dart';

class TrainingDatasource {
  Future<void> createTraining(String trainingName, String trainingDesc) async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    //Check if training already exists
  //   var userSnapshot = await _userCollection.doc(userId).get();
  //   if (userSnapshot.exists) {
  //     print('This training already exist');
  //   }

  //   //Insert training into database
  //   _roleCollection.doc(role.id).set(role);
  // }

  // Future<void> deleteTraining() {
  //       await Firebase.initializeApp(
  //     options: DefaultFirebaseOptions.currentPlatform,
  //   );
  }
}
