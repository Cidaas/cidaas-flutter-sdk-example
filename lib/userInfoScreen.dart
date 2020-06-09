import 'package:flutter/material.dart';
import './user_info_entity.dart';
import 'package:cidaassdkflutter/cidaassdkflutter.dart';
import 'package:provider/provider.dart';

class UserInfoScreen extends StatefulWidget {
  static const routeName = "/info";

  @override
  _UserInfoScreenState createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  UserInfoEntity _currentUserEntity;
  UserInfoEntity updatedUserEntity;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final curscale = MediaQuery.of(context).textScaleFactor;

    return Center(
      child: Text("The email '$_currentUserEntity.email' has got the sub $_currentUserEntity.sub",
          style: TextStyle(fontSize: 22 / curscale)),
    );
  }

  void mapCurrentUserToUpdatedUser() {
    updatedUserEntity = UserInfoEntity();
    updatedUserEntity.sub = _currentUserEntity.sub;
    updatedUserEntity.email = _currentUserEntity.email;
  }
}
