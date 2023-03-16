import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:water_cycle_android/admin_pages/regions_page.dart';
import 'package:water_cycle_android/pages/users_page.dart';
import 'package:water_cycle_android/providers/regions_provider.dart';
import 'package:water_cycle_android/services/routes_helper.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2)).then(
          (value) {
            // RouteHelper.routeHelper.goToPageWithReplacement(RegionsPage.routeName);
            RouteHelper.routeHelper.goToPageWithReplacement(UsersPage.routeName);
            // Provider.of<RegionsProvider>(context, listen: false).checkLogin();
      },
    );
      return Scaffold(
        body: Center(
          child: LoadingAnimationWidget.bouncingBall(
            color: Colors.teal,
            // leftDotColor: const Color(0xFF1A1A3F),
            // rightDotColor: const Color(0xFFEA3799),
            size: 100,
          ),
        ),
      );
  }
}
