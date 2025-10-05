import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
//import 'package:islamic/screens/settings/language_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:to_do/my_theme.dart';
import 'package:to_do/provider/app_config_provider.dart';
import 'package:to_do/widgets/language_bottom_sheet.dart';
import 'package:to_do/widgets/theme_bottom_sheet.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Container(
      margin: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          Text(
            AppLocalizations.of(context)!.language,
            style: provider.IsDarkMode()
                ? Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: MyTheme.whiteColor)
                : Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          InkWell(
            onTap: () {
              showLanguageBottomSheet();
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: provider.IsDarkMode()
                      ? MyTheme.backgrondDarkColor
                      : MyTheme.whiteColor,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color: MyTheme.primaryColor,
                  )),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      provider.appLanguage == 'en'
                          ? AppLocalizations.of(context)!.english
                          : AppLocalizations.of(context)!.arabic,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: MyTheme.primaryColor,
                            fontSize: 20,
                          ),
                    ),
                    Icon(
                      Icons.arrow_drop_down,
                      size: 40,
                      color: MyTheme.primaryColor,
                    )
                  ]),
            ),
          ),
          const SizedBox(height: 30),
          Text(
            AppLocalizations.of(context)!.theme,
            style: provider.IsDarkMode()
                ? Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: MyTheme.whiteColor)
                : Theme.of(context).textTheme.titleMedium,
          ),
          InkWell(
            onTap: () {
              showThemeBottomSheet();
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: provider.IsDarkMode()
                    ? MyTheme.blackDarkColor
                    : MyTheme.whiteColor,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                  color: MyTheme.primaryColor,
                ),
              ),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      provider.IsDarkMode()
                          ? AppLocalizations.of(context)!.dark
                          : AppLocalizations.of(context)!.light,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: MyTheme.primaryColor,
                            fontSize: 20,
                          ),
                    ),
                    Icon(
                      Icons.arrow_drop_down,
                      color: MyTheme.primaryColor,
                      size: 40,
                    )
                  ]),
            ),
          ),
        ],
      ),
    );
  }

  void showThemeBottomSheet() {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(40),
        ),
        side: BorderSide(color: MyTheme.primaryColor, width: 4, strokeAlign: 2),
      ),
      context: context,
      builder: (context) => const ThemeBottomSheetScreen(),
    );
  }

  void showLanguageBottomSheet() {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(40),
        ),
        side: BorderSide(color: MyTheme.primaryColor, width: 4, strokeAlign: 2),
      ),
      context: context,
      builder: (context) => const LanguageBottomSheetScreen(),
    );
  }
}
