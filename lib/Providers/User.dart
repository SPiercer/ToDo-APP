import 'package:flutter/cupertino.dart';

import '../Models/User.dart';

class UserProvider extends ChangeNotifier{
  final User _user = User();
  User get user => _user; 
}