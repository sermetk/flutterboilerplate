import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterboilerplate/modules/users/user_detail_page.dart';
import 'package:flutterboilerplate/modules/users/user_page.dart';
import 'package:flutterboilerplate/views/internet_not_found_page.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case "User":
      return getRoute(UserPage());
    case "UserDetail":
      return getRoute(UserDetail(data:settings.arguments));
    case "InternetNotFoundPage":
      return MaterialPageRoute(
          builder: (context) =>
              ModalRoute.of(context).settings.name != settings.name
                  ? InternetNotFoundPage()
                  : null);
    default:
      return getRoute(Center(
        child: Text('No path for ${settings.name}'),
      ));
  }
}

MaterialPageRoute getRoute(Widget page) {
  return MaterialPageRoute(builder: (context) => page);
}
