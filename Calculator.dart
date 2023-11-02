import "package:flutter/material.dart";
import "package:math_expressions/math_expressions.dart";

void main() {
  runApp(MaterialApp(
    home: calculatorApp(),
  ));
}

class calculatorApp extends StatefulWidget {
  const calculatorApp({super.key});

  @override
  State<calculatorApp> createState() => _calculatorAppState();
}

class _calculatorAppState extends State<calculatorApp> {
// Variables
double input1 = 0.0;
double input2 = 0.0;
var input = '';
var Output = '';
var operation = '';
var hideInput = false;
var outputSize = 34.8;

onButtonClick(value){
  //If value is Ac
  if(value == "AC"){
    input= '';
    Output = '';
  }

  else if(value == "<"){
    if(input.isNotEmpty){
    input = input.substring(0, input.length - 1);
  }
  }
  else if(value == '='){
    if(input.isNotEmpty){
    var userinput = input;
    userinput = input.replaceAll('x', '*');
    Parser p = Parser();
    Expression expression = p.parse(userinput);
    ContextModel cm = ContextModel();
    var finalValue = expression.evaluate(EvaluationType.REAL, cm);
    Output = finalValue.toString();
    if(Output.endsWith(".0")){
    Output = Output.substring(0, Output.length -2);
  }
  input = Output;
  hideInput = true;
  outputSize = 60;
  }
  }
  else{
    input = input + value;
    hideInput = false;
    outputSize = 34;

  }
  setState(() {});
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black ,
      body: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
            padding: EdgeInsets.all(12) ,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children:[
                Text(
                  hideInput ?'' : input,
                  style: const TextStyle(
                    fontSize: 48,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Text(
                  Output,
                  style: TextStyle(
                    fontSize: outputSize,
                    color: Colors.white.withOpacity(0.7),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
              ),
            ),
          ),
          //Button area
          Row(
            children: [
             button(text:"AC", tColor: Colors.red),
             button(text:"%", tColor: Colors.green),
             button(text:"<", tColor: Colors.green),
             button(text:"/", tColor: Colors.green),
            ],
          ),
          Row(
            children: [
             button(text:"7"),
             button(text:"8"),
             button(text:"9"),
             button(text:"x", tColor: Colors.green),
            ],
          ),
          Row(
            children: [
             button(text:"4"),
             button(text:"5"),
             button(text:"6"),
             button(text:"-", tColor: Colors.green),
            ],
          ),
          Row(
            children: [
             button(text:"1"),
             button(text:"2"),
             button(text:"3"),
             button(text:"+", tColor: Colors.green),
            ],
          ),
          Row(
            children: [
             button(text:"00"),
             button(text:"0"),
             button(text:"."),
             button(text:"=", buttonBgColor: Colors.green),
            ],
          ),

        ], 
        ),
    );
  }

  Widget button({
    text, tColor = Colors.white, buttonBgColor = Colors.black
  }){
    return Expanded(
                child:Container(
                  margin: const EdgeInsets.all(8),
                  child: ElevatedButton( 
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)
                      ),
                      padding: const EdgeInsets.all(12),
                      primary: buttonBgColor,
                    ),
                    onPressed: () => onButtonClick(text), 
                    child: Text(
                      text,
                      style: TextStyle(
                        fontSize: 30,
                        color: tColor,
                        fontWeight: FontWeight.bold
                      ),),
                  ),
                ),
              );
  }
}