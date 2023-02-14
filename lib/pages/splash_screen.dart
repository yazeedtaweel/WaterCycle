import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:water_cycle_android/pages/regions_page.dart';
import 'package:water_cycle_android/pages/users_page.dart';
import 'package:water_cycle_android/providers/regions_provider.dart';
import 'package:water_cycle_android/services/routes_helper.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2)).then(
          (value) {
            RouteHelper.routeHelper.goToPageWithReplacement(RegionsPage.routeName);
            // RouteHelper.routeHelper.goToPageWithReplacement(UsersPage.routeName);
            // Provider.of<RegionsProvider>(context, listen: false).checkLogin();
      },
    );
      return Scaffold(
        body: Center(
          child: Text('Splach Screen'),
        ),
      );
  }
}
