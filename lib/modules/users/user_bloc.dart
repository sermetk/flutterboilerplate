import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterboilerplate/modules/users/user_event.dart';
import 'package:flutterboilerplate/modules/users/user_state.dart';
import 'package:flutterboilerplate/repositories/user_service.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserService _userService = new UserService();
  UserBloc();

  @override
  UserState get initialState => Loading();
  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    if (event is InitData) {
      yield Loading();
      var result = await _userService.getUsers();
      if (result.success && result.data != null) {
        yield Loaded(data: result.data);
      } else if (result.success && result.data == null) {
        yield Empty();
      } else {
        yield Failure(error: result.message);
      }
    }
  }
}
