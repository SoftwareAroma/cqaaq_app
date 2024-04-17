import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:logger/logger.dart';

late PageController pageController;

const supportedLocales = <Locale>[
  Locale('en'),
  Locale('fr'),
  Locale('sw'),
  Locale('af'),
  Locale('zu'),
  Locale('ar'),
];

const globalDelegates = <LocalizationsDelegate<dynamic>>[
  GlobalMaterialLocalizations.delegate,
  GlobalWidgetsLocalizations.delegate,
  GlobalCupertinoLocalizations.delegate,
];

const String newsApiKey = '66449bcaeeec43c0b480fedd6321b7ac';

String defaultAvatarUrl =
    "https://firebasestorage.googleapis.com/v0/b/ipv-ghana.appspot.com/o/account.png?alt=media&token=b645ba47-7c94-46ed-9204-73a54e3756dd";

const String defaultImagePlaceholder = "http://via.placeholder.com/350x150";

String newsApiEndpoint({String keyword = 'cashew', String apiKey = newsApiKey}) =>
    'https://newsapi.org/v2/everything?q=$keyword&apiKey=$apiKey'; // sortBy=publishedAt&

final logger = Logger();
