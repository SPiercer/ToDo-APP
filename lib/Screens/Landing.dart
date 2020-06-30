import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';

class LandingScreen extends StatefulWidget {
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left:35),
            child: Image.asset(
              'assets/landing.png',
              scale: 0.8,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 38.0, left: 38.0, top: 18.0),
            child: Text(
              'Organize your work',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 27.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 38.0, left: 38.0, top: 18.0),
            child: Text(
              "let's organize your work with priority and do everything without stress",
              textAlign: TextAlign.center,
              style: TextStyle(color: Color(0xFF9e9da4), fontSize: 18.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FacebookSignInButton(
              buttonColor: Colors.white,
              textStyle: TextStyle(
                fontSize: 18.0,
                fontFamily: "Roboto",
                fontWeight: FontWeight.w500,
                color: Colors.black.withOpacity(0.54),
              ),
              onPressed: () {},
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GoogleSignInButton(
              text: 'Continue with Google     ',
              onPressed: () {},
            ),
          ),
        ],
      ),
    ));
  }
}
