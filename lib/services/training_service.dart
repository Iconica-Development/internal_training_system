
import 'package:web_application/datasource/trainings/training_datasource.dart';

class TrainingService{
  final TrainingDatasource _trainingDatasource;

  TrainingService(TrainingDatasource trainingDatasource): _trainingDatasource = trainingDatasource;

  Future<void> createTraining(String trainingName, String trainingDesc) async {
    _trainingDatasource.createTraining(trainingName, trainingDesc);
  }

}