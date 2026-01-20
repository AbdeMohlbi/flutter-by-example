import 'package:flutter/material.dart';

void main() {
  runApp(const NavigationExampleApp());
}

class NavigationExampleApp extends StatelessWidget {
  const NavigationExampleApp({super.key});

  Route<dynamic>? _onGenerateRoute(RouteSettings settings) {
    final name = settings.name;
    if (name == null) return null;

    final uri = Uri.parse(name);

    // Expected: /second/<double>
    if (uri.pathSegments.length == 2 && uri.pathSegments.first == 'second') {
      final value = double.tryParse(uri.pathSegments[1]);
      if (value != null) {
        return MaterialPageRoute<double>(
          settings: settings,
          builder: (_) => SecondScreenWidget(value: value),
        );
      }
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navigation Example',
      home: const FirstScreenWidget(),
      onGenerateRoute: _onGenerateRoute,
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text('Route not found'))),
        );
      },
    );
  }
}

class FirstScreenWidget extends StatefulWidget {
  const FirstScreenWidget({super.key});

  @override
  State<FirstScreenWidget> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreenWidget> {
  double _value = 50.0;

  Future<void> _navigateUsingConstructor() async {
    final result = await Navigator.of(context).push<double>(
      MaterialPageRoute(builder: (_) => SecondScreenWidget(value: _value)),
    );

    setState(() {
      _value = result ?? 1.0;
    });
  }

  Future<void> _navigateUsingRoute() async {
    final result = await Navigator.of(
      context,
    ).pushNamed<double>('/second/$_value');

    setState(() {
      _value = result ?? 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('First Screen')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Slider(
              min: 1.0,
              max: 100.0,
              value: _value,
              onChanged: (value) => setState(() => _value = value),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _navigateUsingConstructor,
                  child: const Text('Pass via constructor'),
                ),
                ElevatedButton(
                  onPressed: _navigateUsingRoute,
                  child: const Text('Pass via route'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SecondScreenWidget extends StatefulWidget {
  const SecondScreenWidget({super.key, this.value = 1.0});

  final double value;

  @override
  State<SecondScreenWidget> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreenWidget> {
  late double _value;

  @override
  void initState() {
    super.initState();
    _value = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Second Screen')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Slider(
              min: 1.0,
              max: 100.0,
              value: _value,
              onChanged: (value) => setState(() => _value = value),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(_value),
              child: const Text('Return to First'),
            ),
          ],
        ),
      ),
    );
  }
}
