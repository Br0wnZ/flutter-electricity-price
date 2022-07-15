import 'package:electricity_price/services/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:electricity_price/service_locator.dart';
import 'package:electricity_price/pages/home/home_page.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'package:timezone/data/latest_all.dart' as tz;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();
  tz.initializeTimeZones();
  await setupServiceLocator();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  var _isResumed = false;
  final Map<int, Color> colorCodes = {
    50: Color.fromRGBO(147, 205, 72, .1),
    100: Color.fromRGBO(147, 205, 72, .2),
    200: Color.fromRGBO(147, 205, 72, .3),
    300: Color.fromRGBO(147, 205, 72, .4),
    400: Color.fromRGBO(147, 205, 72, .5),
    500: Color.fromRGBO(147, 205, 72, .6),
    600: Color.fromRGBO(147, 205, 72, .7),
    700: Color.fromRGBO(147, 205, 72, .8),
    800: Color.fromRGBO(147, 205, 72, .9),
    900: Color.fromRGBO(147, 205, 72, 1),
  };

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    switch (state) {
      case AppLifecycleState.resumed:
        _isResumed = true;
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.paused:
        _isResumed = true;
        break;
      case AppLifecycleState.detached:
        _isResumed = false;
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Precio Luz',
      theme: ThemeData(
        primarySwatch: MaterialColor(0xff3879b8, colorCodes),
      ),
      home: SafeArea(
        child: _isResumed
            ? HomePage()
            : SplashScreenView(
                navigateRoute: HomePage(),
                pageRouteTransition: PageRouteTransition.SlideTransition,
                duration: 2000,
                imageSize: 400,
                imageSrc: 'assets/images/splash-image.webp',
                backgroundColor: Colors.white,
                text: "By Bubulkapp",
                textType: TextType.ScaleAnimatedText,
                textStyle: TextStyle(
                  fontSize: 30.0,
                ),
              ),
      ),
    );
  }
}
