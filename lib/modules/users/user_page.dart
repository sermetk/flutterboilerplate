import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutterboilerplate/core/locator/service_locator.dart';
import 'package:flutterboilerplate/modules/users/user_bloc.dart';
import 'package:flutterboilerplate/modules/users/user_entity.dart';
import 'package:flutterboilerplate/modules/users/user_event.dart';
import 'package:flutterboilerplate/modules/users/user_state.dart';
import 'package:flutterboilerplate/repositories/navigation_service.dart';

class UserPage extends StatelessWidget {
  final userBloc = UserBloc();
  @override
  Widget build(BuildContext context) {
    userBloc.add(InitData());
    return BlocProvider<UserBloc>(
        create: (context) => userBloc,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.grey,
            title: Text('Users')
          ),
          body: BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              if (state is Loading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is Loaded) {
                return ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      return NotificationWidget(data: state.data[index]);
                    },
                    itemCount: state.data.length);
              } else if (state is Failure) {
                return Center(child: Text(state.error));
              } else if (state is Empty) {
                return Center(child: Text("No data"));
              } else {
                return Center(child: Text("Unexpected state"));
              }
            },
          ),
        ));
  }
}

class NotificationWidget extends StatelessWidget {
  final UserEntity data;
  const NotificationWidget({Key key, @required this.data}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final NavigationService _navigationService = locator<NavigationService>();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(5.0),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
          child: GestureDetector(
            onTap: () => _navigationService.push("UserDetail", arguments: data),
            child: ListTile(
              leading: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: data.id % 2 == 0 ? Colors.yellow : Colors.blueGrey),
                padding: EdgeInsets.all(12),
                child: SvgPicture.asset(
                  data.id % 2 == 0 ? "assets/phone.svg" : "assets/mail.svg",
                  color: data.id % 2 == 0 ? Colors.blueGrey : Colors.yellow,
                ),
              ),
              title: Text(data.title),
              subtitle: Text(data.body),
              dense: true,
            ),
          ),
        ),
      ),
    );
  }
}
