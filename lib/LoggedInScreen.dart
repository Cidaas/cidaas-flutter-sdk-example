import 'package:cidaas_flutter_sdk/cidaas_flutter_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutterexample/user_info_entity.dart';

class LoggedInScreen extends StatefulWidget {
  LoggedInScreen({Key key, this.title, this.tokenEntity}) : super(key: key);

  static final String route = "/loggedIn";
  final String title;
  final TokenEntity tokenEntity;

  @override
  _LoggedInScreen createState() => _LoggedInScreen(tokenEntity);
}

class _LoggedInScreen extends State<LoggedInScreen> {
  Duration duration;

  int _counter = 0;
  TokenEntity tokenEntity;
  UserInfoEntity userInfoEntity;

  List<Item> _data = new List();

  @override
  void initState() {
    super.initState();
  }

  _LoggedInScreen(TokenEntity tokenEntity) {
    this.tokenEntity = tokenEntity;
    print("Received Token from event: ${tokenEntity.toString()}");
    refreshTokenDataDisplay();
  }

  void refreshTokenDataDisplay() async {
    TokenEntity tokenEntity = await CidaasLoginProvider.getStoredAccessToken();
    var claims =
        CidaasLoginProvider.getTokenClaimSetForToken(tokenEntity.idToken);
    print("Claims in LoggedInScreen: " + claims.toString());
    this.userInfoEntity = UserInfoEntity.fromJson(claims);
    List<Item> _list = new List();
    _list.add(new Item(headerValue: 'Email', content: userInfoEntity.email));
    _list.add(new Item(
        headerValue: 'Complete userInfo',
        content: userInfoEntity.toJson().toString()));
    _list.add(new Item(headerValue: 'Sub', content: tokenEntity.sub));
    _list.add(new Item(
        headerValue: 'Access_token', content: tokenEntity.accessToken));
    _list.add(new Item(
        headerValue: 'Refresh_token', content: tokenEntity.refreshToken));
    _list.add(new Item(headerValue: 'Id_token', content: tokenEntity.idToken));
    setState(() {
      _data = _list;
    });
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget _buildTokenInfos() {
      return ExpansionPanelList(
        expansionCallback: (int index, bool isExpanded) {
          setState(() {
            this._data[index].isExpanded = !isExpanded;
          });
        },
        children: this._data.map<ExpansionPanel>((Item item) {
          return ExpansionPanel(
            headerBuilder: (BuildContext context, bool isExpanded) {
              return ListTile(
                title: Text('${item.headerValue}'),
              );
            },
            body: ListTile(
                title: Text('${item.content}'),
                subtitle: Text('To delete this panel, tap the trash can icon'),
                trailing: Icon(Icons.delete),
                onTap: () {
                  setState(() {
                    this
                        ._data
                        .removeWhere((currentItem) => item == currentItem);
                  });
                }),
            isExpanded: item.isExpanded,
          );
        }).toList(),
      );
    }

    return Scaffold(
        body: ListView(
            physics: ScrollPhysics(),
            shrinkWrap: true,
            children: <Widget>[
          Center(
            child: RaisedButton(
              child: Text('$_counter'),
              onPressed: () {
                // Navigate to the second screen using a named route.
                _incrementCounter();
              },
            ),
          ),
          Center(
            child: RaisedButton(
              child: Text('Reload token data'),
              onPressed: () {
                // Navigate to the second screen using a named route.
                refreshTokenDataDisplay();
              },
            ),
          ),
          Center(
            child: RaisedButton(
              child: Text('Log out'),
              onPressed: () {
                // Navigate to the second screen using a named route.
                CidaasLoginProvider.doLogout(context).whenComplete(() => {
                      CidaasLoginProvider.isAuth().then((val) => {print(val)})
                    });
              },
            ),
          ),
          Center(
            child: RaisedButton(
              child: Text('Print isAuth'),
              onPressed: () {
                CidaasLoginProvider.isAuth().then((val) => {print(val)});
              },
            ),
          ),
          _buildTokenInfos()
        ]));
  }
}

class Item {
  Item({
    this.content,
    this.headerValue,
    this.isExpanded = false,
  });

  String content;
  String headerValue;
  bool isExpanded;
}
