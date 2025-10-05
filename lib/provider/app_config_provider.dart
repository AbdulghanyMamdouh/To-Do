import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do/firebase/task_model.dart';
import 'package:to_do/firebase/firebase_utils.dart';

class AppConfigProvider extends ChangeNotifier {
  String appLanguage = 'ar';
  ThemeMode appTheme = ThemeMode.dark;
  List<Task> tasksList = [];
  DateTime selectedDate = DateTime.now();
  bool isDone = false;

  void changeLanguage(String newLanguage) async {
    if (appLanguage == newLanguage) {
      return;
    } else {
      appLanguage = newLanguage;
    }
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('language', appLanguage);

    notifyListeners();
  }

  void changeTheme(ThemeMode newTheme) async {
    if (appTheme == newTheme) {
      return;
    } else {
      appTheme = newTheme;
    }
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(
        'themeMode',
        appTheme == ThemeMode.dark
            ? 'dark'
            : appTheme == ThemeMode.system
                ? 'system'
                : 'light');
    notifyListeners();
  }

  bool IsDarkMode() {
    return appTheme == ThemeMode.dark;
  }

  void getAllTasksFromFirestore(String uId) async {
    QuerySnapshot<Task> querySnapshot =
        await FirebaseUtils.getTaskCollection(uId)
            //.where('dateTime', isEqualTo: selectedDate.millisecondsSinceEpoch)
            .get();
    tasksList = querySnapshot.docs
        .map(
          (docs) => docs.data(),
        )
        .toList();

    //filter selected date
    tasksList = tasksList.where(
      (task) {
        if (selectedDate.day == task.dateTime?.day &&
            selectedDate.month == task.dateTime?.month &&
            selectedDate.year == task.dateTime?.year) {
          return true;
        } else {
          return false;
        }
      },
    ).toList();

    // sorting
    tasksList.sort(
      (task1, task2) => task1.dateTime!.compareTo(task2.dateTime!),
    );

    notifyListeners();
  }

  void changeSelectedDate(DateTime newSelectedDate, String uId) {
    selectedDate = newSelectedDate;
    getAllTasksFromFirestore(uId);
    notifyListeners();
  }

  // bool toggleTodoStatus(Task todo) {
  //   todo.isDone = todo.isDone;
  //   FirebaseUtils.updateTodo(todo);

  //   return todo.isDone!;
  // }

  // bool changeIsDone(Task task) {
  //   isDone = task.isDone!;
  //   if (isDone == true) {
  //     notifyListeners();
  //     return true;
  //   } else {
  //     notifyListeners();

  //     return false;
  //   }
  // }
}
