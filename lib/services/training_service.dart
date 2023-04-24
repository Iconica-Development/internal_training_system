
import 'package:web_application/data_interface/models/training_data_model.dart';
import 'package:web_application/datasource/trainings/training_datasource.dart';

class TrainingService{
  final TrainingDatasource _trainingDatasource;

  TrainingService(TrainingDatasource trainingDatasource): _trainingDatasource = trainingDatasource;

  Future<void> createTraining(TrainingDataModel trainingDataModel) async {
    _trainingDatasource.createTraining(trainingDataModel);
  }

}