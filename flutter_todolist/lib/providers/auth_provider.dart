import 'package:flutter/material.dart';
import 'package:flutter_todolist/services/auth.service.dart';
import 'package:hive/hive.dart';

class AuthProvider extends ChangeNotifier {
  late bool _isLogin;
  late String _token;
  late String _email;

  bool get isLogin => _isLogin;
  String get email => _email;
  String get token => _token;
  // ignore: prefer_typing_uninitialized_variables
  var box;
  AuthProvider() {
    box = Hive.box('userdata');
    checkLogin();
  }
  userLogin(email, password) async {
    var checkData = await login(email, password);
    if (checkData == false) {
      _isLogin = false;
      box.delete('token');
      _token = '';
      _email = '';
    } else {
      _isLogin = true;
      box.put('token', checkData);
      box.put('email', email);
      _token = checkData;
    }
    notifyListeners();
  }

  checkLogin() {
    var checkToken = box.get('token');
    if (checkToken != null) {
      var userEmail = box.get('email');
      _token = checkToken;
      _isLogin = true;
      _email = userEmail;
    } else {
      _token = '';
      _isLogin = false;
      _email = '';
    }
    notifyListeners();
  }

  logout() {
    box.delete('token');
    _token = '';
    _email = '';
    _isLogin = false;
    notifyListeners();
  }
}
