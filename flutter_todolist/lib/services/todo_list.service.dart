import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

getPage(email) async {
  var box = Hive.box('userdata');
  var token = box.get('token');
  var newtoken = token.toString().replaceAll('"', '');

  Map<String, String> header = {'Authorization': 'Bearer $newtoken'};
  // print(header);
  var url = Uri.parse('http://10.0.2.2:8000/api/auth/getUserData');
  var response = await http.post(
    url,
    body: {
      'email': email,
    },
    headers: header,
  );

  if (response.statusCode == 200) {
    var data = jsonDecode(response.body);
    return data['success'];
  } else {
    return false;
  }
}

addPage(email, title, description, datetime) async {
  var box = Hive.box('userData');
  var token = box.get('token');
  var newtoken = token.toString().replaceAll('"', '');
  Map<String, String> header = {'Authorization': 'Bearer $newtoken'};
  var url = Uri.parse('http://10.0.2.2:8000/api/auth/addUserData');
  var response = await http.post(
    url,
    body: {
      'email': email,
      'title': title,
      'description': description,
      'datetime': datetime
    },
    headers: header,
  );

  if (response.statusCode == 200) {
    return jsonEncode(response.body);
  } else {
    return false;
  }
}

updatePage(email, title, description, datetime, id, status) async {
  var box = Hive.box('userData');
  var token = box.get('token');
  var newtoken = token.toString().replaceAll('"', '');
  Map<String, String> header = {'Authorization': 'Bearer $newtoken'};
  var url = Uri.parse('http://10.0.2.2:8000/api/auth/updateUserData');
  var response = await http.post(
    url,
    body: {
      'email': email,
      'title': title,
      'description': description,
      'datetime': datetime,
      'todoId': id.toString(),
      'status': status.toString(),
    },
    headers: header,
  );
  if (response.statusCode == 200) {
    return jsonEncode(response.body);
  } else {
    return false;
  }
}

deletePage(email, id) async {
  var box = Hive.box('userData');
  var token = box.get('token');
  var newtoken = token.toString().replaceAll('"', '');
  Map<String, String> header = {'Authorization': 'Bearer $newtoken'};
  var url = Uri.parse('http://10.0.2.2:8000/api/auth/deleteUserData');
  var response = await http.post(
    url,
    body: {
      'email': email,
      'todoId': id.toString(),
    },
    headers: header,
  );
  if (response.statusCode == 200) {
    return response.body;
  } else {
    return false;
  }
}
