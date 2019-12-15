import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: _StatefulProvider(
        child: _HomePage(),
      ),
    );
  }
}

class _StatefulProvider extends StatefulWidget {
  const _StatefulProvider({
    Key key,
    @required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  _StatefulProviderState createState() => _StatefulProviderState();
}

class _StatefulProviderState extends State<_StatefulProvider> {
  var _count = 1;

  @override
  Widget build(BuildContext context) {
    return Provider.value(
      value: message,
      child: Provider.value(
        value: this,
        child: widget.child,
      ),
    );
  }

  String get message {
    final result = _count % 15 == 0
        ? 'FizzBuzz'
        : (_count % 3 == 0 ? 'Fizz' : (_count % 5 == 0 ? 'Buzz' : '-'));
    print('_count: $_count, result: $result');
    return result;
  }

  void increment() => setState(() => _count++);
}

class _HomePage extends StatelessWidget {
  const _HomePage({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: () =>
            Provider.of<_StatefulProviderState>(context, listen: false)
                .increment(),
      ),
      body: const Center(
        child: _Message(),
      ),
    );
  }
}

class _Message extends StatelessWidget {
  const _Message({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    print('_Message: rebuild');
    return Text(
      'Message: ${Provider.of<String>(context)}',
      style: const TextStyle(fontSize: 64),
    );
  }
}
