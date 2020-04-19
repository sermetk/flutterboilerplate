import 'package:equatable/equatable.dart';
import 'package:flutterboilerplate/modules/users/user_entity.dart';
import 'package:meta/meta.dart';

abstract class UserState extends Equatable{
  const UserState();
  @override 
  List<Object>get props=>[];
}

class Loading extends UserState {}

class Loaded extends UserState {

  final List<UserEntity> data;
  
  const Loaded({@required this.data}): assert(data != null);

  @override
  List<Object> get props => [data];
}

class Empty extends UserState {}

class Failure extends UserState {
  final String error;

  const Failure({@required this.error});

  @override
  List<Object> get props => [error];
 
  @override
  String toString() => 'UsersFailure { error: $error }';
}