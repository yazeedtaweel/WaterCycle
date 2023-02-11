import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:water_cycle_android/providers/regions_provider.dart';

class RegionsPage extends StatefulWidget {
  static final routeName = 'regions';

  const RegionsPage({Key? key}) : super(key: key);

  @override
  State<RegionsPage> createState() => _RegionsPageState();
}

class _RegionsPageState extends State<RegionsPage> {
  bool _value = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Water Cycle in Samu'),
          backgroundColor: Colors.greenAccent[400],
          //IconButton
          // actions:[
          //   IconButton(
          //     color: Colors.white,
          //     icon: const Icon(Icons.add),
          //     tooltip: 'Add region',
          //     onPressed: () {
          //       setState(() {
          //       });
          //     },
          //   ),
          // ]
      ),
      body: Consumer<RegionsProvider>(
        builder: (context, provider, x) {
          return provider.regions == null
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: provider.regions?.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          CheckboxListTile(
                            title: Text(provider.regions[index].name ?? "error"),
                            secondary: const Icon(Icons.water_damage),
                            autofocus: false,
                            activeColor: Colors.green,
                            checkColor: Colors.white,
                            selected: _value,
                            value: _value,
                            onChanged: (value) {
                              setState(() {
                                _value = !_value;
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
