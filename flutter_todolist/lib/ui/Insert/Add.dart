// ignore: duplicate_ignore
// ignore: file_names
// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_todolist/providers/user_provider.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';

class AddPage extends StatefulWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController datetime = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add Page'),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              child: const Text(
                'Add Page',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(6),
              child: TextField(
                controller: title,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  icon: Icon(Icons.title),
                  label: Text('Title'),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(6),
              child: TextField(
                controller: description,
                decoration: const InputDecoration(
                  icon: Icon(Icons.description),
                  border: OutlineInputBorder(),
                  labelText: 'Description',
                ),
              ),
            ),
            Container(
                padding: const EdgeInsets.all(6),
                child: Center(
                    child: TextField(
                  controller: datetime, //editing controller of this TextField
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      icon: Icon(Icons.calendar_today), //icon of text field
                      labelText: "Enter Date" //label text of field
                      ),
                  readOnly:
                      true, //set it true, so that user will not able to edit text
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1950),
                        lastDate: DateTime(2101));

                    if (pickedDate != null) {
                      String formattedDate =
                          DateFormat('yyyy-MM-dd').format(pickedDate);

                      setState(() {
                        datetime.text =
                            formattedDate; //set output date to TextField value.
                      });
                    }
                  },
                ))),
            ElevatedButton(
                onPressed: () async {
                  Provider.of<UserTodoProvider>(context, listen: false)
                      .addUserTask(title.text, description.text, datetime.text);
                  Navigator.pop(context);
                },
                child: const Text('Add Data to list'))
          ],
        ));
  }
}
