import 'package:flutter/material.dart';
import 'package:flutterboilerplate/modules/users/user_entity.dart';

class UserDetail extends StatelessWidget {
  final UserEntity data;
  const UserDetail({@required this.data}) : assert(data != null);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(data.title),
          backgroundColor: Colors.grey
        ),
        body: Container(padding: EdgeInsets.all(20), child: Text(data.body)));
  }
}
