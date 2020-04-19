import 'package:equatable/equatable.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
}
class InitData extends UserEvent {
  @override 
  List<Object> get props => [];
}
