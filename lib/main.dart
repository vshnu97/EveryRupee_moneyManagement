import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:every_rupee/db/category/category_db.dart';
import 'package:every_rupee/db/transactions/transaction_db.dart';
import 'package:every_rupee/model/category/category_model.dart';
import 'package:every_rupee/model/transactions/transaction_model.dart';
import 'package:every_rupee/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:flutter/services.dart';
import 'package:timezone/data/latest_all.dart' as tz;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();
  await Hive.initFlutter();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Hive.initFlutter();

  if (!Hive.isAdapterRegistered(CategoryTypeAdapter().typeId)) {
    Hive.registerAdapter(CategoryTypeAdapter());
  }

  if (!Hive.isAdapterRegistered(CategoryModelAdapter().typeId)) {
    Hive.registerAdapter(CategoryModelAdapter());
  }

  if (!Hive.isAdapterRegistered(TransactionModelAdapter().typeId)) {
    Hive.registerAdapter(TransactionModelAdapter());
  }
  CategoryDB().refreshUI();
  TransactionDB().refresh();
  AwesomeNotifications().initialize(
    'resource://drawable/',
    [
      NotificationChannel(
        playSound: false,
        enableVibration: false,
        icon: 'resource://drawable/logo',
        channelKey: 'persistent_notification',
        channelName: 'Persistent Notification',
        channelDescription: 'Showing permanent notification',
        importance: NotificationImportance.Max,
        channelShowBadge: true,
      )
    ],
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        MonthYearPickerLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      theme: ThemeData(primarySwatch: Colors.teal),
    );
  }
}
