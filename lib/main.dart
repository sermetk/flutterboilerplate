import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutterboilerplate/core/bloc/bloc_delegate.dart';
import 'package:flutterboilerplate/core/locator/service_locator.dart';
import 'package:flutterboilerplate/modules/users/user_page.dart';
import 'package:flutterboilerplate/repositories/navigation_service.dart';
import 'package:flutterboilerplate/core/navigation/router.dart' as router;

bool get isInDebugMode {
  var inDebugMode = false;
  assert(inDebugMode = true);
  return inDebugMode;
}

Future<Null> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  FlutterError.onError = (FlutterErrorDetails details) async {
    if (isInDebugMode) {
      FlutterError.dumpErrorToConsole(details);
    } else {
      Zone.current.handleUncaughtError(details.exception, details.stack);
    }
  };

  runZoned<Future<Null>>(() async {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none)
      {
        var _navigationService = locator<NavigationService>();
        _navigationService.push("InternetNotFoundPage");
      }
    });
    BlocSupervisor.delegate = MainBlocDelegate();
    runApp(Flutterboilerplate());
  }, onError: (error, stackTrace) async {
    await _reportError(error, stackTrace);
  });
}

Future<Null> _reportError(dynamic error, dynamic stackTrace) async {
  print('Caught error: $error');
  if (isInDebugMode) {
    print(stackTrace);
    return;
  }
  //Send error to tracker, crashlytics, appcenter etc.
}

class Flutterboilerplate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Boiler Plate',
      navigatorKey: locator<NavigationService>().navigatorKey,
      onGenerateRoute: router.generateRoute,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: UserPage(),
    );
  }
}