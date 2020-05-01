import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Button(),
    );
  }
}

class Button extends StatefulWidget {
  @override
  _ButtonState createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFECF0F1),
        body: Center(
          child: FillHorizontal(
            width: 120,
            height: 40.0,
            color: Color(0xFFC3C4C4),
            text: 'Peter River',
          ),
        ));
  }
}

class FillHorizontal extends StatefulWidget {
  final double width;
  final double height;
  final String text;
  final Color color;

  FillHorizontal({this.width, this.height, this.text, this.color});

  @override
  _FillHorizontalState createState() => _FillHorizontalState();
}

class _FillHorizontalState extends State<FillHorizontal>
    with SingleTickerProviderStateMixin {
  Color textColor;
  Color borderColor;
  AnimationController _controller;
  Animation _animation;

  @override
  void initState() {
    super.initState();
    textColor = Color(0xFFC3C4C4);
    borderColor = widget.color;
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _animation = Tween(begin: 0.0, end: 500.0).animate(CurvedAnimation(
      curve: Curves.easeIn,
      parent: _controller,
    ))
      ..addListener(() {
        setState(() {

        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: widget.height,
        width: widget.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(
            color: borderColor,
            width: 2,
          ),
        ),
        child: Material(
          child: InkWell(
            onTap: () {
              print('test');
            },
            onHover: (value) {
              if (value) {
                _controller.forward();
                setState(() {
                  textColor = Colors.white;
                  borderColor = Color(0xFF3498db);
                });
              } else {
                _controller.reverse();
                setState(() {
                  textColor = widget.color;
                  borderColor = widget.color;
                });
              }
            },
            child: Container(
              color: Color(0xFFECF0F1),
              child: Stack(
                children: [
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color(0xFF3498db),
                      ),
                      width: _animation.value,
                    ),
                  ),
                  Center(
                    child: AnimatedDefaultTextStyle(
                      duration: Duration(milliseconds: 300),
                      style: TextStyle(
                        color: textColor,
                      ),
                      child: Text(widget.text),
                      curve: Curves.easeIn,
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
