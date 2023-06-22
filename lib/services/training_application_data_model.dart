class TrainingApplicationDataModel {
  final String? id;
  final String planningId;
  final String userId;
  TrainingApplicationDataModel({
    required this.id,
    required this.planningId,
    required this.userId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'planningId': planningId,
      'userId': userId,
    };
  }

  factory TrainingApplicationDataModel.fromMap(
      String id, Map<String, dynamic> map) {
    return TrainingApplicationDataModel(
      id: id,
      planningId: map['planningId'] as String,
      userId: map['userId'] as String,
    );
  }
}
