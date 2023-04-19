// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'calc-button.dart';
import 'package:function_tree/function_tree.dart';
import 'package:side_sheet/side_sheet.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Calculator(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  late int firstNum;
  late int secondNum;
  bool operation = false;
  bool counted = false;
  String history = "0";
  String display = "0";
  String result = "0";
  var historyList = [];
  var historyListNumeration = [];

  String logicChange(String val) {
    String temp = "";
    for (int i = 0; i < val.length; i++) {
      if (val[i] == "×") {
        temp += "*";
      } else if (val[i] == "÷") {
        temp += "/";
      } else {
        temp += val[i];
      }
    }
    return temp;
  }

  int NumOfOperations(String val) {
    int sum = 0;
    if (val[0] == "-") sum--;
    for (int i = 0; i < val.length; i++) {
      if (val[i] == "+" || val[i] == "-" || val[i] == "×" || val[i] == "÷") {
        sum++;
      }
    }
    return sum;
  }

  void ButtonClick(String val) {
    if (val == "=") {
      if (operation) {
        result = "Error";
        counted = true;
      } else {
        historyList.add(result);
        history = logicChange(result).interpret().toString();
        if (history.length - history.indexOf('.') - 1 == 1 &&
            history[history.indexOf('.') + 1] == "0") {
          history =
              history.replaceRange(history.indexOf('.'), history.length, '');
        }
        result = history;
        counted = true;
        historyListNumeration.add(historyList.length);
        historyList[historyList.length - 1] += "=$result";
      }
    } else if (val == "C") {
      result = "0";
    } else if (val == "CE") {
      historyListNumeration.clear();
      historyList.clear();
      result = "0";
      history = "0";
    } else if (val == "+" ||
        val == "-" ||
        val == "×" ||
        val == "÷" ||
        val == ".") {
      if (result.length >= 1) {
        operation = true;
        result += val;
      } else {
        result = "0";
      }
    } else if (val == "+/-" &&
        result[0] != "0" &&
        NumOfOperations(result) <= 0) {
      if (result[0] != "-") {
        result = "-$result";
      } else {
        result = result.replaceRange(0, 1, "");
      }
    } else if (val == "←" && result.length > 1) {
      result = result.replaceRange(result.length - 1, result.length, "");
    } else if (int.parse(val) >= 0 && int.parse(val) <= 9) {
      operation = false;
      if (result.length == 1 && result[0] == "0") {
        result = val;
      } else {
        result += val;
      }
    }

    setState(() {
      display = result;
      if (counted) {
        result = "";
        counted = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var historyButton = ElevatedButton(
        style: ElevatedButton.styleFrom(
            textStyle: TextStyle(color: Colors.white),
            foregroundColor: Colors.white,
            backgroundColor: Colors.black),
        onPressed: () => SideSheet.left(
            body: Container(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.width * 0.15),
              color: Colors.black87,
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Text("Calculator requests history",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: MediaQuery.of(context).size.width * 0.04)),
                  ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(8),
                    itemCount: historyList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Center(
                          child: Container(
                              padding: EdgeInsets.fromLTRB(15, 5, 15, 0),
                              child: Text(
                                (index + 1).toString() +
                                    ") " +
                                    historyList[index],
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.035),
                              )));
                    }),
              ]),
            ),
            context: context),
        child: Container(
          child: Icon(
            size: MediaQuery.of(context).size.width * 0.07,
            Icons.history,
            color: Colors.white,
          ),
        ));
    var main = Column(
      children: [
        FittedBox(
          fit: BoxFit.cover,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                history,
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.08,
                    color: Colors.grey),
              )
            ],
          ),
        ),
        FittedBox(
          fit: BoxFit.cover,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                display,
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.12,
                    color: Colors.white),
              )
            ],
          ),
        ),
        Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.width * 0.05)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CalculatorButton(
                text: "CE", fillColor: 0xFF363636, callback: ButtonClick),
            CalculatorButton(
                text: "C", fillColor: 0xFF363636, callback: ButtonClick),
            CalculatorButton(
                text: "←", fillColor: 0xFF363636, callback: ButtonClick),
            CalculatorButton(
                text: "÷", fillColor: 0xFF363636, callback: ButtonClick)
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CalculatorButton(
                text: "7", fillColor: 0xFF4a4a4a, callback: ButtonClick),
            CalculatorButton(
                text: "8", fillColor: 0xFF4a4a4a, callback: ButtonClick),
            CalculatorButton(
                text: "9", fillColor: 0xFF4a4a4a, callback: ButtonClick),
            CalculatorButton(
                text: "×", fillColor: 0xFF363636, callback: ButtonClick)
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CalculatorButton(
                text: "4", fillColor: 0xFF4a4a4a, callback: ButtonClick),
            CalculatorButton(
                text: "5", fillColor: 0xFF4a4a4a, callback: ButtonClick),
            CalculatorButton(
                text: "6", fillColor: 0xFF4a4a4a, callback: ButtonClick),
            CalculatorButton(
                text: "-", fillColor: 0xFF363636, callback: ButtonClick)
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CalculatorButton(
                text: "1", fillColor: 0xFF4a4a4a, callback: ButtonClick),
            CalculatorButton(
                text: "2", fillColor: 0xFF4a4a4a, callback: ButtonClick),
            CalculatorButton(
                text: "3", fillColor: 0xFF4a4a4a, callback: ButtonClick),
            CalculatorButton(
                text: "+", fillColor: 0xFF363636, callback: ButtonClick)
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CalculatorButton(
                text: "+/-", fillColor: 0xFF4a4a4a, callback: ButtonClick),
            CalculatorButton(
                text: "0", fillColor: 0xFF4a4a4a, callback: ButtonClick),
            CalculatorButton(
                text: ".", fillColor: 0xFF4a4a4a, callback: ButtonClick),
            CalculatorButton(
                text: "=", fillColor: 0xFF47b3ff, callback: ButtonClick)
          ],
        ),
        Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.width * 0.05)),
      ],
    );

    return Scaffold(
      backgroundColor: Colors.black,
      floatingActionButton: historyButton,
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [main],
        ),
      ),
    );
  }
}
