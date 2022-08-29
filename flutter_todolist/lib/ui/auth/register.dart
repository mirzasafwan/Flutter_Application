// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_todolist/ui/auth/login.dart';

import '../../services/auth.service.dart';

class Register extends StatelessWidget {
  const Register({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController name = TextEditingController();
    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo'),
        centerTitle: false,
      ),
      body: Container(
        margin: const EdgeInsets.all(5),
        child: SingleChildScrollView(
          child: Column(children: [
            const Center(
              child: Text(
                'Register',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(5),
              child: TextField(
                controller: name,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Name',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(5),
              child: TextField(
                controller: email,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(5),
              child: TextField(
                obscureText: true,
                controller: password,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  if (email.text.isNotEmpty &&
                      password.text.isNotEmpty &&
                      password.text.length > 7 &&
                      name.text.isNotEmpty) {
                    await signUp(name.text, email.text, password.text);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Login()));
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: const Text('Account Successfully Created'),
                      backgroundColor: Colors.green.shade800,
                      duration: const Duration(milliseconds: 50),
                    ));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Please fill the details'),
                      backgroundColor: Colors.redAccent,
                      duration: Duration(milliseconds: 50),
                    ));
                  }
                },
                child: const Text('Register')),
          ]),
        ),
      ),
    );
  }
}
