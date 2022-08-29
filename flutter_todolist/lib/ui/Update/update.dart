import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../providers/user_provider.dart';

class UpdatePage extends StatefulWidget {
  const UpdatePage({Key? key}) : super(key: key);

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  TextEditingController id = TextEditingController(text: '3');
  TextEditingController status = TextEditingController(text: '1');
  TextEditingController title = TextEditingController(text: 'Safwan Mirza');
  TextEditingController description =
      TextEditingController(text: 'what is your main goal for the week');
  TextEditingController datetime = TextEditingController(text: '2022-02-19');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Update Page'),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 8, left: 9, right: 50),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: id,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      icon: Icon(Icons.numbers),
                      contentPadding: EdgeInsets.all(2.0),
                      label: Text('id'),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 8, left: 9, right: 50),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: status,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      icon: Icon(Icons.numbers),
                      contentPadding: EdgeInsets.all(2.0),
                      label: Text('Status'),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 8, left: 9, right: 50),
                  child: TextField(
                    controller: title,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.all(2.0),
                      icon: Icon(Icons.title),
                      label: Text('Title'),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 8, left: 9, right: 50),
                  child: TextField(
                    controller: description,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(2.0),
                      icon: Icon(Icons.description),
                      border: OutlineInputBorder(),
                      labelText: 'Description',
                    ),
                  ),
                ),
                Container(
                    padding: const EdgeInsets.only(top: 8, left: 9, right: 50),
                    child: Center(
                        child: TextField(
                      controller:
                          datetime, //editing controller of this TextField
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
                      await Provider.of<UserTodoProvider>(context,
                              listen: false)
                          .updateUserTask(title.text, description.text, id.text,
                              datetime.text, status.text);

                      if (!mounted) return;
                      Navigator.of(context).pop(context);
                    },
                    child: const Text('Update Data '))
              ],
            ),
          ),
        ));
  }
}
