import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  Function onPressed;
  String label;
  CustomButton(this.label, this.onPressed);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      child: ElevatedButton(
        onPressed: () {
          onPressed();
        },
        style: const ButtonStyle(backgroundColor:MaterialStatePropertyAll<Color>(Colors.teal),
        ),
        child: Text(label),
      ),
    );
  }
}