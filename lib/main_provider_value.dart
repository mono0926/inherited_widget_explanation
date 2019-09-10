import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const _HomePage(),
    );
  }
}

class _HomePage extends StatefulWidget {
  const _HomePage({Key key}) : super(key: key);

  @override
  __HomePageState createState() => __HomePageState();
}

class __HomePageState extends State<_HomePage> {
  var _count = 1;

  @override
  Widget build(BuildContext context) {
    return Provider<String>.value(
      value: _createMessage(),
// デフォルト実装が以下のようになっているので不要
//      updateShouldNotify: (previous, current) => previous != current,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.refresh),
          onPressed: () => setState(() => _count++),
        ),
        body: Center(
          child: const _Message(),
        ),
      ),
    );
  }

  String _createMessage() {
    final result = _count % 15 == 0
        ? 'FizzBuzz'
        : (_count % 3 == 0 ? 'Fizz' : (_count % 5 == 0 ? 'Buzz' : '-'));
    print('_count: $_count, result: $result');
    return result;
  }
}

class _Message extends StatelessWidget {
  const _Message({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    print('_Message: rebuild');
    return Text(
      'Message: ${Provider.of<String>(
        context,
        // デフォルトがtrueなので不要
//        listen: true,
      )}',
      style: TextStyle(fontSize: 64),
    );
  }
}
