import 'package:cloud_firestore/cloud_firestore.dart';

class TrainingPlanningDataModel {
  final String id;
  final String trainingName;
  final String trainerName;
  final DateTime startDate;
  final DateTime endDate;
  TrainingPlanningDataModel({
    required this.id,
    required this.trainingName,
    required this.trainerName,
    required this.startDate,
    required this.endDate,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'trainingName': trainingName,
      'trainerName': trainerName,
      'startDate': startDate,
      'endDate': endDate,
    };
  }

  factory TrainingPlanningDataModel.fromMap(
      String id, Map<String, dynamic> map) {
    return TrainingPlanningDataModel(
      id: id,
      trainingName: map['trainingName'] as String,
      trainerName: map['trainerName'] as String,
      startDate: DateTime.fromMillisecondsSinceEpoch(
          map['startDate'].millisecondsSinceEpoch),
      endDate: DateTime.fromMillisecondsSinceEpoch(
          map['endDate'].millisecondsSinceEpoch),
    );
  }
}
