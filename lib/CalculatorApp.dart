import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({super.key});

  @override
  State<CalculatorApp> createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  var input = '0';
  var output = '';

  calcClick(val) {
    if (val == "AC") {
      input = '0';
      output = '';
    } else if (val == "Del") {
      if (output.isEmpty) {
        if (input.length == 1) {
          input = "0";
        } else {
          input = input.substring(0, input.length - 1);
        }
      } else {
        output = '';
      }
    } else if (val == "=") {
      var newVal = input.replaceAll("X", "*");
      Parser p = Parser();
      Expression expression = p.parse(newVal);
      ContextModel cm = ContextModel();
      var finalVal = expression.evaluate(EvaluationType.REAL, cm);
      output = finalVal.toString();
      if (output.endsWith(".0")) {
        output = output.substring(0, output.length - 2);
      }
      input = output;
    } else {
      if (input == "0") {
        input = val;
      } else {
        input = input + val;
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            display(),
            Container(
              child: Row(
                children: [
                  button(
                      text: "AC",
                      buttonbgColor: Color.fromARGB(255, 75, 75, 75),
                      tColor: Colors.deepOrange),
                  button(
                      text: "Del",
                      buttonbgColor: Color.fromARGB(255, 75, 75, 75),
                      tColor: Colors.deepOrange),
                  button(
                      text: "%",
                      buttonbgColor: Color.fromARGB(255, 75, 75, 75),
                      tColor: Colors.deepOrange),
                  button(
                      text: "/",
                      buttonbgColor: Color.fromARGB(255, 75, 75, 75),
                      tColor: Colors.deepOrange)
                ],
              ),
            ),
            Container(
              child: Row(
                children: [
                  button(text: "7"),
                  button(text: "8"),
                  button(text: "9"),
                  button(
                      text: "X",
                      buttonbgColor: Color.fromARGB(255, 75, 75, 75),
                      tColor: Colors.deepOrange)
                ],
              ),
            ),
            Container(
              child: Row(
                children: [
                  button(text: "4"),
                  button(text: "5"),
                  button(text: "6"),
                  button(
                      text: "-",
                      buttonbgColor: Color.fromARGB(255, 75, 75, 75),
                      tColor: Colors.deepOrange)
                ],
              ),
            ),
            Container(
              child: Row(
                children: [
                  button(text: "1"),
                  button(text: "2"),
                  button(text: "3"),
                  button(
                      text: "+",
                      buttonbgColor: Color.fromARGB(255, 75, 75, 75),
                      tColor: Colors.deepOrange)
                ],
              ),
            ),
            Container(
              child: Row(
                children: [
                  button(text: "00"),
                  button(text: "0"),
                  button(text: "."),
                  button(
                    text: "=",
                    buttonbgColor: Colors.deepOrange,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget display() {
    return Expanded(
        child: Container(
      width: double.infinity,
      // color: Colors.red,
      padding: EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            output,
            style:
                TextStyle(fontSize: 34, color: Colors.white.withOpacity(0.7)),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            input,
            style: TextStyle(fontSize: 48, color: Colors.white),
          ),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    ));
  }

  Widget button(
      {text,
      tColor = Colors.white,
      buttonbgColor = const Color.fromARGB(255, 43, 42, 42)}) {
    return Expanded(
        child: Container(
            margin: EdgeInsets.all(8),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  padding: const EdgeInsets.all(22),
                  primary: buttonbgColor),
              onPressed: () {
                calcClick(text);
              },
              child: Text(
                text,
                style: TextStyle(
                    fontSize: 18, color: tColor, fontWeight: FontWeight.bold),
              ),
            )));
  }
}
