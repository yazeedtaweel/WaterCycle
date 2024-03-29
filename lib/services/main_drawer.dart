import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:water_cycle_android/admin_pages/regions_page.dart';
import 'package:water_cycle_android/admin_pages/user_login.dart';
import 'package:water_cycle_android/providers/regions_provider.dart';
import 'package:water_cycle_android/services/routes_helper.dart';

import '../admin_pages/suggestions_list.dart';
import '../pages/suggestion_page.dart';
import '../pages/users_page.dart';


class MainDrawer extends StatefulWidget {
  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Consumer<RegionsProvider>(
        builder: (context, provider, x)
    {
      return Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.teal,
              ),
              child: Text(
                "",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
            provider.getCredentials == null ? ListTile(
              leading: const Icon(Icons.add),
              title: const Text('تسجيل الدخول'),
              onTap: () {
                RouteHelper.routeHelper.goToPage(UserForm.routeName);
              },
            ) : ListTile(
              leading: const Icon(Icons.add),
              title: const Text("تسجيل الخروج"),
              onTap: () {
                setState(() {
                  provider.logout();
                });
                RouteHelper.routeHelper.goToPageWithReplacement(
                    UsersPage.routeName);
              },
            ),
            provider.getCredentials == null?ListTile(
              leading: const Icon(Icons.add),
              title: const Text('إقتراحات وشكاوي'),
              onTap: () {
                RouteHelper.routeHelper.goToPage(FeedbackDialog.routeName);
                // const FeedbackDialog();
              },
            ):ListTile(
              leading: const Icon(Icons.add),
              title: const Text('الاقتراحات والشكاوي'),
              onTap: () {
                RouteHelper.routeHelper.goToPage(SuggestionsList.routeName);
                // const FeedbackDialog();
              },
            )

          ],
        ),
      );
    }
    );

  }
}
