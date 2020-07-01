import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:todoApp/Models/User.dart';

class AuthLogin {
  final FacebookLogin _fbInstance = FacebookLogin();
  final FirebaseAuth _firebaseInstance = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email'
    ]
  );
  User _userFromFirebase(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  Stream<User> get user {
    return _firebaseInstance.onAuthStateChanged.map(_userFromFirebase);
  }

  void createNewFacebookUser(String token) async {
    final http.Response graphResponse = await http.get(
        'https://graph.facebook.com/v2.12/me?fields=name,email,picture&access_token=$token');
    final profile = json.decode(graphResponse.body);
    print(profile);
    final user = User.fromJson(profile);
    Firestore.instance.collection('Users').document(user.uid).setData({
      'name': user.name,
      'uid': user.uid,
      'img': user.imgURL,
      'email': user.email,
      'source': 'facebook'
    });
  }

  void createNewGoogleUser(GoogleSignInAccount user) async {
    await Firestore.instance.collection('Users').document(user.id).setData({
      'name': user.displayName,
      'uid': user.id,
      'img': user.photoUrl,
      'email': user.email,
      'source': 'Google'
    });
  }

  Future<void> loginUsingGoogle() async {
    try {
      print('lets GO');
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential googleAuthCred = GoogleAuthProvider.getCredential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
      final AuthResult authResult =
          await _firebaseInstance.signInWithCredential(googleAuthCred);
      final FirebaseUser user = authResult.user;
      createNewGoogleUser(googleUser);
      return _userFromFirebase(user);
    } catch (error) {
      print(error);
    }
  }

  Future<void> loginUsingFacebook() async {
    _fbInstance.loginBehavior = FacebookLoginBehavior.webViewOnly;
    final result = await _fbInstance.logIn(['email', 'public_profile']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final AuthCredential facebookAuthCred =
            FacebookAuthProvider.getCredential(
                accessToken: result.accessToken.token);

        final AuthResult authResult =
            await FirebaseAuth.instance.signInWithCredential(facebookAuthCred);

        final FirebaseUser user = authResult.user;
        createNewFacebookUser(result.accessToken.token);
        return _userFromFirebase(user);
        break;

      case FacebookLoginStatus.cancelledByUser:
        print('canceled');
        break;

      case FacebookLoginStatus.error:
        print(result.errorMessage);
        break;
    }
  }

  void signOut() async {
    try {
      return await _firebaseInstance.signOut();
    } catch (e) {
      print(e);
    }
  }
}
