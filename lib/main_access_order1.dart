import 'package:flutter/material.dart';

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

class _HomePage extends StatelessWidget {
  const _HomePage({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return _Inherited(
      message: '🐶',
      child: Scaffold(
        body: Center(
          child: const _Message(),
        ),
      ),
    );
  }
}

class _Message extends StatelessWidget {
  const _Message({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      'Message: ${_Inherited.of(context, listen: false).message}',
      style: TextStyle(fontSize: 96),
    );
  }
}

class _Inherited extends InheritedWidget {
  const _Inherited({
    Key key,
    @required this.message,
    @required Widget child,
  }) : super(key: key, child: child);

  final String message;

  static _Inherited of(
    BuildContext context, {
    @required bool listen,
  }) {
    return listen
        ? context.inheritFromWidgetOfExactType(_Inherited) as _Inherited
        : context
            .ancestorInheritedElementForWidgetOfExactType(_Inherited)
            .widget as _Inherited;
  }

  @override
  bool updateShouldNotify(_Inherited old) => false;
}
