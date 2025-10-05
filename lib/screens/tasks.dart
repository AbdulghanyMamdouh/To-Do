import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:to_do/firebase/task_model.dart';
import 'package:to_do/firebase/firebase_utils.dart';
import 'package:to_do/my_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:to_do/provider/app_config_provider.dart';
import 'package:to_do/provider/auth_provider.dart';
import 'package:to_do/widgets/edit_task.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TaskListItem extends StatelessWidget {
  final Task task;

  const TaskListItem({
    Key? key,
    required this.task,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    var authProvider = Provider.of<MyAuthProvider>(context);

    // Task task;
    return Builder(
      builder: (BuildContext context) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: Slidable(
            startActionPane: ActionPane(
              extentRatio: 0.3,
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  borderRadius: BorderRadius.circular(10),
                  onPressed: (context) {
                    FirebaseUtils.deleteTaskFromFirestore(
                            task, authProvider.currentUser?.uId ?? '')
                        .timeout(
                      const Duration(milliseconds: 111),
                      onTimeout: () {
                        provider.getAllTasksFromFirestore(
                            authProvider.currentUser?.uId ?? '');
                        showToast(context);
                      },
                    );
                  },
                  backgroundColor: MyTheme.redColor,
                  foregroundColor: MyTheme.whiteColor,
                  icon: Icons.delete,
                  label: AppLocalizations.of(context)!.delete,
                ),
              ],
            ),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: MyTheme.whiteColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Container(
                      margin: const EdgeInsets.all(8),
                      width: 4,
                      height: 80,
                      color: task.isDone!
                          ? MyTheme.greenColor
                          : MyTheme.primaryColor),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          showEditTaskBottomSheet(task, context);
                          provider.getAllTasksFromFirestore(
                              authProvider.currentUser?.uId ?? '');
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              task.title ?? '',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                      color: task.isDone!
                                          ? MyTheme.greenColor
                                          : MyTheme.primaryColor),
                            ),
                            Text(
                              task.description ?? '',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: task.isDone!
                                      ? MyTheme.greenColor
                                      : MyTheme.primaryColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  //button to change the color of Container : get the value of isDone From fire base
                  Container(
                    margin: const EdgeInsets.all(4),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                    ),
                    decoration: BoxDecoration(
                      color: task.isDone!
                          ? MyTheme.greenColor
                          : MyTheme.primaryColor,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: IconButton(
                      onPressed: () async {
                        task.isDone = true; //task is done

                        FirebaseUtils.updetCheack(
                            task, authProvider.currentUser?.uId ?? '');
                        provider.getAllTasksFromFirestore(
                            authProvider.currentUser?.uId ?? '');

                        // setState(() {});
                      },
                      icon: Icon(
                        Icons.check,
                        color: MyTheme.whiteColor,
                        size: 30,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void showEditTaskBottomSheet(Task task, BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => EditTaskBottomSheet(task: task),
    );
  }
}

void showToast(BuildContext context) {
  Fluttertoast.showToast(
    msg: AppLocalizations.of(context)!.alert_dialog_content_delete,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.red,
    textColor: Colors.white,
  );
}

// taskIsDone() {}
