import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

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

class Button extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ButtonColors.backgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          AnimatedButton(
            height: 40,
            width: 120,
            text: 'Emerald',
            animationColor: ButtonColors.emerald,
          ),
          AnimatedButton(
            width: 120,
            height: 40,
            animationColor: ButtonColors.peterRiver,
            text: 'Peter River',
          ),
          AnimatedButton(
            width: 120,
            height: 40,
            text: 'Amythyst',
            animationColor: ButtonColors.amethyst,
          ),
          AnimatedButton(
            width: 120,
            height: 40,
            text: 'Wet Asphale',
            animationColor: ButtonColors.wetAsphalt,
          ),
          AnimatedButton(
            width: 120,
            height: 40,
            text: 'Carrot',
            animationColor: ButtonColors.carrot,
          ),
          AnimatedButton(
            width: 120,
            height: 40,
            text: 'Alizarin',
            animationColor: ButtonColors.alizarin,
          ),
        ],
      ),
    );
  }
}

class AnimatedButton extends StatefulWidget {
  final double height;
  final double width;
  final String text;
  final Color animationColor;

  AnimatedButton({this.height, this.width, this.text, this.animationColor});

  @override
  _AnimatedButtonState createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton>
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
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    );
    _animation = Tween(begin: 0.0, end: 500.0)
        .animate(CurvedAnimation(curve: Curves.easeIn, parent: _controller))
      ..addListener(() {
        setState(() {});
      });
    _borderAnimation =
        ColorTween(begin: ButtonColors.defaultColor, end: widget.animationColor)
            .animate(
          CurvedAnimation(curve: Curves.easeInOut, parent: _controller),
        );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
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
            onTap: () {},
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
              color: ButtonColors.backgroundColor,
              child: Stack(
                children: [
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                        color: widget.animationColor,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      width: _animation.value,
                    ),
                  ),
                  Center(
                    child: AnimatedDefaultTextStyle(
                      duration: Duration(milliseconds: 300),
                      style: TextStyle(color: textColor),
                      child: Text(widget.text),
                      curve: Curves.easeIn,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
