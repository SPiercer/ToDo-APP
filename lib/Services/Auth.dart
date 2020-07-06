import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

import '../Models/User.dart';

class Auth {
  final FacebookLogin _fbInstance = FacebookLogin();
  final FirebaseAuth _firebaseInstance = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  User _userFromFirebase(FirebaseUser user) {
    return user != null
        ? User(
            uid: user.uid,
            imgURL: user.photoUrl,
            email: user.email,
            name: user.displayName)
        : null;
  }

  Stream<User> get user {
    return _firebaseInstance.onAuthStateChanged.map(_userFromFirebase);
  }

  void createNewFacebookUser(String token, FirebaseUser user) async {
    final http.Response graphResponse = await http.get(
        'https://graph.facebook.com/v2.12/me?fields=name,email,picture&access_token=$token');
    final Map<String, dynamic> profile = json.decode(graphResponse.body);
    final User _user = User.fromJson(profile);
    UserUpdateInfo userInfo = UserUpdateInfo();
    userInfo.displayName = _user.name;
    userInfo.photoUrl = _user.imgURL;
    await user.updateProfile(userInfo);
    await Firestore.instance.collection('Users').document(user.uid).setData({
      'name': _user.name,
      'uid': user.uid,
      'img': _user.imgURL,
      'email': _user.email,
      'source': 'facebook'
    });
  }

  void createNewGoogleUser(
      GoogleSignInAccount user, FirebaseUser firebaseUser) async {
    UserUpdateInfo userInfo = UserUpdateInfo();
    userInfo.displayName = user.displayName;
    userInfo.photoUrl = user.photoUrl;
    await firebaseUser.updateProfile(userInfo);

    await Firestore.instance
        .collection('Users')
        .document(firebaseUser.uid)
        .setData({
      'name': user.displayName,
      'uid': firebaseUser.uid,
      'img': user.photoUrl,
      'email': user.email,
      'source': 'Google'
    });
  }

  Future<void> loginUsingGoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential googleAuthCred = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
    final AuthResult authResult =
        await _firebaseInstance.signInWithCredential(googleAuthCred);
    final FirebaseUser user = authResult.user;
    createNewGoogleUser(googleUser, user);
    return _userFromFirebase(user);
  }

  Future<void> loginUsingFacebook() async {
    _fbInstance.loginBehavior = FacebookLoginBehavior.webViewOnly;
    final FacebookLoginResult result =
        await _fbInstance.logIn(['email', 'public_profile']);

    final AuthCredential facebookAuthCred = FacebookAuthProvider.getCredential(
        accessToken: result.accessToken.token);

    final AuthResult authResult =
        await FirebaseAuth.instance.signInWithCredential(facebookAuthCred);

    final FirebaseUser user = authResult.user;
    createNewFacebookUser(result.accessToken.token, user);
    return _userFromFirebase(user);
  }

  void signOut() async => await _firebaseInstance.signOut();
}
