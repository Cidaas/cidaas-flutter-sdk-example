import 'package:cidaas_flutter_sdk/cidaas_flutter_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'LoggedInScreen.dart';

void main() {
  runApp(
    App(),
  );
}

class App extends StatefulWidget {
  static final String route = "/startPage";

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
    printInitAuth();
  }

  printInitAuth() async {
    print("isauth on init: " + (await CidaasLoginProvider.isAuth()).toString());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthenticationBloc>(
      create: (context) {
        return AuthenticationBloc();
      },
      child: MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: Text('App'),
            ),
            body: MyCidaasImpl()),
        routes: {
          App.route: (context) => App(),
          LoggedInScreen.route: (context) => LoggedInScreen()
        },
      ),
    );
  }
}

class MyCidaasImpl extends Cidaas {
  @override
  Widget getLoggedInScreen({tokenEntity}) {
    return LoggedInScreen(tokenEntity: tokenEntity);
  }

  @override
  Widget getSplashScreen() {
    return Center(
      //child: CircularProgressIndicator(),
      child: Text('Please wait'),
    );
  }

  @override
  Widget getLoggedOutScreen({context}) {
    return Center(
        child: RaisedButton(
      child: Text('Login'),
      onPressed: () {
        CidaasLoginProvider.doLogin(context);
      },
    ));
  }

  @override
  Widget getAuthenticationFailureScreen({errorMessage}) {
    return Scaffold(
        body: Center(
      child: Text('$errorMessage', style:
        TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.red)),
    ));
  }
}
