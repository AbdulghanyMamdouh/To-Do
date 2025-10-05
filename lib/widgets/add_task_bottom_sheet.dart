import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:to_do/firebase/task_model.dart';
import 'package:to_do/firebase/firebase_utils.dart';
import 'package:to_do/my_theme.dart';
import 'package:to_do/provider/app_config_provider.dart';
import 'package:to_do/provider/auth_provider.dart';

class AddTaskBottomSheet extends StatefulWidget {
  const AddTaskBottomSheet({super.key});

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  var chosenTime = DateTime.now();
  String title = '';
  String description = '';
  late AppConfigProvider provider;

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    provider = Provider.of<AppConfigProvider>(context);
    return Container(
      decoration: BoxDecoration(
        color:
            provider.IsDarkMode() ? MyTheme.blackDarkColor : MyTheme.whiteColor,
        borderRadius: BorderRadius.circular(24),
      ),
      height: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      width: double.infinity,
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                AppLocalizations.of(context)!.add_new_task,
                style: provider.IsDarkMode()
                    ? Theme.of(context).textTheme.titleLarge
                    : Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Colors.black,
                        ),
              ),
            ),
            TextFormField(
              maxLines: null,
              // maxLengthEnforced: false,
              keyboardType: TextInputType.multiline,
              style: TextStyle(
                color: MyTheme.primaryColor,
              ),
              onChanged: (value) {
                title = value;
              },
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.task_title,
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return AppLocalizations.of(context)!.task_name;
                }
                return null;
              },
            ),
            TextFormField(
              maxLines: null,
              // maxLengthEnforced: false,
              keyboardType: TextInputType.multiline,
              style: TextStyle(
                color: MyTheme.primaryColor,
              ),
              onChanged: (value) {
                description = value;
              },
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.task_details,
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return AppLocalizations.of(context)!.task_details;
                }
                return null;
              },
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Text(
              AppLocalizations.of(context)!.time,
              textAlign: TextAlign.end,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            InkWell(
              onTap: () {
                setState(() {
                  showCalender();
                });
              },
              child: Center(
                child: Text(
                  formattedDate,
                  style: TextStyle(color: MyTheme.grayColor, fontSize: 18),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Center(
              child: ElevatedButton(
                  onPressed: () {
                    addTask();
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(MyTheme.primaryColor),
                  ),
                  child: Text(AppLocalizations.of(context)!.add_new_task,
                      style: Theme.of(context).textTheme.titleMedium)),
            ),
          ],
        ),
      ),
    );
  }

  String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

  addTask() {
    if (formKey.currentState!.validate()) {
      var authProvider = Provider.of<MyAuthProvider>(context, listen: false);

      Task task =
          Task(title: title, description: description, dateTime: chosenTime);
      FirebaseUtils.addTaskToFirestore(
              task, authProvider.currentUser?.uId ?? '')
          .then(
        (value) {
          provider
              .getAllTasksFromFirestore(authProvider.currentUser?.uId ?? '');

          Navigator.pop(context);
          showToast(context);
        },
      );
    }
  }

  void showCalender() async {
    var returnChosenTime = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
        const Duration(days: 365),
      ),
    );
    if (returnChosenTime != null) {
      chosenTime = returnChosenTime;
      formattedDate = DateFormat('yyyy-MM-dd').format(chosenTime);
      setState(() {});
    }
  }
}

void showToast(BuildContext context) {
  Fluttertoast.showToast(
    msg: AppLocalizations.of(context)!.alert_dialog_content,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.red,
    textColor: Colors.white,
  );
}

// showAlertDialog(BuildContext context) {
//   // set up the AlertDialog
//   AlertDialog alert = AlertDialog(
//     title: Text(AppLocalizations.of(context)!.alert_dialog_title),
//     content: Text(AppLocalizations.of(context)!.alert_dialog_content),
//     actions: [
//       // TextButton(
//       //   child: Text(AppLocalizations.of(context)!.cancel),
//       //   onPressed: () {},
//       // ),
//       TextButton(
//         child: Text(AppLocalizations.of(context)!.ok),
//         onPressed: () {
//           Navigator.pop(context);
//         },
//       ),
//       // cancelButton,
//       // continueButton,
//     ],
//   );

//   // show the dialog
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return alert;
//     },
//   );
// }
