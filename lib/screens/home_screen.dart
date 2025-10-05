import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:to_do/my_theme.dart';
import 'package:to_do/provider/app_config_provider.dart';
import 'package:to_do/provider/auth_provider.dart';
import 'package:to_do/screens/auth/log/login_screen.dart';
import 'package:to_do/widgets/add_task_bottom_sheet.dart';
// import 'package:to_do/screens/add_task_bottom_sheet.dart';
// import 'package:to_do/screens/edit_task.dart';
import 'package:to_do/screens/missions_screen.dart';
import 'package:to_do/screens/settings/settings_screen.dart';

class HomePage extends StatefulWidget {
  static const String routeName = 'home';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    // EasyInfiniteDateTimelineController controller =
    //     EasyInfiniteDateTimelineController();
    // var focusDate = DateTime(2024);
    var provider = Provider.of<AppConfigProvider>(context);
    var authProvider = Provider.of<MyAuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.18,
        title: Text(
          currentIndex == 0
              ? AppLocalizations.of(context)!.settings
              : '''${AppLocalizations.of(context)!.app_bar_title}
(${authProvider.currentUser!.name})   ''',
          style: provider.IsDarkMode()
              ? Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Colors.black,
                  )
              : Theme.of(context).textTheme.titleLarge,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              provider.tasksList = [];
              authProvider.currentUser = null;
              Navigator.pushReplacementNamed(context, LogInScreen.routeName);
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color:
            provider.IsDarkMode() ? MyTheme.blackDarkColor : MyTheme.whiteColor,
        //height: 60,
        height: MediaQuery.of(context).size.height * 86 / 800,
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: ListView(
          children: [
            BottomNavigationBar(
              onTap: (index) {
                currentIndex = index;
                setState(() {});
              },
              currentIndex: currentIndex,
              items: [
                BottomNavigationBarItem(
                  icon: const Icon(Icons.settings),
                  label: AppLocalizations.of(context)!.settings,
                ),
                BottomNavigationBarItem(
                  icon: const Icon(
                    Icons.list,
                  ),
                  label: AppLocalizations.of(context)!.list,
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddTaskBottomSheet();
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Column(
        children: [
          taps[currentIndex],
        ],
      ),
    );
  }

  List<Widget> taps = [
    const SettingsScreen(),
    const MissionScreen(),
  ];

  void showAddTaskBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => const AddTaskBottomSheet(),
    );
  }
}
