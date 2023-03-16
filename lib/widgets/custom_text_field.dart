import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomrTextFeild extends StatelessWidget {
  String label;
  TextEditingController controller;
  CustomrTextFeild(this.label, this.controller);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 10,
      ),
      child: TextField(
        // style: TextStyle(color: Colors.teal),
        cursorColor: Colors.teal,
        controller: controller,
        decoration: InputDecoration(
          focusColor: Colors.teal,
          hintStyle: const TextStyle(color: Colors.teal),
          labelText: label,
          labelStyle: TextStyle(color: Colors.teal),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.teal,
              ) ,
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.redAccent,
            ) ,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),

          ),
        ),
      ),
    );
  }
}