import 'package:cloud_firestore/cloud_firestore.dart';

import '../Models/Task.dart';

class Tasks {
  Future<void> editTask(
          {String date, String uid, String taskID, Task task}) async =>
      await Firestore.instance
          .collection('Users/$uid/Dates/$date/Todos')
          .document(taskID)
          .updateData({
        'title': task.title,
        'time': task.time,
        'completed': task.isCompleted
      });

  Future<void> deleteTask(String collection, String document) async =>
      await Firestore.instance
          .collection(collection)
          .document(document)
          .delete();

  Future<void> changeTaskState(
          String collection, String document, bool state) async =>
      await Firestore.instance
          .collection(collection)
          .document(document)
          .updateData({'completed': !state ? false : true});

  Future<void> addTask({String date, String uid, Task task}) async {
    await Firestore.instance
        .collection('Users/$uid/Dates')
        .document(date)
        .setData({'time': date});

    await Firestore.instance
        .collection('Users/$uid/Dates/$date/Todos')
        .document()
        .setData({
      'title': task.title,
      'time': task.time,
      'completed': task.isCompleted
    });
  }
}
