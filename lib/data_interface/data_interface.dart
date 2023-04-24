

import 'package:web_application/data_interface/models/training_data_model.dart';

abstract class DataInterface {
  DataInterface._();

  Future<void> createTraining(TrainingDataModel trainingDataModel);
}