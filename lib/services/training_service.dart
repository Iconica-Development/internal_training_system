import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:web_application/services/training_application_data_model.dart';
import 'package:web_application/services/training_data_model.dart';
import 'package:web_application/services/training_planning_data_model.dart';

import '../datasource/trainings/training_datasource.dart';

class TrainingService {
  final TrainingDatasource _datasource;

  TrainingService(TrainingDatasource datasource) : _datasource = datasource;

  Future<void> createTraining(String trainingName, String trainingDesc,
      List<String> trainingGoals, List<String>? sourceURLs) async {
    TrainingDataModel trainingDataModel = TrainingDataModel(
        id: '',
        trainingName: trainingName,
        trainingDesc: trainingDesc,
        trainingGoals: trainingGoals,
        sourceURLs: sourceURLs);

    _datasource.createTraining(trainingDataModel);
  }

  Future<void> createTrainingPlanning(
    String trainingName,
    String trainerName,
    DateTime startDate,
    DateTime endDate,
  ) async {
    TrainingPlanningDataModel trainingPlanningDataModel =
        TrainingPlanningDataModel(
      id: '',
      trainingName: trainingName,
      trainerName: trainerName,
      startDate: startDate,
      endDate: endDate,
    );

    _datasource.createTrainingPlanning(trainingPlanningDataModel);
  }

  Future<List<TrainingPlanningDataModel>> getAllTrainingsData() async {
    return _datasource.getAllTrainingPlanningDocuments();
  }

  Future<List<TrainingDataModel>> getAllTrainingsBase() async {
    return _datasource.getAllTrainingsBase();
  }


  Future<List<TrainingPlanningDataModel>> getAllTrainingApplications(
      String userId) async {
    return _datasource.getAllTrainingApplications(userId);
  }

  Future<TrainingPlanningDataModel?> getTrainingById(String trainingId) async {
    return _datasource.getTrainingById(trainingId);
  }

  Future<void> createTrainingApplication(
    String planningId,
    String userId,
  ) async {
    TrainingApplicationDataModel trainingApplicationDataModel =
        TrainingApplicationDataModel(
      id: '',
      planningId: planningId,
      userId: userId,
    );

    _datasource.createTrainingApplication(trainingApplicationDataModel);
  }
}
