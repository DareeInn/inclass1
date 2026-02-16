import 'package:flutter/material.dart';

void main() {
  runApp(const AppWithThemeToggle());
}

class AppWithThemeToggle extends StatefulWidget {
  const AppWithThemeToggle({Key? key}) : super(key: key);

  @override
  State<AppWithThemeToggle> createState() => _AppWithThemeToggleState();
}

class _AppWithThemeToggleState extends State<AppWithThemeToggle> {
  ThemeMode _themeMode = ThemeMode.light;

  void _toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light
          ? ThemeMode.dark
          : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Counter & Image Toggle App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
      ),
      themeMode: _themeMode,
      home: HomePage(
        onToggleTheme: _toggleTheme,
        isDarkMode: _themeMode == ThemeMode.dark,
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  final VoidCallback onToggleTheme;
  final bool isDarkMode;
  const HomePage({
    Key? key,
    required this.onToggleTheme,
    required this.isDarkMode,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _counter = 0;
  bool _showFirstImage = true;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _toggleImage() {
    setState(() {
      _showFirstImage = !_showFirstImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter & Image Toggle'),
        actions: [
          IconButton(
            icon: Icon(widget.isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: widget.onToggleTheme,
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Counter: \\$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _incrementCounter,
              child: const Text('Increment Counter'),
            ),
            const SizedBox(height: 40),
            _showFirstImage
                ? Image.asset('assets/image1.png', height: 150)
                : Image.asset('assets/image2.png', height: 150),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _toggleImage,
              child: const Text('Toggle Image'),
            ),
          ],
        ),
      ),
    );
  }
}
