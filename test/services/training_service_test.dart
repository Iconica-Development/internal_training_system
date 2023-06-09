import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:web_application/datasource/trainings/training_datasource.dart';
import 'package:web_application/services/training_application_data_model.dart';
import 'package:web_application/services/training_data_model.dart';
import 'package:web_application/services/training_planning_data_model.dart';
import 'package:web_application/services/training_service.dart';

class MockDataSource extends Mock implements TrainingDatasource {}

class FakeTrainingDataModel extends Fake implements TrainingDataModel {}

class FakeTrainingApplicationModel extends Fake
    implements TrainingApplicationDataModel {}

class FakeTrainingPlanningDateModel extends Fake
    implements TrainingPlanningDataModel {}

void main() {
  group('TrainingService', () {
    late TrainingService trainingService;
    late MockDataSource mockDataSource;
    late FakeTrainingDataModel fakeTrainingDataModel;
    late FakeTrainingPlanningDateModel fakeTrainingPlanningDateModel;
    late FakeTrainingApplicationModel fakeTrainingApplicationModel;

    setUpAll(() {
      fakeTrainingDataModel = FakeTrainingDataModel();
      fakeTrainingPlanningDateModel = FakeTrainingPlanningDateModel();
      fakeTrainingApplicationModel = FakeTrainingApplicationModel();
      registerFallbackValue(fakeTrainingDataModel);
      registerFallbackValue(fakeTrainingPlanningDateModel);
      registerFallbackValue(fakeTrainingApplicationModel);
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

    test(
        'createTrainingPlanning should call the data source with correct parameters',
        () async {
      // Arrange
      final trainingName = 'Test Training';
      final trainerName = 'Test Trainer';
      final startDate = DateTime(2023, 1, 1);
      final endDate = DateTime(2023, 1, 5);

      when(() => mockDataSource.createTrainingPlanning(any()))
          .thenAnswer((invocation) async => Future.value());

      // Act
      await trainingService.createTrainingPlanning(
        trainingName,
        trainerName,
        startDate,
        endDate,
      );

      // Assert
      verify(() => mockDataSource.createTrainingPlanning(any())).called(1);
    });


    test(
        'createTrainingApplication should call the data source with correct parameters',
        () async {
      // Arrange
      final planningId = 'planning-123';
      final userId = 'user-456';

      when(() => mockDataSource.createTrainingApplication(any()))
          .thenAnswer((invocation) async => Future.value());
      // Act
      await trainingService.createTrainingApplication(planningId, userId);

      // Assert
      verify(() => mockDataSource.createTrainingApplication(any())).called(1);
    });
  });
}
