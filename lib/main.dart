import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoApp/Providers/Theme.dart';
import 'package:todoApp/Services/Constants.dart';

import 'Models/User.dart';
import 'Screens/Home.dart';
import 'Screens/Landing.dart';
import 'Services/Auth.dart';

void main() => runApp(ChangeNotifierProvider<ThemeProvider>(
      create: (BuildContext context) => ThemeProvider(),
      child: MyApp(),
    ));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          StreamProvider<User>.value(
            value: Auth().user,
          ),
        ],
        child: Consumer<ThemeProvider>(
          builder: (BuildContext context, ThemeProvider theme, Widget child) =>
              MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            themeMode: theme.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              accentColor: Color(0xff4682b4)
            ),
            theme: ThemeData(
              brightness: Brightness.light,
              primaryColor: Color(0xff5a3ea4),
              buttonColor: Colors.grey[200],
              accentColor: Color(0xfffd93a1),
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            home: Wrapper(),
          ),
        ));
  }
}

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<User>(context);
    if (user == null) {
      return LandingScreen();
    } else {
      return HomeScreen();
    }
  }
}
