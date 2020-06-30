import 'package:flutter/material.dart';

class MyBottomSheet extends StatefulWidget {
  @override
  _MyBottomSheetState createState() => _MyBottomSheetState();
}

class _MyBottomSheetState extends State<MyBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Divider(
            color: Colors.grey[300],
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
                    color: Colors.black,
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
              color: Colors.grey[300].withOpacity(0.4),
            ),
            child: TextField(
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
                      onPressed: () {},
                      color: Colors.grey[300].withOpacity(0.4),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      icon: Icon(Icons.date_range),
                      label: Text(
                        'Select a date',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ))),
              Container(
                  child: RaisedButton.icon(
                      onPressed: () {},
                      color: Colors.grey[300].withOpacity(0.4),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      icon: Icon(Icons.access_time),
                      label: Text(
                        'Select time',
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
                  onTap: () {},
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
    );
  }
}
