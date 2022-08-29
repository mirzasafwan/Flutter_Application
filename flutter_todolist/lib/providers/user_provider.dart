// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_todolist/services/todo_list.service.dart';
import 'package:hive/hive.dart';

class UserTodoProvider extends ChangeNotifier {
  var box;
  late bool _isLoading;
  late List _usertodo;
  List get usertodo => _usertodo;
  bool get isLoading => _isLoading;
  UserTodoProvider() {
    box = Hive.box('userData');
    notifyListeners();
    getUserTask();
  }

  Future<List> getUserTask() async {
    _isLoading = true;
    var emailData = box.get('email');

    if (emailData != null) {
      var getUserTask = await getPage(emailData);
      if (getUserTask == false) {
        _usertodo = [];
        _isLoading = false;
      } else {
        print(getUserTask);
        _isLoading = true;

        _usertodo = getUserTask;
        notifyListeners();

        //print(_usertodo);
      }
    } else {
      _usertodo = [];
      _isLoading = false;
    }
    _isLoading = false;
    notifyListeners();

    return _usertodo;
  }

  addUserTask(title, description, datetime) async {
    var emailData = box.get('email');
    if (emailData != null) {
      await addPage(emailData, title, description, datetime);
      await getUserTask();
    } else {}
  }

  updateUserTask(title, description, id, datetime, status) async {
    var emailData = box.get('email');

    if (emailData != null) {
      await updatePage(emailData, title, description, datetime, id, status);
      await getUserTask();
    } else {}
  }

  deleteUserTask(id) async {
    var emailData = box.get('email');
    if (emailData != null) {
      await deletePage(emailData, id);
      await getUserTask();
    } else {}
  }
}
