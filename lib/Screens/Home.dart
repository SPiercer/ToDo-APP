import 'package:flutter/material.dart';
import 'package:todoApp/Components/BottomSheet.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool taskValue = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          FloatingActionButton(
            child: Icon(
              Icons.lightbulb_outline,
              color: Theme.of(context).primaryColor,
            ),
            backgroundColor: Colors.white,
            elevation: 0,
            onPressed: () {},
          ),
          FloatingActionButton(
            child: Icon(
              Icons.add,
              color: Colors.white,
              size: 42.0,
            ),
            onPressed: () => showModalBottomSheet<void>(
                context: context,
                elevation: 500,
                barrierColor: Colors.black.withOpacity(0.1),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50))),
                builder: (BuildContext context) => MyBottomSheet()),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
          ),
          FloatingActionButton(
            child: Icon(
              Icons.settings,
              color: Theme.of(context).disabledColor,
            ),
            backgroundColor: Colors.white,
            elevation: 0,
            onPressed: () {},
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      //bottomSheet: BottomSheet(onClosing: null, builder: null),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                RichText(
                    text: TextSpan(children: <TextSpan>[
                  TextSpan(
                    text: 'Hello,\n',
                    style: TextStyle(color: Colors.grey, fontSize: 28.0),
                  ),
                  TextSpan(
                      text: 'Username',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 28.0)),
                ])),
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                )
              ],
            ),
            Container(
              height: 50,
              margin: const EdgeInsets.only(top: 20),
              child: ListView.builder(
                itemCount: 5,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                    child: Container(
                      width: 115,
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(14))),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () => print(index),
                          child: Center(
                            child: Text('SUN 29/06',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40.0, left: 8.0),
              child: Text('Tasks',
                  style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0)),
            ),
            Container(
              height: 230.0,
              child: ListView.builder(
                itemCount: 3,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius:
                              BorderRadius.all(Radius.circular(12.0))),
                      child: ListTile(
                        title: Text('Meeting with Alex',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0)),
                        subtitle: RichText(
                          text: TextSpan(
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                fontSize: 14.0),
                            children: [
                              WidgetSpan(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 2.0),
                                  child: Icon(
                                    Icons.access_alarm,
                                    color: Colors.grey,
                                    size: 18.0,
                                  ),
                                ),
                              ),
                              TextSpan(text: '12:30 PM - 01:00 PM'),
                            ],
                          ),
                        ),
                        trailing: Checkbox(
                            value: taskValue,
                            onChanged: (bool val) =>
                                setState(() => taskValue = val)),
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40.0, left: 8.0),
              child: Text('Completed',
                  style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0)),
            ),
            Container(
              height: 200.0,
              child: ListView.builder(
                itemCount: 1,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius:
                              BorderRadius.all(Radius.circular(12.0))),
                      child: ListTile(
                        title: Text('Meeting with Alex',
                            style: TextStyle(
                                decoration: TextDecoration.lineThrough,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0)),
                        subtitle: RichText(
                          text: TextSpan(
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                fontSize: 14.0),
                            children: [
                              WidgetSpan(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 2.0),
                                  child: Icon(
                                    Icons.access_alarm,
                                    color: Colors.grey,
                                    size: 18.0,
                                  ),
                                ),
                              ),
                              TextSpan(text: '12:30 PM - 01:00 PM'),
                            ],
                          ),
                        ),
                        trailing: Checkbox(
                            value: taskValue,
                            onChanged: (bool val) =>
                                setState(() => taskValue = val)),
                      ),
                    ),
                  );
                },
              ),
            ),
          ], // Column Widget Tree
        ),
      ),
    );
  }
}
