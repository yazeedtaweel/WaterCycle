import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:water_cycle_android/pages/users_page.dart';
import 'package:water_cycle_android/providers/regions_provider.dart';

import '../services/main_drawer.dart';
import '../services/routes_helper.dart';

class RegionsPage extends StatefulWidget {
  static final routeName = 'regions';

  const RegionsPage({Key? key}) : super(key: key);

  @override
  State<RegionsPage> createState() => _RegionsPageState();
}

class _RegionsPageState extends State<RegionsPage> {
  bool _value = false;
  @override
  void initState() {
    super.initState();
    Provider.of<RegionsProvider>(context, listen: false)
        .getRegionsFromFirestore();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        title: Text('توزيع المياه على مناطق السموع'),
        backgroundColor: Colors.teal,
      ),
      body: Consumer<RegionsProvider>(
        builder: (context, provider, x) {
          return provider.regions == null
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: provider.regions?.length,
                  itemBuilder: (context, index) {
                    return Container(
                      // margin: EdgeInsets.all(10),
                      padding: EdgeInsets.symmetric(vertical: 1.0, horizontal: 5.0),
                      child: Column(
                        children: [
                          SwitchListTile(
                            title: Text(provider.regions[index].name ?? "error"),
                            secondary: const Icon(Icons.water_damage),
                            autofocus: false,
                            activeColor: Colors.teal,
                            selected: provider.regions[index].status ?? false,
                            value: provider.regions[index].status ?? false,
                            onChanged: (value) {
                              setState(() {
                                _value = provider.regions[index].status ?? false;
                                _value = !_value;
                                provider.newStatus = _value;
                                provider.setStatus(provider.regions[index]);
                              });
                            },
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
