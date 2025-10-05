import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:provider/provider.dart';
import 'package:to_do/my_theme.dart';
import 'package:to_do/provider/app_config_provider.dart';

class ThemeBottomSheetScreen extends StatefulWidget {
  const ThemeBottomSheetScreen({super.key});

  @override
  State<ThemeBottomSheetScreen> createState() => _ThemeBottomSheetScreenState();
}

class _ThemeBottomSheetScreenState extends State<ThemeBottomSheetScreen> {
  late AppConfigProvider provider;
  @override
  Widget build(BuildContext context) {
    provider = Provider.of<AppConfigProvider>(context);

    return Container(
      height: MediaQuery.of(context).size.height * 0.35,
      padding: const EdgeInsets.all(16),
      //width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
              onTap: () {
                //chamge theme dark
                provider.changeTheme(ThemeMode.dark);
              },
              child: provider.IsDarkMode()
                  ? getSelectItemWidget(AppLocalizations.of(context)!.dark)
                  : getUnSelectItemWidget(AppLocalizations.of(context)!.dark)),
          const SizedBox(
            height: 16,
          ),
          InkWell(
              onTap: () {
                //chamge theme light
                provider.changeTheme(ThemeMode.light);
              },
              child: provider.IsDarkMode()
                  ? getUnSelectItemWidget(AppLocalizations.of(context)!.light)
                  : getSelectItemWidget(AppLocalizations.of(context)!.light))
        ],
      ),
    );
  }

  Widget getSelectItemWidget(String language) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          language,
          style: provider.IsDarkMode()
              ? TextStyle(

                  ///
                  fontSize: 20,
                  color: Theme.of(context).primaryColor)
              : TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Theme.of(context).primaryColor),
        ),
        Icon(
          Icons.check,
          size: 30,
          color: Theme.of(context).primaryColor,
        )
      ],
    );
  }

  Widget getUnSelectItemWidget(String language) {
    return Text(language,
        style: provider.IsDarkMode()
            ? TextStyle(fontSize: 20, color: MyTheme.blackColor)
            : const TextStyle(
                fontSize: 20,
              ));
  }
}
