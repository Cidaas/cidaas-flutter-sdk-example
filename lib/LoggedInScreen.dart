import 'package:flutter/material.dart';
import 'package:flutterexample/main.dart';

class LoggedInScreen extends StatefulWidget {
  LoggedInScreen({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  static final String route = "/homepage";
  final String title;

  @override
  _LoggedInScreen createState() => _LoggedInScreen();
}

class _LoggedInScreen extends State<LoggedInScreen> {
  Duration duration;

  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        appBar: AppBar(
          title: Text('My home screen'),
        ),
        body: ListView(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: <Widget>[
              Center(
                child: RaisedButton(
                  child: Text('$_counter'),
                  onPressed: () {
                    _incrementCounter();
                  },
                ),
              ),
              Center(
                child: RaisedButton(
                    child: Text('Log out'),
                    onPressed: () => {
                          MyApp.cidaasLoginProvider
                              .doLogout()
                              .then((success) => {
                                    if (success)
                                      {
                                        //We are logged out
                                        print("Logged out!"),
                                        Navigator.pushNamed(
                                            context, MyHomePage.route)
                                      }
                                  })
                        }),
              ),
            ]));
  }
}
