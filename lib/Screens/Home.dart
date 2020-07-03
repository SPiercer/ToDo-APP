import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Components/AddTaskBottomSheet.dart';
import '../Components/RadioItem.dart';
import '../Components/TaskItem.dart';

import '../Models/Radio.dart';
import '../Models/Task.dart';
import '../Models/User.dart';

import '../Providers/Theme.dart';
import '../Services/Auth.dart';
import '../Services/Helpers.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TValue case2<TOptionType, TValue>(
    TOptionType selectedOption,
    Map<TOptionType, TValue> branches, [
    // ignore: avoid_init_to_null
    TValue defaultValue = null,
  ]) {
    if (!branches.containsKey(selectedOption)) {
      return defaultValue;
    }

    return branches[selectedOption];
  }

  List<RadioModel> radioModel = new List<RadioModel>();
  String selectedDate = '';
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    return Scaffold(
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          FloatingActionButton(
            child: Wrap(
              alignment: WrapAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.lightbulb_outline,
                  color: Theme.of(context).accentColor,
                ),
                Text('Tasks',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Theme.of(context).accentColor))
              ],
            ),
            backgroundColor: Colors.white,
            elevation: 0,
            onPressed: null,
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
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50))),
                builder: (BuildContext context) => AddTaskBottomSheet()),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
          ),
          FloatingActionButton(
            child: Wrap(
              alignment: WrapAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.arrow_back,
                  color: Theme.of(context).iconTheme.color,
                ),
                Text('back',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Theme.of(context).iconTheme.color))
              ],
            ),
            backgroundColor: Theme.of(context).backgroundColor,
            elevation: 0,
            onPressed: () {
              try {
                Auth().signOut();
              } on Exception catch (e) {
                print(e);
                Helpers.showMyDialog(
                    context: context,
                    msg:
                        'An Error occured while signing out \n please try again or check your connection');
              }
            },
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
                  const TextSpan(
                    text: 'Hello,\n',
                    style: const TextStyle(color: Colors.grey, fontSize: 28.0),
                  ),
                  TextSpan(
                      text: user.name,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).textTheme.button.color,
                          fontSize: 28.0)),
                ])),
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      image: DecorationImage(image: NetworkImage(user.imgURL)),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                ),
              ],
            ),
            ListTile(
              title: Text('Switch Theme'),
              trailing: Switch(
                activeColor: Theme.of(context).accentColor,
                value: Provider.of<ThemeProvider>(context).isDarkMode,
                onChanged: (boolVal) {
                  Provider.of<ThemeProvider>(context, listen: false)
                      .updateTheme(boolVal);
                },
              ),
            ),
            Container(
              height: 50,
              margin: const EdgeInsets.only(top: 20),
              child: StreamBuilder<QuerySnapshot>(
                  stream: Firestore.instance
                      .collection('Users/${user.uid}/Dates')
                      .snapshots(),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.active:
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data.documents.length,
                          itemBuilder: (BuildContext context, int index) {
                            radioModel.add(RadioModel(
                                false, snapshot.data.documents[index]['time']));
                            return Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, right: 8.0),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    radioModel.forEach((element) =>
                                        element.isSelected = false);
                                    radioModel[index].isSelected = true;
                                    selectedDate = snapshot
                                        .data.documents[index].documentID;
                                  });
                                },
                                child: new RadioItem(radioModel[index]),
                              ),
                            );
                          },
                        );
                        break;
                      case ConnectionState.waiting:
                        return Center(child: CircularProgressIndicator());
                      default:
                        return Container();
                    }
                  }),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 25.0, left: 8.0),
              child: const Text('Tasks',
                  style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0)),
            ),
            case2(
              selectedDate,
              {
                '': const Expanded(
                    child: Center(
                  child: Text(
                    "Please select a date \n or add your first task",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 28.0),
                  ),
                ))
              },
              Container(
                height: 175.0,
                child: StreamBuilder<QuerySnapshot>(
                    stream: Firestore.instance
                        .collection(
                            'Users/${user.uid}/Dates/$selectedDate/Todos')
                        .where('completed', isEqualTo: false)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.data.documents.length != 0) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.active:
                            return ListView.builder(
                              itemCount: snapshot.data.documents.length,
                              itemBuilder: (BuildContext context, int index) {
                                final DocumentSnapshot task =
                                    snapshot.data.documents[index];
                                return TaskItem(
                                    Task(
                                        title: task['title'],
                                        time: task['time'],
                                        isCompleted: task['completed']),
                                    'Users/${user.uid}/Dates/$selectedDate/Todos',
                                    selectedDate,
                                    task.documentID);
                              },
                            );
                            break;
                          case ConnectionState.waiting:
                            return Center(child: CircularProgressIndicator());
                          default:
                            return Container();
                        }
                      } else {
                        return const Center(
                          child: Text(
                            'Yay!\n Looks like there is no Tasks for today.',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 28.0),
                          ),
                        );
                      }
                    }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 8.0),
              child: const Text('Completed',
                  style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0)),
            ),
            case2(
                selectedDate,
                {
                  '': const Expanded(
                      child: Center(
                    child: Text(
                      "",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 28.0),
                    ),
                  ))
                },
                Container(
                  height: 175.0,
                  child: StreamBuilder<QuerySnapshot>(
                      stream: Firestore.instance
                          .collection(
                              'Users/${user.uid}/Dates/$selectedDate/Todos')
                          .where('completed', isEqualTo: true)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.data.documents.length != 0) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.active:
                              return ListView.builder(
                                itemCount: snapshot.data.documents.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final DocumentSnapshot task =
                                      snapshot.data.documents[index];
                                  return TaskItem(
                                      Task(
                                          title: task['title'],
                                          time: task['time'],
                                          isCompleted: task['completed']),
                                      'Users/${user.uid}/Dates/$selectedDate/Todos',
                                      selectedDate,
                                      task.documentID);
                                },
                              );
                              break;
                            case ConnectionState.waiting:
                              return Center(child: CircularProgressIndicator());
                            default:
                              return Container();
                          }
                        } else {
                          return const Center(
                            child: Text(
                              "Here lies your completed tasks \n Go on fill this list up !",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 28.0),
                            ),
                          );
                        }
                      }),
                )),
          ], // Column Widget Tree
        ),
      ),
    );
  }
}
