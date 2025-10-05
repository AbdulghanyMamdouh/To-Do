import 'package:flutter/material.dart';

class DialogUtils {
  static void showLoadingDialog(
      {required context,
      required String content,
      bool barrierDismissible = true}) {
    showDialog(
      barrierDismissible: barrierDismissible,
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).primaryColor),
              ),
              const SizedBox(width: 10),
              Text(content),
            ],
          ),
        );
      },
    );
  }

  static void hideLoadingDialog(BuildContext context) {
    Navigator.pop(context);
  }

  static void showMessage(
      {required context,
      required String content,
      String? title,
      String? posActionName,
      Function? posActiononPressed,
      String? negActionName,
      Function? negActiononPressed,
      bool barrierDismissible = true}) {
    List<Widget>? actions = [];
    if (posActionName != null) {
      actions.add(
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();

            if (posActiononPressed != null) {
              posActiononPressed.call();
            }
          },
          child: Text(posActionName),
        ),
      );
    }
    if (negActionName != null) {
      actions.add(
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();

            if (negActiononPressed != null) {
              negActiononPressed.call();
            }
          },
          child: Text(negActionName),
        ),
      );
    }

    showDialog(
      barrierDismissible: barrierDismissible,
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(content),
          title: Text(title ?? ''),
          actions: actions,
        );
      },
    );
  }
}
