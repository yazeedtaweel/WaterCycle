// import 'package:flutter/cupertino.dart';
//
// class RegionWidget extends StatefulWidget {
//   @override
//   _RegionWidgetState createState() => _RegionWidgetState();
// }
//
// class _RegionWidgetState extends State<RegionWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//     home: Scaffold(
//     appBar: AppBar(
//     title: Text('GeeksforGeeks'),
//     backgroundColor: Colors.greenAccent[400],
//     leading: IconButton(
//     icon: Icon(Icons.menu),
//     tooltip: 'Menu',
//     onPressed: () {},
//     ), //IconButton
//     ), //AppBar
//     body: SizedBox(
//     width: 400,
//     height: 400,
//     child: Center(
//     child: Padding(
//     padding: const EdgeInsets.all(8.0),
//     child: Container(
//     decoration: BoxDecoration(
//     border: Border.all(color: Colors.greenAccent),
//     borderRadius: BorderRadius.circular(20),
//     ), //BoxDecoration
//
//     /** CheckboxListTile Widget **/
//     child: CheckboxListTile(
//     title: const Text('GeeksforGeeks'),
//     subtitle: const Text('A computer science portal for geeks.'),
//     secondary: const Icon(Icons.code),
//     autofocus: false,
//     activeColor: Colors.green,
//     checkColor: Colors.white,
//     selected: _value,
//     value: _value,
//     onChanged: (bool value) {
//     setState(() {
//     _value = value;
//     });
//     },
//     ), //CheckboxListTile
//     ), //Container
//     ), //Padding
//     ), //Center
//     ), //SizedBox
//     ), //Scaffold
//
//     );
//   }
// }
