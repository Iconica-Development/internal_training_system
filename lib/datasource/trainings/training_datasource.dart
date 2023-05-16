import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:web_application/screens/Trainings/plan_training_screen.dart';
import 'package:web_application/services/training_planning_data_model.dart';

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

  late final _trainingPlanningCollection =
      FirebaseFirestore.instanceFor(app: firebaseApp)
          .collection('training_planning')
          .withConverter(
    fromFirestore: (snapshot, options) {
      return TrainingPlanningDataModel.fromMap(snapshot.id, snapshot.data()!);
    },
    toFirestore: (object, options) {
      return object.toMap();
    },
  );

  Future<void> createTraining(TrainingDataModel trainingDataModel) async {
    print(trainingDataModel.trainingGoals);
    _trainingCollection.doc().set(trainingDataModel);
  }

  Future<void> createTrainingPlanning(
      TrainingPlanningDataModel trainingPlanningDataModel) async {
    _trainingPlanningCollection.doc().set(trainingPlanningDataModel);
  }

  Future<List<TrainingDataModel>> getAllTrainingPlanningDocuments() async {
    var trainings = await _trainingCollection.get();
    return trainings.docs.map((e) => e.data()).toList();
  }
}
