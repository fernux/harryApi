import 'package:flutter/material.dart';
import 'package:flutter_app_harry/pages/casa.dart';
import 'package:flutter_app_harry/pages/casas.dart';
import 'package:flutter_app_harry/pages/personajes.dart';
import 'package:flutter_app_harry/pages/sombrero.dart';
import 'pages/basic.dart';
import 'pages/animated_widget.dart';
import 'pages/transform/translate_animation.dart';
import 'pages/transform/scale_animation.dart';
import 'pages/transform/rotate_animation.dart';
import 'pages/circular_menu.dart';
import 'pages/hechizo.dart';
import 'pages/sombrero.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Harry',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: CircularMenuPage(),
      routes: {
        "menu":(context)=>CircularMenuPage(),
        "hechizos":(context)=>HechizoPage(),
        "casas":(context)=>CasaPage(),
        "personajes":(context)=>PersonajesPage(),
        "sombrero":(context)=>SombreroPage(),
      },
    );
  }
}


