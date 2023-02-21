import 'package:flutter/cupertino.dart';

class LoginUser {
  String? email;
  String? password;

  LoginUser({
    @required email,
    @required this.password,
  });
  factory LoginUser.fromMap(Map map) {
    return LoginUser(email: map['emailAddress'], password: map['password']);
  }
  Map<String, dynamic> toMap() {
    Map map = {
      'email': email,
      'password': password,
    };
    return {...map};
  }
  // LoginUser.fromMap(Map map) {
  //   email = map['email'];
  //   password = map['password'];
  // }
}