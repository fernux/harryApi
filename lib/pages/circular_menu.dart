import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math' as math;

class MenuOption {
  final String label;
  final IconData iconData;

  MenuOption(this.label, this.iconData);
}

class CircularMenuPage extends StatefulWidget {
  @override
  _CircularMenuPageState createState() => _CircularMenuPageState();
}

class _CircularMenuPageState extends State<CircularMenuPage>
    with TickerProviderStateMixin {
  List<MenuOption> _options = List();
  AnimationController _controller;
  Animation<double> _animatedAngle;


  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: Duration(milliseconds: 500), vsync: this);

    _animatedAngle =
        Tween<double>(begin: -math.pi, end: 0).animate(_controller);

    _animatedAngle.addListener(() {
      setState(() {});
    });

    _options.add(MenuOption("Sombrero seleccionador", Icons.account_circle));
    _options.add(MenuOption("Personajes", Icons.accessibility_new));
    _options.add(MenuOption("Casas", Icons.account_balance));
    _options.add(MenuOption("Hechizos", Icons.ac_unit));


    _controller.forward();
  }



  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    final decoratorWidth = 0.8 * size.width;
    final outDecoratorWidth = decoratorWidth + 160;

    final int itemsCount = _options.length;
    final step = math.pi / itemsCount;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Toolbar(),
              Expanded(
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Positioned(
                      right:  -decoratorWidth / 2,
                      child: Transform.rotate(
                        angle: _animatedAngle.value,
                        child: SvgPicture.asset(
                          'assets/decoration.svg',
                          width: decoratorWidth,
                        ),
                      ),
                    ),
                    Positioned(
                      right: -outDecoratorWidth / 2,
                      child: Transform.rotate(
                        angle: _animatedAngle.value,
                        child: Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            Container(
                              width: outDecoratorWidth,
                              height: outDecoratorWidth,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      width: 2, color: Colors.orangeAccent)),
                            ),
                            ...List.generate(itemsCount, (int index) {
                              final option = _options[index];

                              final angle =
                                  (math.pi / 2 + index * step) + (step / 2);

                              return MenuItem(
                                option: option,
                                textOffset: Offset(
                                    -100, 10 - (30 * (index / itemsCount))),
                                offset: Offset(
                                    outDecoratorWidth / 2 * math.cos(angle),
                                    outDecoratorWidth / 2 * math.sin(angle)),
                              );
                            }).toList()
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 50,
                color: Color(0xfff0f0f0),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  final Offset offset, textOffset;
  final MenuOption option;

  const MenuItem(
      {Key key,
      @required this.offset,
      @required this.textOffset,
      @required this.option})
      : super(key: key);

  _navigator(BuildContext contex,String valor){
    var command = valor;
    switch (command) {
      case 'Hechizos':
        Navigator.pushNamed(contex, "hechizos");
        break;
      case 'Casas':
        Navigator.pushNamed(contex, "casas");
        break;
      case 'Personajes':
        Navigator.pushNamed(contex, "personajes");
        break;
      case 'Sombrero seleccionador':
        Navigator.pushNamed(contex, "sombrero");
        break;
      default:
        Navigator.pushNamed(contex, "menu");
    }

  }

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: offset,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Transform.translate(
              offset: textOffset,
              child: SizedBox(
                width: 100,
                child: Text(option.label, textAlign: TextAlign.right),
              )),
          CupertinoButton(
            onPressed: () => { _navigator(context,option.label)},
            padding: EdgeInsets.zero,
            child: Container(
              width: 50,
              height: 50,
              child: Center(
                child: Icon(
                  option.iconData,
                  color: Colors.white,
                ),
              ),
              decoration: BoxDecoration(
                  color: Colors.orangeAccent, shape: BoxShape.circle),
            ),
          )
        ],
      ),
    );
  }
}

class Toolbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "Selecciona una Actividad \n Muggle!!",
            style: TextStyle(
                fontSize: 19, fontWeight: FontWeight.bold, letterSpacing: 1),
          ),

        ],
      ),
    );
  }
}
