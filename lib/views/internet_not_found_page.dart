import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutterboilerplate/core/styles/text_styles.dart';
import 'package:flutterboilerplate/repositories/navigation_service.dart';

final NavigationService _navigationService = new NavigationService();

class InternetNotFoundPage extends StatelessWidget {
  void _checkConnection() async {
    var connectivity = await Connectivity().checkConnectivity();
    if (connectivity != ConnectivityResult.none) _navigationService.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Connection Problem')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.signal_cellular_connected_no_internet_4_bar,
                size: 50, color: Colors.red),
            Text('Please check your internet connection.',
                style: TextStyles.content),
            RaisedButton(
              child: Text('Try again'),
              onPressed: _checkConnection,
            )
          ],
        ),
      ),
    );
  }
}
