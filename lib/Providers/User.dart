import 'package:flutter/cupertino.dart';
import 'package:todoApp/Models/User.dart';

class UserProvider extends ChangeNotifier{
  final User _user = User();
  User get user => _user; 
}