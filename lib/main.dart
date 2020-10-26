import 'package:easy_alert/easy_alert.dart';
import 'package:ex/const.dart';
import 'package:ex/provider/notification_statue.dart';
import 'package:ex/provider/user_data.dart';
import 'package:ex/views/on_boarding/view.dart';
import 'package:ex/views/sign_in/view.dart';
import 'package:ex/views/splash/view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

  bool seenOnBoarding = sharedPreferences.getBool("seenOnBoarding");
  Widget _screenOnBoarding;
  print(_screenOnBoarding);

  if (seenOnBoarding == null) {
    _screenOnBoarding = OnBoarding();
  } else {
    _screenOnBoarding = SignInView();
  }
  bool seen = sharedPreferences.getBool("seen");
  Widget _screen;

  if (seen == false || seen == null) {
    _screen = _screenOnBoarding;
  } else {
    _screen = SplashView();
  }

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(AlertProvider(
      child: MyApp(
        screen: _screen,
      ),
      config: AlertConfig(ok: "", cancel: ""),
    ));
  });
}

class MyApp extends StatelessWidget {
  MyApp({this.screen});
  Widget screen;
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserData(),
        ),
        ChangeNotifierProvider(create: (context) => NotificationStatue())
      ],
      child: MaterialApp(
        title: 'EX Chat',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: "Cairo",
          platform: TargetPlatform.iOS,
          brightness: Brightness.dark,
          primaryColor: primaryColor,
          accentColor: accentColor,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: screen,
      ),
    );
  }
}
