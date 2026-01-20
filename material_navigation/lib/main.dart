import 'package:flutter/material.dart';

void main() {
  runApp(NavigationExampleApp());
}

class NavigationExampleApp extends StatelessWidget {
  const NavigationExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    // The MaterialApp's home is automatically set as the bottom of the navigation stack
    return MaterialApp(
      title: 'Navigation Example',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: FirstScreen(),
    );
  }
}

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('First Screen')),
      body: Center(
        child: ElevatedButton(
          child: const Text('Go to Second'),
          onPressed: () {
            Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (_) => SecondScreen()));
          },
        ),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Second Screen')),
      body: Center(
        child: ElevatedButton(
          child: const Text('Go to First'),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
    );
  }
}
