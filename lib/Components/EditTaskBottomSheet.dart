import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoApp/Models/Task.dart';
import 'package:todoApp/Models/User.dart';
import 'package:todoApp/Services/Helpers.dart';
import 'package:todoApp/Services/Tasks.dart';

class EditTaskBottomSheet extends StatefulWidget {
  final Task _task;
  final String date;
  final String taskID;
  EditTaskBottomSheet(this._task, this.date, this.taskID);
  @override
  _EditTaskBottomSheetState createState() => _EditTaskBottomSheetState();
}

class _EditTaskBottomSheetState extends State<EditTaskBottomSheet> {
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
              child: Text('Edit this task',
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
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
                color: Colors.grey[300].withOpacity(0.4),
              ),
              child: TextField(
                onChanged: (String val) => setState(() => title = val),
                decoration: InputDecoration(
                    labelStyle: TextStyle(color: Colors.grey, fontSize: 16.0),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(
                        left: 15, bottom: 11, top: 11, right: 15),
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
                        onPressed: null,
                        color: Colors.grey[300].withOpacity(0.4),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        icon: Icon(Icons.date_range),
                        label: Text(
                          widget.date,
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
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
                      if (title == null || time == 'Select time') {
                        Helpers.showMyDialog(
                            context: context,
                            msg:
                                'No task was edited \n Please fill up all the fields');
                      } else {
                        await Tasks().editTask(
                          date: widget.date,
                          taskID: widget.taskID,
                          task: Task(
                              title: title,
                              time: time,
                              isCompleted: widget._task.isCompleted),
                          uid: Provider.of<User>(context, listen: false).uid,
                        );
                        Navigator.pop(context);
                      }
                    },
                    child: Center(
                      child: Text('Done',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
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
