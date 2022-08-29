import 'dart:convert';

import 'package:http/http.dart' as http;

// const SnackBar snackBar = SnackBar(content: Text("Successfully login"));

login(email, password) async {
  var url = Uri.parse('http://10.0.2.2:8000/api/login');
  var response = await http.post(
    url,
    body: {
      'email': email,
      'password': password,
    },
  );
  if (response.statusCode == 200) {
    return response.body;
  } else {
    return false;
  }
}

signUp(name, email, password) async {
  var url = Uri.parse('http://10.0.2.2:8000/api/signup');
  var response = await http.post(url, body: {
    'name': name,
    'email': email,
    'password': password,
  });
  if (response.statusCode == 200) {
    var data = jsonDecode(response.body);
    return data;
  } else {
    return false;
  }
}
