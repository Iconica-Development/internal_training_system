class TrainingDataModel {
  final String? id;
  final String trainingName;
  final String trainingDesc;
  final List<String> trainingGoals;
  final List<String>? sourceURLs;
  TrainingDataModel(
      {required this.id,
      required this.trainingName,
      required this.trainingDesc,
      required this.trainingGoals,
      required this.sourceURLs});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'trainingName': trainingName,
      'trainingDesc': trainingDesc,
      'trainingGoals': trainingGoals,
      'sourceURLs': sourceURLs
    };
  }

  factory TrainingDataModel.fromMap(String id, Map<String, dynamic> map) {
    return TrainingDataModel(
        id: id,
        trainingName: map['trainingName'] as String,
        trainingDesc: map['trainingDesc'] as String,
        trainingGoals: map['trainingGoals'] as List<String>,
        sourceURLs: map['sourceURLs'] as List<String>);
  }
}
