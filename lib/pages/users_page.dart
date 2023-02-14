import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/regions_provider.dart';

class UsersPage extends StatefulWidget {
  static final routeName = 'users_page';

  const UsersPage({Key? key}) : super(key: key);

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<RegionsProvider>(context, listen: false)
        .getRegionsFromFirestore();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text('Water Cycle in Samu'),
        backgroundColor: Colors.greenAccent[400],
      ),
      body: Consumer<RegionsProvider>(
        builder: (context, provider, x) {
          return provider.regions == null
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: provider.regions.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Card(
                            child: ListTile(
                                title: Text(provider.regions[index].name ?? "error"),
                                subtitle: provider.regions[index].status == true ? Text(provider.cycleDuration(provider.regions[index].start_date??Timestamp.now())): Text(provider.durationforDisconnectedCycle(provider.regions[index].start_date??Timestamp.now(), provider.regions[index].end_date??Timestamp.now())),
                                leading:Text(provider.regions[index].status == true?"جارية":"مقطوعة"),
                            ),
                          ),
                        ],
                      ),
                    );
                  });
        },
      ),
    );
  }
}
