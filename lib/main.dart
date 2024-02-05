import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:btl/auth/login.dart';
import 'package:btl/auth/register.dart';
import 'package:btl/auth/shared_preferences.dart';
import 'package:btl/changenotifer/changenotifier.dart';
import 'package:btl/firebase_options.dart';
import 'package:btl/screens/homepage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:btl/theme/theme_detail.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  await WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
        channelKey: 'chat_channel',
        channelName: 'Chat Notifications',
        channelDescription: 'Notification channel for chat messages',
        defaultColor: Color(0xFF9D50DD),
        ledColor: Colors.white,
      ),
    ],
    debug: true,
  );

  await FirebaseMessaging.instance.setAutoInitEnabled(true);

  themevl = await SharedPreference.GetTheme();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => numberShopping()),
      ChangeNotifierProvider(create: (context) => numberNotification()),
      ChangeNotifierProvider(create: (context) => themeChange()),
      ChangeNotifierProvider(create: (context) => Seacher_image())
    ],
    child: MyApp(),
  ));
}

String titleNotifier = "";
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: 1,
      channelKey: 'chat_channel',
      title: message.data["name"],
      body: message.data["mess"],
    ),
  );
}

class MyApp extends StatefulWidget {
  State<MyApp> createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
          colorScheme: context.watch<themeChange>().themedata == "LightTheme"
              ? lightColorScheme
              : darkColorScheme),
      debugShowCheckedModeBanner: false,
      initialRoute: "/login",
      getPages: [
        GetPage(name: "/login", page: () => Login()),
        GetPage(name: "/register", page: () => Register()),
        GetPage(name: "/homepage", page: () => HomePage())
      ],
    );
  }
}
