import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:water_cycle_android/pages/regions_page.dart';
import 'package:water_cycle_android/pages/splash_screen.dart';
import 'package:water_cycle_android/pages/user_login.dart';
import 'package:water_cycle_android/pages/users_page.dart';
import 'package:water_cycle_android/providers/regions_provider.dart';
import 'package:water_cycle_android/services/notification_service.dart';
import 'package:water_cycle_android/services/routes_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); //when exist onther code to execute
  await NotificationService().init();
  runApp(
    ChangeNotifierProvider<RegionsProvider>(
      create: (context) => RegionsProvider(),
      child: MaterialApp(
        localizationsDelegates: [
          GlobalCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          Locale("ar", "PS"),
        ],
        routes: {
          RegionsPage.routeName: (context) => RegionsPage(),
          UsersPage.routeName: (context) => UsersPage(),
          UserForm.routeName: (context) => UserForm(),
        },
        navigatorKey: RouteHelper.routeHelper.navKey,
        home: FirebaseConfiguration(),
        debugShowCheckedModeBanner: false,
      ),
    ),
  );
}

class FirebaseConfiguration extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FutureBuilder<FirebaseApp>(
        future: Firebase.initializeApp(),
        builder: (context, AsyncSnapshot<FirebaseApp> dataSnapShot) {
          if (dataSnapShot.hasError) {
            return Scaffold(
              backgroundColor: Colors.red,
              body: Center(
                child: Text(dataSnapShot.error.toString()),
              ),
            );
          }
          if (dataSnapShot.connectionState == ConnectionState.done) {
            return SplashScreen();
          }
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
