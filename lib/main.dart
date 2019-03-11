// This example shows how to detect if the user has selected the logical "Q"
// key.

import 'package:flutter/material.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Code Sample for services.LogicalKeyboardKey',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  // The node used to request the keyboard focus.
  final FocusNode _focusNode = FocusNode();
// The message to display.
  String _message;

// Focus nodes need to be disposed.
  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

// Handles the key events from the RawKeyboardListener and update the
// _message.
  void _handleKeyEvent(RawKeyEvent event) {
    setState(() {
      if (event.logicalKey == LogicalKeyboardKey.keyQ) {
        _message = 'Pressed the "Q" key!';
      } else {
        if (kReleaseMode) {
          _message =
              'Not a Q: Key label is "${event.logicalKey.keyLabel ?? '<none>'}"';
        } else {
          // This will only print useful information in debug mode.
          _message = 'Not a Q: Pressed ${event.logicalKey.debugName}';
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      color: Colors.white,
      alignment: Alignment.center,
      child: DefaultTextStyle(
        style: textTheme.display1,
        child: RawKeyboardListener(
          focusNode: _focusNode,
          onKey: _handleKeyEvent,
          child: AnimatedBuilder(
            animation: _focusNode,
            builder: (BuildContext context, Widget child) {
              if (!_focusNode.hasFocus) {
                return GestureDetector(
                  onTap: () {
                    FocusScope.of(context).requestFocus(_focusNode);
                  },
                  child: Text('Tap to focus'),
                );
              }
              return Text(_message ?? 'Press a key');
            },
          ),
        ),
      ),
    );
  }
}
