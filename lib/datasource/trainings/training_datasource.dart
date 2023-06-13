import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:web_application/screens/Trainings/plan_training_screen.dart';
import 'package:web_application/services/training_application_data_model.dart';
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

  late final _trainingApplicationCollection =
      FirebaseFirestore.instanceFor(app: firebaseApp)
          .collection('training_application')
          .withConverter(
    fromFirestore: (snapshot, options) {
      return TrainingApplicationDataModel.fromMap(
          snapshot.id, snapshot.data()!);
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

  Future<List<TrainingPlanningDataModel>>
      getAllTrainingPlanningDocuments() async {
    var trainings = await _trainingPlanningCollection
        .where('startDate', isGreaterThan: DateTime.now())
        .get();
    return trainings.docs.map((e) => e.data()).toList();
  }

  Future<List<TrainingDataModel>> getAllTrainingsBase() async {
    var trainings = await _trainingCollection.get();
    return trainings.docs.map((e) => e.data()).toList();
  }

  Future<List<TrainingPlanningDataModel>> getAllTrainingApplications(
      String userId) async {
    List<dynamic> planningIds = [];

    try {
      final QuerySnapshot querySnapshot = await _trainingApplicationCollection
          .where('userId', isEqualTo: userId)
          .get();

      querySnapshot.docs.forEach((DocumentSnapshot docSnapshot) {
        dynamic fieldValue = docSnapshot.get('planningId');
        planningIds.add(fieldValue);
      });

      if (planningIds.isEmpty) {
        print('No training applications found for the user.');
        return [];
      }

      var plannedTrainings = await _trainingPlanningCollection
          .where(FieldPath.documentId, whereIn: planningIds)
          .get();

      var currentDate = DateTime.now();
      var futureTrainings = plannedTrainings.docs.where((doc) {
        DateTime startDate = doc.get('startDate').toDate();
        return startDate.isAfter(currentDate);
      }).toList();

      return futureTrainings.map((e) => e.data()).toList();
    } catch (error) {
      print('Error retrieving training applications: $error');
      return [];
    }
  }

  Future<void> createTrainingApplication(
      TrainingApplicationDataModel trainingApplicationDataModel) async {
    _trainingApplicationCollection.doc().set(trainingApplicationDataModel);
  }

  Future<TrainingPlanningDataModel?> getTrainingById(String trainingId) async {
    var training = await _trainingPlanningCollection.doc(trainingId).get();
    return training.data();
  }
}
