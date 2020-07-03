import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../Models/Task.dart';
import '../Models/User.dart';

import '../Services/Helpers.dart';
import '../Services/Tasks.dart';

class AddTaskBottomSheet extends StatefulWidget {
  @override
  _AddTaskBottomSheetState createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  String date = 'Select a date';
  String time = 'Select time';
  String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Divider(
              thickness: 5,
              indent: 135,
              endIndent: 135,
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Create a task',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40.0, left: 8.0),
            child: Text('Task title',
                style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0)),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                color: Colors.grey[300].withOpacity(0.2),
              ),
              child: TextField(
                onChanged: (String val) => setState(() => title = val),
                decoration: InputDecoration(
                    labelStyle: TextStyle(color: Colors.grey, fontSize: 16.0),
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                    labelText: 'Task title'),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0, left: 8.0),
            child: Text('Select date & time',
                style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                    child: RaisedButton.icon(
                        onPressed: () async {
                          DateTime _date = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2020),
                              lastDate: DateTime(2060));
                          String day;
                          _date.day < 10 ? day = '0d' : day = 'd';
                          setState(() {
                            date = DateFormat('EEE $day-MM').format(_date);
                          });
                        },
                        color: Colors.grey[300].withOpacity(0.4),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15))),
                        icon: Icon(Icons.date_range),
                        label: Text(
                          date,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ))),
                Container(
                    child: RaisedButton.icon(
                        onPressed: () async {
                          TimeOfDay _time = await showTimePicker(
                              context: context, initialTime: TimeOfDay.now());
                          setState(() {
                            time = _time.format(context);
                          });
                        },
                        color: Colors.grey[300].withOpacity(0.4),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15))),
                        icon: Icon(Icons.access_time),
                        label: Text(
                          time,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ))),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0, left: 8.0, top: 15.0),
            child: Container(
              height: 65,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                elevation: 5,
                color: Theme.of(context).accentColor,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () async {
                      print(date);
                      if (title == null || date == 'Select a date' || time == 'Select time') {
                        Helpers.showMyDialog(context: context,msg: 'No task was created \n Please fill up all the fields');
                      } else {
                        await Tasks().addTask(
                          date: date,
                          task:
                              Task(title: title, time: time, isCompleted: false),
                          uid: Provider.of<User>(context, listen: false).uid,
                        );
                      }
                    },
                    child: Center(
                      child: Text('Done',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
