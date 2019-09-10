import 'package:flutter/material.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const _StatefulInherited(
        child: _HomePage(),
      ),
    );
  }
}

class _StatefulInherited extends StatefulWidget {
  const _StatefulInherited({
    Key key,
    @required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  _StatefulInheritedState createState() => _StatefulInheritedState();

  static _StatefulInheritedState of(
    BuildContext context, {
    @required bool listen,
  }) {
    return listen
        ? (context.inheritFromWidgetOfExactType(_Inherited) as _Inherited).state
        : (context
                .ancestorInheritedElementForWidgetOfExactType(_Inherited)
                .widget as _Inherited)
            .state;
  }
}

class _StatefulInheritedState extends State<_StatefulInherited> {
  var _count = 1;

  @override
  Widget build(BuildContext context) {
    return _Inherited(
      state: this,
      child: widget.child,
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

class _Inherited extends InheritedWidget {
  const _Inherited({
    Key key,
    @required this.state,
    @required Widget child,
  }) : super(key: key, child: child);

  final _StatefulInheritedState state;

  // Stateのmessageで比較したいところだが、Stateはmutableで
  // 過去の値との比較不可能のため仕方なく常にtrue
  @override
  bool updateShouldNotify(_Inherited old) => true;
}

class _HomePage extends StatelessWidget {
  const _HomePage({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: () =>
            _StatefulInherited.of(context, listen: false).increment(),
      ),
      body: Center(
        child: const _Message(),
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
      'Message: ${_StatefulInherited.of(
        context,
        // 変更監視する
        listen: true,
      ).message}',
      style: TextStyle(fontSize: 64),
    );
  }
}
