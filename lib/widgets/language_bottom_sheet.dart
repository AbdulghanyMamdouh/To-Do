import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:provider/provider.dart';
import 'package:to_do/provider/app_config_provider.dart';

class LanguageBottomSheetScreen extends StatefulWidget {
  const LanguageBottomSheetScreen({super.key});

  @override
  State<LanguageBottomSheetScreen> createState() =>
      _LanguageBottomSheetScreenState();
}

class _LanguageBottomSheetScreenState extends State<LanguageBottomSheetScreen> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);

    return Container(
      height: MediaQuery.of(context).size.height * 0.35,
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
              onTap: () {
                //chamge language en
                provider.changeLanguage('en');
              },
              child: provider.appLanguage == 'en'
                  ? getSelectItemWidget(AppLocalizations.of(context)!.english)
                  : getUnSelectItemWidget(
                      AppLocalizations.of(context)!.english)),
          const SizedBox(
            height: 16,
          ),
          InkWell(
              onTap: () {
                //chamge language ar
                provider.changeLanguage('ar');
              },
              child: provider.appLanguage == 'ar'
                  ? getSelectItemWidget(AppLocalizations.of(context)!.arabic)
                  : getUnSelectItemWidget(AppLocalizations.of(context)!.arabic))
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
          style: TextStyle(
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
    return Text(
      language,
      style: const TextStyle(fontSize: 20),
    );
  }
}
