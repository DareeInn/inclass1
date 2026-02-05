import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'InClass 1 Tabs Demo',
      debugShowCheckedModeBanner: false,
      home: const TabsDemo(),
    );
  }
}

class TabsDemo extends StatefulWidget {
  const TabsDemo({super.key});

  @override
  State<TabsDemo> createState() => _TabsDemoState();
}

class _TabsDemoState extends State<TabsDemo> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final tabs = ['Text', 'Image', 'Button', 'List'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tabs Demo'),
        bottom: TabBar(
          controller: _tabController,
          tabs: tabs.map((tab) => Tab(text: tab)).toList(),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.blueGrey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Bottom App Bar - Darin',
            style: const TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildTextTab(),
          _buildImageTab(),
          _buildButtonTab(),
          _buildListTab(),
        ],
      ),
    );
  }

  Widget _buildTextTab() {
    return Container(
      color: Colors.red[100],
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Hello from Tab 1!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Alert'),
                    content: const Text('This is an Alert Dialog in Tab 1'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Close'),
                      )
                    ],
                  ),
                );
              },
              child: const Text('Show Alert'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageTab() {
    return Container(
      color: Colors.black,
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const TextField(
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              labelText: 'Enter your name',
              labelStyle: TextStyle(color: Colors.white70),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white54),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Image.network(
            'https://images.unsplash.com/photo-1503376780353-7e6692767b70?auto=format&fit=crop&w=300&q=80',
            width: 150,
            height: 150,
          ),
          const SizedBox(height: 20),
          const Card(
            child: ListTile(
              leading: Icon(Icons.person),
              title: Text('Darin'),
              subtitle: Text('Major: Computer Science'),
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildButtonTab() {
    return Container(
      color: Colors.blue[100],
      child: Center(
        child: ElevatedButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Button pressed in ${tabs[2]} tab!')),
            );
          },
          child: const Text('Click me'),
        ),
      ),
    );
  }

  Widget _buildListTab() {
    return Container(
      color: Colors.amber[200],
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            elevation: 4,
            child: ListTile(
              leading: const Icon(Icons.star),
              title: const Text('Item 1'),
              subtitle: const Text('This is the first item.'),
            ),
          ),
          Card(
            elevation: 4,
            child: ListTile(
              leading: const Icon(Icons.favorite),
              title: const Text('Item 2'),
              subtitle: const Text('This is the second item.'),
            ),
          ),
          Card(
            elevation: 4,
            child: ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Item 3'),
              subtitle: const Text('This is the third item.'),
            ),
          ),
        ],
      ),
    );
  }
}
