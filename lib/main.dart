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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FillHorizontal(
                width: 120,
                height: 40.0,
                color: Color(0xFFC3C4C4),
                text: 'Peter River',
              ),
              FillHorizontal(
                width: 120,
                height: 40,
                color: Color(0xFF2ecc71),
                text: 'Emerald',
              )
            ],
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
  Animation _borderAnimation;

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
        setState(() {});
      });
    _borderAnimation = ColorTween(begin: widget.color, end: Color(0xFF3498db))
        .animate(CurvedAnimation(curve: Curves.easeOutCirc, parent: _controller));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: widget.height,
        width: widget.width,
        child: Material(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
              side: BorderSide(
                color: _borderAnimation.value,
                width: 2,
              )),
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
                          borderRadius: BorderRadius.circular(5.0)),
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
