import 'package:flutter/material.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const CalculatorPage(),
    );
  }
}

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String _output = "0";
  String _currentInput = "";
  double _num1 = 0;
  String _operand = "";

  void _buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        _output = "0";
        _currentInput = "";
        _num1 = 0;
        _operand = "";
      } else if (buttonText == "+" ||
          buttonText == "-" ||
          buttonText == "*" ||
          buttonText == "/") {
        if (_currentInput.isNotEmpty) {
          _num1 = double.parse(_currentInput);
          _operand = buttonText;
          _currentInput = "";
        }
      } else if (buttonText == "=") {
        if (_currentInput.isNotEmpty && _operand.isNotEmpty) {
          double num2 = double.parse(_currentInput);
          double result = 0;
          if (_operand == "+") {
            result = _num1 + num2;
          } else if (_operand == "-") {
            result = _num1 - num2;
          } else if (_operand == "*") {
            result = _num1 * num2;
          } else if (_operand == "/") {
            result = _num1 / num2;
          }
          _output = result.toString();
          _num1 = result;
          _currentInput = _output;
          _operand = "";
        }
      } else if (buttonText == ".") {
        if (!_currentInput.contains(".")) {
          _currentInput += buttonText;
        }
      } else {
        _currentInput += buttonText;
      }

      if (_currentInput.isEmpty) {
         if (_operand.isNotEmpty) {
           _output = _num1.toString() + _operand;
         } else {
           _output = _num1.toString();
         }
      } else {
        _output = _currentInput;
      }
      
      if (buttonText != "C" && _currentInput.isEmpty && _operand.isNotEmpty) {
        _output = _num1.toString() + _operand;
      }

    });
  }

  Widget _buildButton(String buttonText, {Color color = Colors.black54}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            padding: const EdgeInsets.all(24.0),
            shape: const CircleBorder(),
          ),
          onPressed: () => _buttonPressed(buttonText),
          child: Text(
            buttonText,
            style: const TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simple Calculator'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.symmetric(
                vertical: 24.0,
                horizontal: 12.0,
              ),
              child: Text(
                _output,
                style: const TextStyle(
                  fontSize: 48.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const Divider(),
          Column(
            children: [
              Row(
                children: <Widget>[
                  _buildButton("7"),
                  _buildButton("8"),
                  _buildButton("9"),
                  _buildButton("/", color: Colors.orange),
                ],
              ),
              Row(
                children: <Widget>[
                  _buildButton("4"),
                  _buildButton("5"),
                  _buildButton("6"),
                  _buildButton("*", color: Colors.orange),
                ],
              ),
              Row(
                children: <Widget>[
                  _buildButton("1"),
                  _buildButton("2"),
                  _buildButton("3"),
                  _buildButton("-", color: Colors.orange),
                ],
              ),
              Row(
                children: <Widget>[
                  _buildButton("."),
                  _buildButton("0"),
                  _buildButton("C", color: Colors.redAccent),
                  _buildButton("+", color: Colors.orange),
                ],
              ),
              Row(
                children: <Widget>[
                  _buildButton("=", color: Colors.green),
                ],
              ),
              const SizedBox(height: 16),
            ],
          )
        ],
      ),
    );
  }
}
