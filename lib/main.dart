import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ButtonColors {
  static get backgroundColor => const Color(0xFFECF0F1);

  static get defaultColor => const Color(0xFFC3C4C4);

  static get emerald => const Color(0xFF2ecc71);

  static get peterRiver => const Color(0xFF3498db);

  static get amethyst => const Color(0xFF9b59b6);

  static get wetAsphalt => const Color(0xFF34495e);

  static get carrot => const Color(0xFFe67e22);

  static get alizarin => const Color(0xFFe74c3c);
}

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
        backgroundColor: ButtonColors.backgroundColor,
        appBar: AppBar(
          centerTitle: true,
          title: Text('Fill Horizontal'),
          backgroundColor: Color(0xFF5C92A6),
        ),
        floatingActionButton: Container(
          height: 50,
          width: 50,
          child: FloatingActionButton(
            backgroundColor: Color(0xFF5C92A6),
            child: Icon(Icons.open_in_new),
            onPressed: () {},
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FillHorizontal(
                width: 120,
                height: 40.0,
                animationColor: ButtonColors.peterRiver,
                text: 'Peter River',
              ),
              FillHorizontal(
                width: 120,
                height: 40,
                animationColor: ButtonColors.emerald,
                text: 'Emerald',
              ),
              FillHorizontal(
                width: 120,
                height: 40,
                text: 'Amythyst',
                animationColor: ButtonColors.amethyst,
              ),
              FillHorizontal(
                width: 120,
                height: 40,
                text: 'Wet Asphale',
                animationColor: ButtonColors.wetAsphalt,
              ),
              FillHorizontal(
                width: 120,
                height: 40,
                text: 'Carrot',
                animationColor: ButtonColors.carrot,
              ),
              FillHorizontal(
                width: 120,
                height: 40,
                text: 'Alizarin',
                animationColor: ButtonColors.alizarin,
              ),
            ],
          ),
        ));
  }
}

class FillHorizontal extends StatefulWidget {
  final double width;
  final double height;
  final String text;
  final Color animationColor;

  FillHorizontal({this.width, this.height, this.text, this.animationColor});

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
    textColor = ButtonColors.defaultColor;
    borderColor = ButtonColors.defaultColor;
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _animation = Tween(begin: 0.0, end: 500.0).animate(CurvedAnimation(
      curve: Curves.easeIn,
      parent: _controller,
    ))
      ..addListener(() {
        setState(() {});
      });
    _borderAnimation = ColorTween(
            begin: ButtonColors.defaultColor, end: widget.animationColor)
        .animate(
            CurvedAnimation(curve: Curves.easeOutCirc, parent: _controller));
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
                  borderColor = widget.animationColor;
                });
              } else {
                _controller.reverse();
                setState(() {
                  textColor = ButtonColors.defaultColor;
                  borderColor = ButtonColors.defaultColor;
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
                          color: widget.animationColor,
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
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
