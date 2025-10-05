import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/firebase/firebase_utils.dart';
import 'package:to_do/my_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:to_do/provider/app_config_provider.dart';
import 'package:to_do/provider/auth_provider.dart';
import 'package:to_do/screens/auth/log/reset_screen.dart';
import 'package:to_do/screens/auth/sign_up/signup_screen.dart';
import 'package:to_do/screens/home_screen.dart';
import 'package:to_do/widgets/custom_textformfield.dart';
import 'package:to_do/widgets/dialog.dart';

class LogInScreen extends StatelessWidget {
  static const String routeName = 'login';
  // final TextEditingController? nameController = TextEditingController(text: 'a@a.com');
  final TextEditingController? emailController =
      TextEditingController(text: 'a@a.com');
  final TextEditingController? passController =
      TextEditingController(text: '123456');
  // final TextEditingController? passConfirmController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  LogInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Stack(
      children: [
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
            centerTitle: true,
            title: Text(AppLocalizations.of(context)!.login),
          ),
          body: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.22,
                  ),
                  // Image.asset('images/todo-icon.png'),
                  provider.appLanguage == 'ar'
                      ? Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Text('مرحبا بعودتك...',
                              style: TextStyle(
                                  color: MyTheme.primaryColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold)),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text('Welcome back...',
                              style: TextStyle(
                                color: MyTheme.primaryColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              )),
                        ),

                  ///email
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

                  ///password
                  MyTextFormField(
                      label: AppLocalizations.of(context)!.password,
                      obscureText: true,
                      keyboardType: TextInputType.number,
                      controller: passController,
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'enter your password';
                        }
                        if (text.length < 6) {
                          return 'password must be at least 6 characters';
                        }
                        return null;
                      }),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.all<Color>(Colors.blue),
                        // MaterialStateProperty.all<Color>(Colors.blue),
                      ),
                      onPressed: () {
                        login(context);
                      },
                      child: Text(AppLocalizations.of(context)!.login,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          )),
                    ),
                  ),

                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(
                          context, ResetPassowrdScreen.routeName);
                    },
                    child: Text(AppLocalizations.of(context)!.forget_password,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                                fontSize: 16,
                                color: provider.IsDarkMode()
                                    ? MyTheme.primaryColor
                                    : MyTheme.backgrondDarkColor)),
                  ),

                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, RegisterScreen.routeName);
                    },
                    child: Text(AppLocalizations.of(context)!.new_acount,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                                fontSize: 16,
                                color: provider.IsDarkMode()
                                    ? MyTheme.primaryColor
                                    : MyTheme.backgrondDarkColor)),
                  ),

                  ///email
                  // MyTextFormField(
                  //     label: AppLocalizations.of(context)!.email,
                  //     keyboardType: TextInputType.emailAddress,
                  //     controller: emailController,
                  //     validator: (text) {
                  //       if (text == null || text.trim().isEmpty) {
                  //         return 'enter your mail address';
                  //       }
                  //       bool emailValid = RegExp(
                  //               r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                  //           .hasMatch(text);
                  //       if (!emailValid) {
                  //         return 'enter a valid email address';
                  //       }
                  //       return null;
                  //     }),
                  // ///password
                  // MyTextFormField(
                  //     label: AppLocalizations.of(context)!.password,
                  //     obscureText: true,
                  //     keyboardType: TextInputType.number,
                  //     controller: passController,
                  //     validator: (text) {
                  //       if (text == null || text.trim().isEmpty) {
                  //         return 'enter your password';
                  //       }
                  //       if (text.length < 6) {
                  //         return 'password must be at least 6 characters';
                  //       }
                  //       return null;
                  //     }),
                  // Padding(
                  //   padding: const EdgeInsets.all(10.0),
                  //   child: ElevatedButton(
                  //     style: ButtonStyle(
                  //       backgroundColor:
                  //           MaterialStateProperty.all<Color>(Colors.blue),
                  //     ),
                  //     onPressed: () {
                  //       login(context);
                  //     },
                  //     child: Text(AppLocalizations.of(context)!.login,
                  //         style: TextStyle(
                  //           color: Colors.white,
                  //           fontWeight: FontWeight.bold,
                  //           fontSize: 20,
                  //         )),
                  //   ),
                  // ),
                  // TextButton(
                  //   onPressed: () {
                  //     Navigator.pushNamed(context, RegisterScreen.routeName);
                  //   },
                  //   child: Text(AppLocalizations.of(context)!.new_acount,
                  //       style: Theme.of(context)
                  //           .textTheme
                  //           .titleMedium!
                  //           .copyWith(
                  //               color: provider.IsDarkMode()
                  //                   ? MyTheme.primaryColor
                  //                   : Colors.black)),
                  // )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void login(context) async {
    if (formKey.currentState!.validate()) {
      DialogUtils.showLoadingDialog(context: context, content: 'Waiting...');
      try {
        final credential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController!.text,
          password: passController!.text,
        );
        var user = await FirebaseUtils.readUserFromFirestore(
            credential.user?.uid ?? '');
        if (user == null) {
          return;
        }
        var authProvider = Provider.of<MyAuthProvider>(context, listen: false);
        authProvider.updateUser(user);
        //todo: hide dialog
        DialogUtils.hideLoadingDialog(context);
        //todo: show message
        DialogUtils.showMessage(
            context: context,
            content: 'Login successfully',
            title: 'successfully',
            posActionName: 'ok',
            posActiononPressed: () {
              Navigator.of(context).pushReplacementNamed(HomePage.routeName);
            });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'invalid-credential') {
          //todo: hide dialog
          DialogUtils.hideLoadingDialog(context);
          //todo: show message
          DialogUtils.showMessage(
            context: context,
            content: 'invalid-credential',
            title: 'Failed',
            negActionName: 'Cancel',
          );
        }
      } catch (e) {
        //todo: hide dialog
        //todo: hide dialog
        DialogUtils.hideLoadingDialog(context);
        //todo: show message
        DialogUtils.showMessage(
          context: context,
          content: e.toString(),
          title: 'Failed...',
        );
      }
    }
  }
}
