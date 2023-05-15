class TrainingPlanningDataModel {
  final String? id;
  final String trainingName;
  final DateTime startDate;
  final DateTime endDate;
  TrainingPlanningDataModel({
    required this.id,
    required this.trainingName,
    required this.startDate,
    required this.endDate,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'trainingName': trainingName,
      'startDate': startDate,
      'endDate': endDate,
    };
  }

  factory TrainingPlanningDataModel.fromMap(
      String id, Map<String, dynamic> map) {
    return TrainingPlanningDataModel(
      id: id,
      trainingName: map['trainingName'] as String,
      startDate: map['startDate'] as DateTime,
      endDate: map['endDate'] as DateTime,
    );
  }
}
