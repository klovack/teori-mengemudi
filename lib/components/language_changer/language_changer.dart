import 'package:country_flags/country_flags.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:roadcognizer/theme/brand_colors.dart';

class LanguageChanger extends StatefulWidget {
  const LanguageChanger({super.key});

  @override
  State<LanguageChanger> createState() => _LanguageChangerState();
}

class _LanguageChangerState extends State<LanguageChanger> {
  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
      width: 60,
      trailingIcon: CountryFlagWithBorder(locale: context.locale),
      selectedTrailingIcon: CountryFlagWithBorder(locale: context.locale),
      dropdownMenuEntries: [
        ...context.supportedLocales.map(
          (locale) {
            return DropdownMenuEntry(
              label: '',
              value: locale,
              trailingIcon: CountryFlagWithBorder(
                locale: locale,
              ),
            );
          },
        ),
      ],
      enableSearch: false,
      onSelected: (Locale? value) {
        if (value != null) {
          context.setLocale(value);
        }
      },
    
      initialSelection: context.locale,
    );
  }
}

class CountryFlagWithBorder extends StatelessWidget {
  final Locale locale;

  const CountryFlagWithBorder({
    super.key,
    required this.locale,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: Theme.of(context).colorScheme.primary,
          width: 2,
        ),
      ),
      child: CountryFlag.fromCountryCode(
        locale.countryCode ?? 'US',
        height: 30,
        width: 30,
        shape: const Circle(),
      ),
    );
  }
}
