import 'package:flutter_test/flutter_test.dart';
import 'package:flutterboilerplate/core/service/service_result.dart';
import 'package:flutterboilerplate/modules/users/user_bloc.dart';
import 'package:flutterboilerplate/modules/users/user_entity.dart';
import 'package:flutterboilerplate/modules/users/user_state.dart';
import 'package:flutterboilerplate/repositories/user_service.dart';
import 'package:mockito/mockito.dart';

class MockUserRepository extends Mock implements UserService {}

void main() {
  UserBloc userBloc;
  MockUserRepository userRepository;
  setUp(() {
    userBloc = UserBloc();
    userRepository = MockUserRepository();
  });
  tearDown(() {
    userBloc?.close();
  });

  test('initial state is correct', () {
    expect(userBloc.initialState, Loading());
  });

  test('close does not emit new states', () {
    expectLater(
      userBloc,
      emitsInOrder([Loading(), emitsDone]),
    );
    userBloc.close();
  });

  group('Empty', () {
    test('emits emptystate for empty data', () {
      final expectedResponse = [
        Empty(),
      ];

      when(userRepository.getUsers()).thenAnswer((_) => Future.value(
          ServiceResult<List<UserEntity>, UserEntity>(
              success: true, data: null)));

      expectLater(userBloc, emitsInOrder(expectedResponse));
    });
  });
}
