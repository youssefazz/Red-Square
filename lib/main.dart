import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Square Gestures & Animations',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  int numTaps = 0;
  int doubleTaps = 0;
  int longPress = 0;
  double posX = 0.0;
  double posY = 0.0;
  double boxSize = 0.0;
  final double fullBoxSize = 150.0;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(milliseconds: 5000),
      vsync: this,
    );
    animation = CurvedAnimation(
      parent: controller,
      curve: Curves.easeInOut,
    );
    animation.addListener(() {
      setState(() {
        boxSize = fullBoxSize * animation.value;
      });
      centerSquare(context);
    });
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (posX == 0.0) {
      centerSquare(context);
    }
    return Scaffold(
        appBar: AppBar(
          title: Text("Square Gestures And Animations"),
        ),
        body: GestureDetector(
          onTap: () {
            setState(() {
              numTaps++;
            });
          },
          onDoubleTap: () {
            setState(() {
              doubleTaps++;
            });
          },
          onLongPress: () {
            setState(() {
              longPress++;
            });
          },
          onVerticalDragUpdate: (DragUpdateDetails value) {
            setState(() {
              double delta = value.delta.dy;
              posY += delta;
            });
          },
          onHorizontalDragUpdate: (DragUpdateDetails value) {
            setState(() {
              double delta = value.delta.dx;
              posX += delta;
            });
          },
          child: Stack(
            children: <Widget>[
              Positioned(
                left: posX,
                top: posY,
                child: Container(
                  width: boxSize,
                  height: boxSize,
                  decoration: BoxDecoration(
                    color: Colors.red,
                  ),
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: Material(
          color: Theme.of(context).primaryColorLight,
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: Text(
                "Taps: $numTaps -Double Taps : $doubleTaps -long Press:$longPress",
                style: Theme.of(context).textTheme.headline6),
          ),
        ));
  }

  void centerSquare(BuildContext context) {
    posX = (MediaQuery.of(context).size.width / 2) - boxSize / 2;
    posY = (MediaQuery.of(context).size.height / 2) - boxSize / 2 - 30.0;
    setState(() {
      posX = posX;
      posY = posY;
    });
  }
}
