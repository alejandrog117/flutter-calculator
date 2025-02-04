import 'package:flutter/material.dart';
import 'package:expressions/expressions.dart'; // External package for expression evaluation

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Calculator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Alejandro Gutierrez'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String input = '';
  String result = '0';

  void onNumberPressed(String value) {
    setState(() {
      input += value;
    });
  }

  void onClearPressed() {
    setState(() {
      input = '';
      result = '0';
    });
  }

  void onEvaluatePressed() {
    try {
      final expression = Expression.parse(input);
      final evaluator = const ExpressionEvaluator();
      final evalResult = evaluator.eval(expression, {});
      setState(() {
        result = evalResult.toString();
        input = '$input = $result';
      });
    } catch (e) {
      setState(() {
        result = 'Error';
      });
    }
  }

  Widget buildButton(String text, {Color? color, void Function()? onPressed}) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color ?? Colors.blue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(fontSize: 20),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.bottomRight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      input,
                      style: const TextStyle(fontSize: 24, color: Colors.black54),
                      textAlign: TextAlign.right,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      result,
                      style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.right,
                    ),
                  ],
                ),
              ),
            ),
            GridView.count(
              crossAxisCount: 4,
              shrinkWrap: true,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              children: [
                buildButton('7', onPressed: () => onNumberPressed('7')),
                buildButton('8', onPressed: () => onNumberPressed('8')),
                buildButton('9', onPressed: () => onNumberPressed('9')),
                buildButton('/', color: Colors.orange, onPressed: () => onNumberPressed('/')),
                buildButton('4', onPressed: () => onNumberPressed('4')),
                buildButton('5', onPressed: () => onNumberPressed('5')),
                buildButton('6', onPressed: () => onNumberPressed('6')),
                buildButton('*', color: Colors.orange, onPressed: () => onNumberPressed('*')),
                buildButton('1', onPressed: () => onNumberPressed('1')),
                buildButton('2', onPressed: () => onNumberPressed('2')),
                buildButton('3', onPressed: () => onNumberPressed('3')),
                buildButton('-', color: Colors.orange, onPressed: () => onNumberPressed('-')),
                buildButton('C', color: Colors.red, onPressed: onClearPressed),
                buildButton('0', onPressed: () => onNumberPressed('0')),
                buildButton('=', color: Colors.green, onPressed: onEvaluatePressed),
                buildButton('+', color: Colors.orange, onPressed: () => onNumberPressed('+')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
