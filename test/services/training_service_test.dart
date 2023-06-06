import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:web_application/datasource/trainings/training_datasource.dart';
import 'package:web_application/services/training_data_model.dart';

class MockDataSource extends Mock implements TrainingDatasource {}

class FakeTrainingDataModel extends Fake implements TrainingDataModel {}

class TrainingService {
  final TrainingDatasource _datasource;

  TrainingService(this._datasource);

  Future<void> createTraining(String trainingName, String trainingDesc,
      List<String> trainingGoals, List<String>? sourceURLs) async {
    TrainingDataModel trainingDataModel = TrainingDataModel(
        id: '',
        trainingName: trainingName,
        trainingDesc: trainingDesc,
        trainingGoals: trainingGoals,
        sourceURLs: sourceURLs);

    _datasource.createTraining(trainingDataModel);
  }
}

void main() {
  group('TrainingService', () {
    late TrainingService trainingService;
    late MockDataSource mockDataSource;
    late FakeTrainingDataModel fakeTrainingDataModel;

    setUpAll(() {
      fakeTrainingDataModel = FakeTrainingDataModel();
      registerFallbackValue(fakeTrainingDataModel);
    });

    setUp(() {
      // Initialize the mock data source and the training service
      mockDataSource = MockDataSource();
      trainingService = TrainingService(mockDataSource);
    });

    test('createTraining should call the data source', () async {
      // Arrange
      final trainingName = 'Test Training';
      final trainingDesc = 'Test description';
      final trainingGoals = ['Goal 1', 'Goal 2'];
      final sourceURLs = ['URL 1', 'URL 2'];

      when(() => mockDataSource.createTraining(any()))
          .thenAnswer((invocation) async => Future.value());

      // Act
      await trainingService.createTraining(
        trainingName,
        trainingDesc,
        trainingGoals,
        sourceURLs,
      );

      // Assert
      verify(() => mockDataSource.createTraining(any())).called(1);
    });
  });
}
