import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/firebase/firebase_utils.dart';
import 'package:to_do/firebase/user_model.dart';
import 'package:to_do/my_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:to_do/provider/app_config_provider.dart';
import 'package:to_do/provider/auth_provider.dart';
import 'package:to_do/screens/home_screen.dart';
import 'package:to_do/widgets/custom_textformfield.dart';
import 'package:to_do/widgets/dialog.dart';

class RegisterScreen extends StatelessWidget {
  static const String routeName = 'signup';
  final TextEditingController? nameController = TextEditingController();
  final TextEditingController? emailController = TextEditingController();
  final TextEditingController? passController = TextEditingController();
  final TextEditingController? passConfirmController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  RegisterScreen({super.key});

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
            title: Text(AppLocalizations.of(context)!.create_new_acount),
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
                  MyTextFormField(
                      label: AppLocalizations.of(context)!.first_name,
                      controller: nameController,
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'enter your name';
                        }
                        return null;
                      }),
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
                      }),
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
                  MyTextFormField(
                    label: AppLocalizations.of(context)!.confirm_password,
                    obscureText: true,
                    keyboardType: TextInputType.number,
                    controller: passConfirmController,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return 'confirm your password';
                      }
                      if (text != passController!.text) {
                        return 'passwords do not match';
                      }
                      return null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.all<Color>(Colors.blue),
                      ),
                      onPressed: () {
                        register(context);
                      },
                      child: Text(AppLocalizations.of(context)!.signup,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          )),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void register(context) async {
    if (formKey.currentState!.validate()) {
      //todo: show dialog
      DialogUtils.showLoadingDialog(
          content: 'loading...', context: context, barrierDismissible: false);
      try {
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController!.text,
          password: passController!.text,
        );
        MyUser user = MyUser(
          email: emailController!.text,
          name: nameController!.text,
          uId: credential.user?.uid,
        );
        await FirebaseUtils.addUserToFirestore(user);
        var authProvider = Provider.of<MyAuthProvider>(context, listen: false);
        authProvider.updateUser(user);
        //todo: hide dialog
        DialogUtils.hideLoadingDialog(context);
        //todo: show message
        DialogUtils.showMessage(
            context: context,
            content: 'Register successfully',
            title: 'successfully',
            posActionName: 'ok',
            posActiononPressed: () {
              Navigator.of(context).pushReplacementNamed(HomePage.routeName);
            });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          //todo: hide dialog
          DialogUtils.hideLoadingDialog(context);
          //todo: show message
          DialogUtils.showMessage(
              title: 'Failed...',
              context: context,
              content: 'The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          //todo: hide dialog
          DialogUtils.hideLoadingDialog(context);
          //todo: show message
          DialogUtils.showMessage(
              title: 'Failed...',
              context: context,
              content: 'The account already exists');
        }
      } catch (e) {
        //todo: hide dialog
        DialogUtils.hideLoadingDialog(context);
        //todo: show message
        DialogUtils.showMessage(
          context: context,
          content: e.toString(),
          title: 'Failed...',
        );
      }
      //Navigator.of(context).pushNamed(HomePage.routeName);
    }
  }
}
