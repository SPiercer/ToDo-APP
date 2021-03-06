import 'package:flutter/material.dart';

import '../Models/Task.dart';

import '../Services/Constants.dart';
import '../Services/Helpers.dart';
import '../Services/Tasks.dart';

import 'EditTaskBottomSheet.dart';

class TaskItem extends StatefulWidget {
  final String collection;
  final String date;
  final String taskID;
  final Task _task;
  TaskItem(this._task, this.collection, this.date, this.taskID);

  @override
  _TaskItemState createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  bool value = false;
  Tasks _tasksInstance = Tasks();
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      direction: DismissDirection.horizontal,
      dismissThresholds: const {
        DismissDirection.endToStart: 0.5,
        DismissDirection.startToEnd: 0.4
      },
      onDismissed: (DismissDirection direction) async {
        if (direction == DismissDirection.endToStart) {
          try {
            await _tasksInstance.deleteTask(widget.collection, widget.date);
            // ignore: unused_catch_clause
          } on Exception catch (e) {
            await Helpers.showMyDialog(
                context: context,
                msg:
                    'An error has occured while Deleting your task \n please check your connection or try again later');
          }
        } else
          await showModalBottomSheet(
              context: context,
              elevation: 500,
              barrierColor: Colors.black.withOpacity(0.1),
              isScrollControlled: true,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50))),
              builder: (BuildContext context) => EditTaskBottomSheet(
                  widget._task, widget.date, widget.taskID));
      },
      key: Key(widget._task.title),
      background: slideRightBackground(),
      secondaryBackground: slideLeftBackground(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: const BorderRadius.all(Radius.circular(12.0))),
          child: ListTile(
            onTap: () async {
              try {
                setState(() {
                  switch (value) {
                    case false:
                      value = true;
                      break;
                    case true:
                      value = false;
                      break;
                  }
                  widget._task.isCompleted = value;
                });
                await _tasksInstance.changeTaskState(
                    widget.collection, widget.taskID, widget._task.isCompleted);
              } on Exception {
                Helpers.showMyDialog(
                    context: context,
                    msg: 'An error has occured please try again');
              }
            },
            title: Text(widget._task.title,
                style: TextStyle(
                    decoration: widget._task.isCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0)),
            subtitle: RichText(
              text: TextSpan(
                style: const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0),
                children: [
                  const WidgetSpan(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2.0),
                      child: Icon(
                        Icons.access_alarm,
                        color: Colors.grey,
                        size: 18.0,
                      ),
                    ),
                  ),
                  TextSpan(text: widget._task.time),
                ],
              ),
            ),
            trailing: Checkbox(
                activeColor: Theme.of(context).accentColor,
                value: widget._task.isCompleted,
                onChanged: (bool val) async {
                  try {
                    setState(() {
                      widget._task.isCompleted = val;
                      value = val;
                    });
                    await _tasksInstance.changeTaskState(widget.collection,
                        widget.taskID, widget._task.isCompleted);
                  } on Exception {
                    Helpers.showMyDialog(
                        context: context,
                        msg: 'An error has occured please try again');
                  }
                }),
          ),
        ),
      ),
    );
  }
}
/* TODO:
3 ORGINIZE SHIT
4 ADD Task
5 ENJOI


 */
