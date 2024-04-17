import 'dart:async';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:cqaaq_app/index.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:form_builder_validators/localization/l10n.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// initialize services from ServiceInitializer class
  await ServiceInitializer.instance.initializeSettings();

  /// Initialize the [AdaptiveTheme] package
  final AdaptiveThemeMode? savedThemeMode = await AdaptiveTheme.getThemeMode();
  runApp(MyApp(savedThemeMode: savedThemeMode));
}

class MyApp extends StatelessWidget {
  final AdaptiveThemeMode? savedThemeMode;
  const MyApp({
    super.key,
    this.savedThemeMode,
  });

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
        ColorScheme lightScheme;
        ColorScheme darkScheme;

        if (lightDynamic != null && darkDynamic != null) {
          lightScheme = lightDynamic.harmonized();
          lightCustomColors = lightCustomColors.harmonized(lightScheme);
          darkScheme = darkDynamic.harmonized();
          darkCustomColors = darkCustomColors.harmonized(darkScheme);
        } else {
          lightScheme = lightColorScheme;
          darkScheme = darkColorScheme;
        }
        return ScreenUtilInit(
          designSize: const Size(320, 690),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (BuildContext context, Widget? child) {
            return AdaptiveTheme(
              light: ThemeData(
                useMaterial3: true,
                colorScheme: lightScheme,
                extensions: <ThemeExtension<dynamic>>[lightCustomColors],
                fontFamily: GoogleFonts.poppins().fontFamily,
                textTheme: GoogleFonts.poppinsTextTheme(),
              ),
              dark: ThemeData(
                useMaterial3: true,
                colorScheme: darkScheme,
                extensions: <ThemeExtension<dynamic>>[darkCustomColors],
                fontFamily: GoogleFonts.poppins().fontFamily,
                textTheme: GoogleFonts.poppinsTextTheme(),
              ),
              initial: savedThemeMode ?? AdaptiveThemeMode.light,
              builder: (ThemeData theme, ThemeData darkTheme) {
                return GetMaterialApp(
                  builder: (BuildContext context, Widget? widget) {
                    return widget!;
                  },
                  title: StringResource.appName,
                  debugShowCheckedModeBanner: false,
                  theme: theme,
                  darkTheme: darkTheme,
                  locale: const Locale('en', 'US'),
                  localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
                    FormBuilderLocalizations.delegate,
                    ...globalDelegates,
                  ],
                  supportedLocales: const <Locale>[
                    ...supportedLocales,
                    ...FormBuilderLocalizations.supportedLocales,
                  ],
                  initialRoute: HomeScreen.id,
                  onUnknownRoute: (RouteSettings settings) {
                    return MaterialPageRoute<dynamic>(
                      builder: (BuildContext context) => const NotFoundScreen(),
                    );
                  },
                  routes: <String, WidgetBuilder>{
                    LoginScreen.id: (BuildContext context) => const LoginScreen(),
                    RegisterScreen.id: (BuildContext context) => const RegisterScreen(),
                    PhoneAuthScreen.id: (BuildContext context) => const PhoneAuthScreen(),
                    BioDataScreen.id: (BuildContext context) => const BioDataScreen(),
                    NotFoundScreen.id: (BuildContext context) => const NotFoundScreen(),
                    NoInternetScreen.id: (BuildContext context) => const NoInternetScreen(),
                    HomeScreen.id: (BuildContext context) => const HomeScreen(),
                    MainScreen.id: (BuildContext context) => const MainScreen(),
                    NotificationScreen.id: (BuildContext context) => const NotificationScreen(),
                    ReportScreen.id: (BuildContext context) => const ReportScreen(),
                    SettingsScreen.id: (BuildContext context) => const SettingsScreen(),
                    ProfileScreen.id: (BuildContext context) => const ProfileScreen(),
                    NewsUpdateScreen.id: (BuildContext context) => const NewsUpdateScreen(),
                  },
                );
              },
            );
          },
        );
      },
    );
  }
}
