import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:to_do/my_theme.dart';
import 'package:to_do/provider/app_config_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:to_do/screens/auth/log/login_screen.dart';
import 'package:to_do/widgets/custom_textformfield.dart';

class ResetPassowrdScreen extends StatelessWidget {
  static const String routeName = 'reset';

  final TextEditingController? emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  ResetPassowrdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Stack(children: [
      Container(
        color: provider.IsDarkMode()
            ? MyTheme.backgrondDarkColor
            : MyTheme.backgrondLightColor,
        child: Image.asset(
          'images/background.png',
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.fill,
        ),
      ),
      Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            AppLocalizations.of(context)!.reset_password,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          centerTitle: true,
        ),
        body: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyTextFormField(
                label: AppLocalizations.of(context)!.email,
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
                validator: (text) {
                  if (text == null || text.trim().isEmpty) {
                    return 'enter your mail address';
                  }
                  bool emailValid = RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(text);
                  if (!emailValid) {
                    return 'enter a valid email address';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: MyTheme.primaryColor),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      resetPassowrd(context);
                      showToast(context);
                    }
                  },
                  child: Text(
                    AppLocalizations.of(context)!.reset_password,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ))
            ],
          ),
        ),
      ),
    ]);
  }

  Future resetPassowrd(BuildContext context) async {
    await FirebaseAuth.instance
        .sendPasswordResetEmail(email: emailController!.text.trim());
    Navigator.pushNamed(context, LogInScreen.routeName);
  }

  void showToast(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context, listen: false);

    Fluttertoast.showToast(
      msg: provider.appLanguage == 'ar'
          ? 'تم ارسال رابط الي بريدك'
          : 'check your email address now',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 4,
      backgroundColor: MyTheme.primaryColor,
      textColor: Colors.white,
    );
  }
}
