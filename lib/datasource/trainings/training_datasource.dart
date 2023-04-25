import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import '../../services/training_data_model.dart';

class TrainingDatasource {
  TrainingDatasource({
    required this.firebaseApp,
  });

  final FirebaseApp firebaseApp;

  late final _trainingCollection =
      FirebaseFirestore.instanceFor(app: firebaseApp)
          .collection('trainings')
          .withConverter(
    fromFirestore: (snapshot, options) {
      return TrainingDataModel.fromMap(snapshot.id, snapshot.data()!);
    },
    toFirestore: (object, options) {
      return object.toMap();
    },
  );

  Future<void> createTraining(TrainingDataModel trainingDataModel) async {
    //Check if training already exists
      // var trainingSnapshot = await _trainingCollection.doc(trainingDataModel.id).get();
      // if (trainingSnapshot.exists) {
      //   print('This training already exist'); 
      // }

    //   //Insert training into database
      _trainingCollection.doc().set(trainingDataModel);
  }

  // Future<TrainingDataModel> getAllInfoForTraining(String trainingId) async {

  // }
}
