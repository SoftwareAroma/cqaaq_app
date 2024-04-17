import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cqaaq_app/index.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class SettingsScreen extends StatefulWidget {
  static const String id = 'settings_screen';
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  /// [FormBuilder] key for the [FormBuilderState]
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  final List<String> _languagePrefList = [
    'English',
    'Asante Twi',
    'Akuapem Twi',
    'Ewe',
    'Hausa',
  ];
  final List<String> _anonymityLevelList = [
    'High',
    'Medium',
    'Low',
    'None',
  ];
  final List<String> _metaDataSharingList = [
    'No',
    'Yes',
  ];
  bool _isDark = false;

  Widget get _space => Gap(10.0.h);

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: StringResource.settingsText,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Gap(20.0.h),
            FormBuilder(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  FormBuilderDropdown(
                    name: 'language_preference',
                    initialValue: _languagePrefList.first,
                    items: _languagePrefList
                        .map((String languagePref) => DropdownMenuItem(
                              value: languagePref,
                              child: CustomText(
                                languagePref,
                                color: Theme.of(context).colorScheme.onBackground,
                              ),
                            ))
                        .toList(),
                    onChanged: (String? value) async {
                      // dartz.Either<Failure, bool> response = await BioRepo.updateMetaData(
                      //   data: {
                      //     "languagePreference": value,
                      //   },
                      // );
                      // response.fold((l) {
                      //   showCustomFlushBar(context: context, messageText: l.message);
                      // }, (r) {
                      //   showCustomFlushBar(
                      //     context: context,
                      //     messageText: "Meta Data Sharing updated successfully",
                      //   );
                      // });
                    },
                    decoration: InputDecoration(
                      labelText: "Language Preference",
                      prefixIcon: Icon(
                        LineAwesomeIcons.language,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        gapPadding: 5.0,
                      ),
                    ),
                  ),
                  _space,
                  _space,
                  FormBuilderDropdown(
                    name: 'anonymity_level',
                    initialValue: _anonymityLevelList.first,
                    items: _anonymityLevelList
                        .map((String anonymityLevel) => DropdownMenuItem(
                              value: anonymityLevel,
                              child: CustomText(
                                anonymityLevel,
                                color: Theme.of(context).colorScheme.onBackground,
                              ),
                            ))
                        .toList(),
                    onChanged: (String? value) async {
                      // dartz.Either<Failure, bool> response = await BioRepo.updateMetaData(
                      //   data: {
                      //     "anonymityLevel": value,
                      //   },
                      // );
                      // response.fold((l) {
                      //   showCustomFlushBar(context: context, messageText: l.message);
                      // }, (r) {
                      //   showCustomFlushBar(
                      //     context: context,
                      //     messageText: "Meta Data Sharing updated successfully",
                      //   );
                      // });
                    },
                    decoration: InputDecoration(
                      labelText: "Anonymity Level",
                      prefixIcon: Icon(
                        LineAwesomeIcons.user_shield,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        gapPadding: 5.0,
                      ),
                    ),
                  ),
                  _space,
                  _space,
                  FormBuilderDropdown(
                    name: 'meta_data_sharing',
                    initialValue: _metaDataSharingList.first,
                    items: _metaDataSharingList
                        .map((String metaDataSharing) => DropdownMenuItem(
                              value: metaDataSharing,
                              child: CustomText(
                                metaDataSharing,
                                color: Theme.of(context).colorScheme.onBackground,
                              ),
                            ))
                        .toList(),
                    onChanged: (String? value) async {
                      // dartz.Either<Failure, bool> response = await BioRepo.updateMetaData(
                      //   data: {
                      //     "metaDataSharing": value,
                      //   },
                      // );
                      // response.fold((l) {
                      //   showCustomFlushBar(context: context, messageText: l.message);
                      // }, (r) {
                      //   showCustomFlushBar(
                      //     context: context,
                      //     messageText: "Meta Data Sharing updated successfully",
                      //   );
                      // });
                    },
                    decoration: InputDecoration(
                      labelText: "Meta Data Sharing",
                      prefixIcon: Icon(
                        LineAwesomeIcons.creative_commons_share,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        gapPadding: 5.0,
                      ),
                    ),
                  ),
                  _space,
                ],
              ),
            ),
            _space,
            _space,
            ListTile(
              leading: Icon(
                _isDark ? LineAwesomeIcons.sun : LineAwesomeIcons.moon,
                size: 20,
                color: Theme.of(context).colorScheme.primary,
              ),
              title: AutoSizeText(
                _isDark ? StringResource.lightThemeText : StringResource.darkThemeText,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  fontSize: 18.0,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
              trailing: Switch(
                value: AdaptiveTheme.of(context).mode.isDark,
                onChanged: (bool value) {
                  setState(() {
                    _isDark = value;
                  });
                  if (value) {
                    AdaptiveTheme.of(context).setDark();
                  } else {
                    AdaptiveTheme.of(context).setLight();
                  }
                },
              ),
              onTap: () {},
            ),
            _space,
            Expanded(child: Container()),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10.0.w),
              child: CustomButton(
                title: "Get In Touch",
                color: Theme.of(context).colorScheme.primary,
                onPressed: () {
                  // Navigator.of(context).pushNamed(DonationScreen.id);
                },
              ),
            ),
            _space,
            _space,
          ],
        ),
      ),
    );
  }
}
