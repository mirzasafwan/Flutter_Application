// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:flutter_todolist/providers/auth_provider.dart';
import 'package:flutter_todolist/ui/auth/register.dart';

import 'package:provider/provider.dart';

import '../../services/auth.service.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    TextEditingController email =
        TextEditingController(text: 'test123@gmail.com');
    TextEditingController password = TextEditingController(text: '12345678');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo'),
        centerTitle: false,
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Center(
            child: Text(
              'Login',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: email,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: TextField(
              obscureText: true,
              controller: password,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                width: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  SchedulerBinding.instance.addPostFrameCallback((_) async {
                    var check = await login(email.text, password.text);
                    if (check != false &&
                        email.text.isNotEmpty &&
                        password.text.isNotEmpty &&
                        password.text.length > 7) {
                      await Provider.of<AuthProvider>(context, listen: false)
                          .userLogin(email.text, password.text);
                    }
                    // add your code here.
                  });
                },
                child: const Text('Login'),
              ),
              const SizedBox(
                width: 10,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Register()));
                  },
                  child: const Text('Register')),
            ],
          )
        ]),
      ),
    );
  }
}
