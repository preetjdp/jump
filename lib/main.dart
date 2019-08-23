import 'dart:ui';

import 'package:flutter/material.dart';

void main() => runApp(JumpApp());

class JumpApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jump',
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  Animation<double> heightTween;
  Animation<double> widthTween;
  Animation<double> radiusTween;
  Animation<double> bottomTween;

  double get maxHeight => MediaQuery.of(context).size.height;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    heightTween = new Tween(begin: 800.0, end: 80.0).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.linearToEaseOut,
      reverseCurve: Curves.linearToEaseOut.flipped,
    ));
    widthTween = Tween(begin: 500.0, end: 80.0).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.linearToEaseOut,
      reverseCurve: Curves.linearToEaseOut.flipped,
    ));
    radiusTween = Tween(begin: 0.0, end: 60.0).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.linearToEaseOut,
      reverseCurve: Curves.linearToEaseOut.flipped,
    ));
    bottomTween = Tween(begin: 0.0, end: 30.0).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.linearToEaseOut,
      reverseCurve: Curves.linearToEaseOut.flipped,
    ));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
          if (heightTween.status == AnimationStatus.completed) {
            controller.reverse();
          } else if (heightTween.status == AnimationStatus.dismissed) {
            controller.forward();
          }
        },
      ),
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          AnimatedBuilder(
            animation: heightTween,
            builder: (BuildContext context, Widget widget) {
              return Positioned(
                height: heightTween.value,
                width: widthTween.value,
                bottom: bottomTween.value,
                child: Container(
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(252, 1, 7, 1),
                      borderRadius: BorderRadius.circular(radiusTween.value),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withAlpha(70),
                            offset: const Offset(3.0, 10.0),
                            blurRadius: 15.0)
                      ]),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
