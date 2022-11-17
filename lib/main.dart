import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Water Cycle',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // value set to false
  bool _value = false;

  // App widget tree
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Water Cycle'),
          backgroundColor: Colors.greenAccent[400],
         //IconButton
        ), //AppBar
        body: SizedBox(
          width: 400,
          height: 400,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.greenAccent),
                  borderRadius: BorderRadius.circular(20),
                ), //BoxDecoration

                /** CheckboxListTile Widget **/
                child: CheckboxListTile(
                  title: const Text('المدورة'),
                  secondary: const Icon(Icons.water_damage),
                  autofocus: false,
                  activeColor: Colors.green,
                  checkColor: Colors.white,
                  selected: _value,
                  value: _value,
                  onChanged: (value) {
                    setState((){
                      _value = ! _value;
                    });
                  },
                ), //CheckboxListTile
              ), //Container
            ), //Padding
          ), //Center
        ), //SizedBox
      ), //Scaffold
    ); //MaterialApp
  }
}