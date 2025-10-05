import 'package:flutter/material.dart';
import 'package:to_do/firebase/user_model.dart';

class MyAuthProvider extends ChangeNotifier {
  MyUser? currentUser;
  void updateUser(newUser) {
    currentUser = newUser;
    notifyListeners();
  }
}
