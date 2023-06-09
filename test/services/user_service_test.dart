import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:web_application/datasource/user_datasource.dart';
import 'package:web_application/services/flutter_rbac_users_data_model.dart';
import 'package:web_application/services/user_data_model.dart';
import 'package:web_application/services/user_service.dart';

class MockDataSource extends Mock implements UserDatasource {}

class FakeUserDataModel extends Fake implements UserDataModel {}

class FakeRbacUserDataModel extends Fake implements FlutterRbacUsersDataModel {}

void main() {
  group('UserService', () {
    late UserService userService;
    late MockDataSource mockDataSource;
    late FakeUserDataModel fakeUserDataModel;
    late FakeRbacUserDataModel fakeRbacUserDataModel;

    setUpAll(() {
      fakeUserDataModel = FakeUserDataModel();
      fakeRbacUserDataModel = FakeRbacUserDataModel();
      registerFallbackValue(fakeUserDataModel);
      registerFallbackValue(fakeRbacUserDataModel);
    });

    setUp(() {
      // Initialize the mock data source and the training service
      mockDataSource = MockDataSource();
      userService = UserService(mockDataSource);
    });

    test('createUser should call the data source',
        () async {
      // Arrange
      final userId = 'user-123';
      final firstName = 'John';
      final lastName = 'Doe';
      final userName = 'johndoe@example.com';
      final userPassword = 'password';

      when(() => mockDataSource.createUser(any(), any()))
          .thenAnswer((invocation) async => Future.value());

      // Act
      await userService.createUser(
          userId, firstName, lastName, userName, userPassword);

      // Assert
      verify(() => mockDataSource.createUser(any(), any())).called(1);
    });
  });
}
