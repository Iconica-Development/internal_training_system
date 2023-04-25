
class TrainingDataModel {
  final String? id;
  final String trainingName;
  final String trainingDesc;
  final String trainingGoals;
  TrainingDataModel({
    required this.id,
    required this.trainingName,
    required this.trainingDesc, 
    required this.trainingGoals,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'trainingName': trainingName,
      'trainingDesc': trainingDesc,
      'trainingGoals': trainingGoals,
    };
  }

  factory TrainingDataModel.fromMap(String id, Map<String, dynamic> map) {
    return TrainingDataModel(
      id: id,
      trainingName: map['trainingName'] as String,
      trainingDesc: map['trainingDesc'] as String,
      trainingGoals: map['trainingGoals'] as String,
    );
  }
}
