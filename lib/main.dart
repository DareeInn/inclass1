import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: InClassTabbedDemo(),
    );
  }
}

class InClassTabbedDemo extends StatefulWidget {
  const InClassTabbedDemo({super.key});

  @override
  State<InClassTabbedDemo> createState() => _InClassTabbedDemoState();
}

class _InClassTabbedDemoState extends State<InClassTabbedDemo>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> tabs = ['Text', 'Image', 'Button', 'List'];

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
        title: const Text('InClass 1 Tabs Demo'),
        backgroundColor: Colors.deepPurple,
        bottom: TabBar(
          controller: _tabController,
          tabs: tabs.map((tab) => Tab(text: tab)).toList(),
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
      color: Colors.lightBlue[50],
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const TextField(
            decoration: InputDecoration(labelText: 'Darin Ward'),
          ),
          const SizedBox(height: 20),
          Image.network(
            'https://picsum.photos/200',
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

  Widget _buildImageTab() {
    return Container(
      color: Colors.pink[50],
      alignment: Alignment.center,
      child: Image.network(
        'https://picsum.photos/250',
        width: 200,
        height: 200,
      ),
    );
  }

  Widget _buildButtonTab() {
    return Container(
      color: Colors.green[50],
      alignment: Alignment.center,
      child: ElevatedButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Button Pressed!')),
          );
        },
        child: const Text('Click Me'),
      ),
    );
  }

  Widget _buildListTab() {
    return Container(
      color: Colors.orange[50],
      padding: const EdgeInsets.all(10),
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) => Card(
          child: ListTile(
            leading: const Icon(Icons.list),
            title: Text('Item ${index + 1}'),
          ),
        ),
      ),
    );
  }
}
