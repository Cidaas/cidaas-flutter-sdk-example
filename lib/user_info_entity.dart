import 'package:flutter/material.dart';

class UserInfoEntity with ChangeNotifier {
  String email;
  String sub;
  UserInfoEntity(
      {this.email,
      this.sub
      });
  UserInfoEntity.fromJson(Map<String, dynamic> json)
      : sub = json['sub'],
        email = json['email'];

  Map<String, dynamic> toJson() => {
        'sub': sub,
        'email': email
      };

  Future<void> updateUserEntity(UserInfoEntity updatedEntity) async {
    if (updatedEntity != null) {
      email = updatedEntity.email;
      sub = updatedEntity.sub;
      notifyListeners();
    }
  }

}
