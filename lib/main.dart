import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stateful Lab',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: CounterWidget(),
    );
  }
}

class CounterWidget extends StatefulWidget {
  @override
  _CounterWidgetState createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  int _counter = 0; // This is our STATE
  final TextEditingController _controller = TextEditingController();
  final List<int> _history = [];

  Color get counterColor {
    if (_counter == 0) return Colors.red;
    if (_counter > 50) return Colors.blue;
    return Colors.black;
  }

  void _setCounter(int value) {
    if (value > 100) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Limit Reached!')));
      return;
    }
    if (value < 0) {
      // Prevent counter from going below 0
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Value cannot be negative!')));
      return;
    }
    setState(() {
      _history.add(_counter);
      _counter = value;
    });
  }

  void _undo() {
    if (_history.isNotEmpty) {
      setState(() {
        _counter = _history.removeLast();
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Interactive Counter')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              color: Colors.blue.shade100,
              padding: EdgeInsets.all(20),
              child: Text(
                '$_counter',
                style: TextStyle(fontSize: 50.0, color: counterColor),
              ),
            ),
          ),
          SizedBox(height: 20),
          Slider(
            min: 0,
            max: 100,
            value: _counter.toDouble(),
            onChanged: (double value) {
              _setCounter(value.toInt());
            },
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Enter value',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  child: Text('Set Value'),
                  onPressed: () {
                    int? value = int.tryParse(_controller.text);
                    if (value == null) {
                      // Not a number, ignore
                      return;
                    }
                    _setCounter(value);
                  },
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  child: Text('Undo'),
                  onPressed: _history.isNotEmpty ? _undo : null,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
