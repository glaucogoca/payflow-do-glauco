import 'package:flutter/material.dart';
import 'package:payflow/shared/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController {
  UserModel? _user;

  UserModel get user => _user!;

  void setUser(BuildContext context, UserModel? user) {
    if (user != null) {
      _user = user;
      saveUser(user);
      Navigator.pushReplacementNamed(context, "/home");
    } else {
      Navigator.pushReplacementNamed(context, "/login");
    }
  }

  void saveUser(UserModeluser) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("user", user.toJSON());
    return;
  }

  Future<void> currentUser(BuildContext context) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    await Future.delayed(const Duration(seconds: 2));
    if (sharedPreferences.containsKey("user")) {
      final user = sharedPreferences.get("user") as String;
      setUser(context, UserModel.fromJSON(user));
    } else {
      setUser(context, null);
    }
    return;
  }
}
