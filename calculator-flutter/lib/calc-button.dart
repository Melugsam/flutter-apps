import 'package:flutter/material.dart';

class CalculatorButton extends StatelessWidget {
  final String text;
  final int fillColor;
  final Function callback;

  CalculatorButton(
      {required this.text,
      required this.fillColor,
      required this.callback});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1,
      width: MediaQuery.of(context).size.width * 0.20,
      margin: const EdgeInsets.all(5.0),
      child: SizedBox(
        child: MouseRegion(
          child: TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Color(fillColor),
              foregroundColor: Colors.white,
              shape: const BeveledRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(3))),
            ),
            onPressed: () => callback(text),
            child: Text(
              text,
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.05,
                  color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
