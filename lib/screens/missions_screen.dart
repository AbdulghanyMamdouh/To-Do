import 'package:flutter/material.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:provider/provider.dart';
import 'package:to_do/my_theme.dart';
import 'package:to_do/provider/app_config_provider.dart';
import 'package:to_do/provider/auth_provider.dart';
import 'package:to_do/screens/tasks.dart';

class MissionScreen extends StatefulWidget {
  const MissionScreen({Key? key}) : super(key: key);

  @override
  MissionScreenState createState() => MissionScreenState();
}

class MissionScreenState extends State<MissionScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch tasks when the screen is initialized
    var authProvider = Provider.of<MyAuthProvider>(context, listen: false);
    Provider.of<AppConfigProvider>(context, listen: false)
        .getAllTasksFromFirestore(authProvider.currentUser?.uId ?? '');
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    var authProvider = Provider.of<MyAuthProvider>(context);

    return Expanded(
      child: Column(
        children: [
          EasyDateTimeLine(
            headerProps: EasyHeaderProps(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              selectedDateStyle: TextStyle(
                color: MyTheme.primaryColor,
                fontSize: 20,
              ),
              monthStyle: TextStyle(
                color: MyTheme.primaryColor,
                fontSize: 20,
              ),
            ),
            locale: provider.appLanguage,
            initialDate: provider.selectedDate,
            onDateChange: (selectedDate) {
              provider.changeSelectedDate(
                  selectedDate, authProvider.currentUser?.uId ?? '');
            },
            dayProps: EasyDayProps(
              inactiveDayStyle: DayStyle(
                dayStrStyle: TextStyle(
                  color: MyTheme.blackColor,
                  fontWeight: FontWeight.w700,
                ),
                monthStrStyle: TextStyle(
                  color: MyTheme.blackColor,
                  fontWeight: FontWeight.w700,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: MyTheme.primaryColor,
                    width: 2,
                    style: BorderStyle.solid,
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(8),
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      MyTheme.primaryColor,
                      MyTheme.backgrondLightColor,
                    ],
                  ),
                ),
              ),
              todayStyle: DayStyle(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(8),
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      MyTheme.greenColor,
                      MyTheme.whiteColor,
                    ],
                  ),
                ),
              ),
              todayHighlightColor: MyTheme.greenColor,
              activeDayStyle: const DayStyle(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xff3371FF),
                      Color(0xff8426D6),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            flex: 1,
            child: Consumer<AppConfigProvider>(
              builder: (context, provider, _) {
                return provider.tasksList.isEmpty
                    ? Image.asset(
                        'images/emptytask.png',
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.fill,
                      )
                    //  Text(
                    //     'No Task',
                    //     style: TextStyle(
                    //       color: MyTheme.redColor,
                    //       fontWeight: FontWeight.w700,
                    //       fontSize: 24,
                    //     ),
                    //   )
                    : ListView.builder(
                        itemBuilder: (context, index) {
                          return TaskListItem(
                            task: provider.tasksList[index],
                          );
                        },
                        itemCount: provider.tasksList.length,
                      );
              },
            ),
          )
        ],
      ),
    );
  }
}
