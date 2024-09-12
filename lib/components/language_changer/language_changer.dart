import 'package:country_flags/country_flags.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LanguageChanger extends StatefulWidget {
  const LanguageChanger({super.key});

  @override
  State<LanguageChanger> createState() => _LanguageChangerState();
}

class _LanguageChangerState extends State<LanguageChanger> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      child: DropdownButton(
        icon: const SizedBox(),
        underline: const SizedBox(),
        elevation: 5,
        borderRadius: BorderRadius.circular(8),
        dropdownColor: Colors.black.withOpacity(0.4),
        isExpanded: true,
        items: [
          ...context.supportedLocales.map(
            (locale) {
              return DropdownMenuItem(
                alignment: Alignment.center,
                value: locale,
                child: CountryFlag.fromCountryCode(
                  locale.countryCode ?? 'US',
                  height: 30,
                  width: 30,
                  shape: const Circle(),
                ),
              );
            },
          ),
        ],
        onChanged: (Locale? value) {
          if (value != null) {
            context.setLocale(value);
          }
        },
        value: context.locale,
      ),
    );
  }
}
