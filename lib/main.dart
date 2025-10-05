import 'dart:io';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do/my_theme.dart';
import 'package:to_do/provider/app_config_provider.dart';
import 'package:to_do/provider/auth_provider.dart';
import 'package:to_do/screens/auth/log/login_screen.dart';
import 'package:to_do/screens/auth/log/reset_screen.dart';
import 'package:to_do/screens/auth/sign_up/signup_screen.dart';
import 'package:to_do/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Ensure that plugin initialization has completed before running the app
  //WidgetsFlutterBinding.ensureInitialized();

  // Initialize SharedPreferences
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
              apiKey: 'AIzaSyDCW03cV_RIYIVsHEL9QVMwkKVG4d73eeM',
              appId: '1:2602944681:android:fab9d7824513c9e041c1b8',
              messagingSenderId: '2602944681',
              projectId: 'to-do-app-56ba8'))
      : await Firebase.initializeApp();

  //await FirebaseFirestore.instance.disableNetwork();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => AppConfigProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => MyAuthProvider(),
      ),
    ],
    child: MyApp(),
  ));
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  late AppConfigProvider provider;

  MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    provider = Provider.of<AppConfigProvider>(context);
    intialPrefraances();
    return MaterialApp(
      routes: {
        HomePage.routeName: (context) => const HomePage(),
        RegisterScreen.routeName: (context) => RegisterScreen(),
        LogInScreen.routeName: (context) => LogInScreen(),
        ResetPassowrdScreen.routeName: (context) => ResetPassowrdScreen(),
      },
      initialRoute: LogInScreen.routeName,
      debugShowCheckedModeBanner: false,
      theme: MyTheme.lightMode,
      darkTheme: MyTheme.darkMode,
      themeMode: provider.appTheme,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(provider.appLanguage),
    );
  }

  Future<void> intialPrefraances() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? lang = prefs.getString('language');
    String? theme = prefs.getString('themeMode');
    provider.changeLanguage(lang ??= "en");
    if (theme == "light") {
      provider.changeTheme(ThemeMode.light);
    } else if (theme == 'dark') {
      provider.changeTheme(ThemeMode.dark);
    }
  }
}
