
class TrainingDataModel {
  final String? id;
  final String trainingName;
  final String trainingDesc;
  TrainingDataModel({
    required this.id,
    required this.trainingName,
    required this.trainingDesc,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'trainingName': trainingName,
      'trainingDesc': trainingDesc,
    };
  }

  factory TrainingDataModel.fromMap(String id, Map<String, dynamic> map) {
    return TrainingDataModel(
      id: id,
      trainingName: map['trainingName'] as String,
      trainingDesc: map['trainingDesc'] as String,
    );
  }
}
