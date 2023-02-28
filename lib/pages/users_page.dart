import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:water_cycle_android/helpers/shared_pref_helper.dart';
import 'package:water_cycle_android/services/main_drawer.dart';

import '../providers/regions_provider.dart';
import 'package:swipe_refresh/swipe_refresh.dart';

class UsersPage extends StatefulWidget {
  static final routeName = 'users_page';

  const UsersPage({Key? key}) : super(key: key);

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  // final _controller = StreamController<SwipeRefreshState>.broadcast();
  _UsersPageState();
  @override
  void initState() {
    super.initState();
    Provider.of<RegionsProvider>(context, listen: false)
        .getRegionsFromFirestore();
    Provider.of<RegionsProvider>(context, listen: false).getFavoriteItems();

  }
  Future<bool> isFavouriteItem(String id) async{
    return await preferences.getBool(id, false);
  }
  Future refresh () async {
  Completer<Null> completer = new Completer<Null>();

  await Future.delayed(Duration(seconds: 3)).then((onvalue) {
  completer.complete();
  setState(() {
    Provider.of<RegionsProvider>(context, listen: false)
        .getRegionsFromFirestore();
  });
  });
  return completer.future;
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        title: Text('توزيع المياه على مناطق السموع'),
        backgroundColor: Colors.teal,

      ),
      body: RefreshIndicator(
        onRefresh: refresh,
        child: Consumer<RegionsProvider>(
          builder: (context, provider, x) {
            return provider.regions == null
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: provider.regions.length,
                    itemBuilder: (context, index) {
                      String? id = provider.regions[index].id;
                      bool isFavourite =  provider.favouriteIds.contains(id);
                      String? name = provider.regions[index].name;
                      bool? status = provider.regions[index].status;
                      Timestamp? startDate = provider.regions[index].startDate;
                      Timestamp? endDate =  provider.regions[index].endDate;
                      return Container(
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Card(
                              child: ListTile(
                                  title: Text(name ?? "error"),
                                  subtitle: status == true ?
                                  Text(provider.cycleDuration(startDate ??Timestamp.now())):
                                  Text(provider.durationForDisconnectedCycle(startDate ??Timestamp.now(), endDate ?? Timestamp.now())),
                                  trailing:Text(status == true?"جارية":"مقطوعة"),
                                  leading: Icon(
                                    isFavourite
                                        ? Icons.star
                                        : Icons.star_border,
                                    color: isFavourite ? Colors.yellow : null,
                                  ),
                                  onTap: ()  async {
                                      isFavourite
                                          ? await provider.deleteFavouriteItem(id)
                                          : await provider.saveFavouriteItem(id);
                                  },
                                ),
                                  // horizontalTitleGap: 80.0,
                              ),
                          ],
                        ),
                      );
                    });
          },
        ),
      ),
    );

  }

}
