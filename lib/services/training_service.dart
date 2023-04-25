
import 'package:web_application/services/training_data_model.dart';

import '../datasource/trainings/training_datasource.dart';

class TrainingService{
  final TrainingDatasource _datasource;

  TrainingService(TrainingDatasource datasource): _datasource = datasource;

  Future<void> createTraining(String trainingName, String trainingDesc) async {
    TrainingDataModel trainingDataModel = TrainingDataModel(id: '', trainingName: trainingName, trainingDesc: trainingDesc);

    _datasource.createTraining(trainingDataModel);
  }

}