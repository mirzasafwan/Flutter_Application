// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_todolist/providers/auth_provider.dart';
import 'package:flutter_todolist/providers/user_provider.dart';
import 'package:flutter_todolist/ui/Insert/Add.dart';
import 'package:flutter_todolist/ui/Update/update.dart';

import 'package:flutter_todolist/ui/auth/login.dart';
import 'package:hive/hive.dart';

import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Directory appDocDir = await getApplicationDocumentsDirectory();

  String appDocPath = appDocDir.path;

  Hive.init(appDocPath);
  await Hive.openBox('userdata');
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()),
      ChangeNotifierProvider<UserTodoProvider>(
          create: (_) => UserTodoProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Provider.of<AuthProvider>(context, listen: true).isLogin
          ? const MyHome()
          : const Login(),
    );
  }
}

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  @override
  @override
  Widget build(BuildContext context) {
    // final userFalse = Provider.of<UserTodoProvider>(context, listen: false);
    final userTrue = Provider.of<UserTodoProvider>(context, listen: true);
    final authFalse = Provider.of<AuthProvider>(context, listen: false);
    //final authTrue = Provider.of<AuthProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                await authFalse.logout();
              },
              icon: const Icon(Icons.logout))
        ],
        title: const Text('Todo Application'),
        centerTitle: false,
      ),
      body: userTrue.isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : userTrue.usertodo.isNotEmpty
              ? FutureBuilder<List>(
                  future: userTrue.getUserTask(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData && snapshot.data == null) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return ListView.builder(
                        itemCount: snapshot.data?.length,
                        itemBuilder: ((context, index) {
                          var todo = snapshot.data![index];
                          return Card(
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(10),
                                  child: Text('${todo['title']}'),
                                ),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  child: Text('${todo['description']}'),
                                ),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  child: Text('${todo['datetime']}'),
                                ),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  child: Text(todo['status'] == 2
                                      ? 'Pending'
                                      : todo['status'] == 0
                                          ? 'Started'
                                          : 'Done'),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      child: ElevatedButton(
                                        onPressed: () async {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      UpdatePage()));
                                        },
                                        child: Text('Update'),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      child: ElevatedButton(
                                        onPressed: () async {
                                          await Provider.of<UserTodoProvider>(
                                                  context,
                                                  listen: false)
                                              .deleteUserTask(todo['id']);
                                        },
                                        child: Text('Delete'),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        }),
                      );
                    }
                  })
              : const Center(
                  child: Text('No data found'),
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => AddPage()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
