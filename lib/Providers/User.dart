import 'package:flutter/Material.dart';

import '../Models/User.dart';

class UserProvider extends ChangeNotifier {
  final User _user = User();
  User get user => _user;
}
