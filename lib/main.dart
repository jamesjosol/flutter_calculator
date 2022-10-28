import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(Calculator());
}

class Calculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: ThemeData(primarySwatch: Colors.purple),
      home: SimpleCalculator(),
    );
  }
}

class SimpleCalculator extends StatefulWidget {
  @override
  _SimpleCalculatorState createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {
  String equation = "0";
  String result = "0";
  String expression = "";
  double equationFontSize = 38.0;
  double resultFontSize = 48.0;

  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        equation = "0";
        result = "0";
        equationFontSize = 38.0;
        resultFontSize = 48.0;
      } else if (buttonText == "⌫") {
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        equation = equation.substring(0, equation.length - 1);
        if (equation == "") {
          equation = "0";
        }
      } else if (buttonText == "=") {
        equationFontSize = 38.0;
        resultFontSize = 48.0;

        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');

        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
          if (result.endsWith(".0"))
            result = result.substring(0, result.length - 2);
        } catch (e) {
          result = "Error";
        }
      } else {
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        if (equation == "0") {
          equation = buttonText;
        } else {
          equation = equation + buttonText;
        }
      }
    });
  }

  Widget buildButton(String buttonText, double buttonHeight, Color buttonColor,
      Color buttonSplashColor) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      color: buttonColor,
      child: FlatButton(
          splashColor: buttonSplashColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.0),
              side: BorderSide(
                  color: Colors.white, width: 1, style: BorderStyle.solid)),
          padding: EdgeInsets.all(16.0),
          onPressed: () => buttonPressed(buttonText),
          child: Text(
            buttonText,
            style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.normal,
                color: Colors.white),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Simple Calculator',
            style: TextStyle(
                fontSize: 24.0,
                fontFamily: 'Comfortaa',
                fontWeight: FontWeight.bold),
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.topRight,
                colors: [
                  Color(0xffB1097C),
                  Color(0xff0947B1),
                ]),
          ),
          //decoration: BoxDecoration(color: Colors.grey[900]),
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                child: Text(
                  equation,
                  style: TextStyle(
                      fontSize: equationFontSize,
                      fontFamily: 'Comfortaa',
                      color: Colors.white),
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
                margin: EdgeInsets.only(top: 10.0),
                child: Text(
                  result,
                  style: TextStyle(
                      fontSize: resultFontSize,
                      fontFamily: 'Comfortaa',
                      color: Colors.white),
                ),
              ),
              Expanded(
                child: Divider(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * .75,
                    child: Table(
                      children: [
                        TableRow(children: [
                          buildButton("C", 1, Colors.redAccent, Colors.red),
                          buildButton(
                              "⌫", 1, Colors.blue, Colors.lightBlueAccent),
                          buildButton("÷", 1, Colors.blue, Colors.blue),
                        ]),
                        TableRow(children: [
                          buildButton("7", 1, Colors.grey, Colors.white),
                          buildButton("8", 1, Colors.grey, Colors.white),
                          buildButton("9", 1, Colors.grey, Colors.white),
                        ]),
                        TableRow(children: [
                          buildButton("4", 1, Colors.grey, Colors.white),
                          buildButton("5", 1, Colors.grey, Colors.white),
                          buildButton("6", 1, Colors.grey, Colors.white),
                        ]),
                        TableRow(children: [
                          buildButton("1", 1, Colors.grey, Colors.white),
                          buildButton("2", 1, Colors.grey, Colors.white),
                          buildButton("3", 1, Colors.grey, Colors.white),
                        ]),
                        TableRow(children: [
                          buildButton(".", 1, Colors.grey, Colors.white),
                          buildButton("0", 1, Colors.grey, Colors.white),
                          buildButton("00", 1, Colors.grey, Colors.white),
                        ]),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.25,
                    child: Table(
                      children: [
                        TableRow(children: [
                          buildButton(
                              "×", 1, Colors.blue, Colors.lightBlueAccent),
                        ]),
                        TableRow(children: [
                          buildButton(
                              "-", 1, Colors.blue, Colors.lightBlueAccent),
                        ]),
                        TableRow(children: [
                          buildButton(
                              "+", 1, Colors.blue, Colors.lightBlueAccent),
                        ]),
                        TableRow(children: [
                          buildButton("=", 2, Colors.redAccent, Colors.red),
                        ]),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        )
    );
  }
}
