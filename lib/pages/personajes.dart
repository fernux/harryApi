import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app_harry/model/peronaje.dart';
import '../api/auth_api.dart';
import 'package:flutter/services.dart';

class PersonajesPage extends StatefulWidget {
  @override
  _PersonajesState createState() => _PersonajesState();
}

class _PersonajesState extends State<PersonajesPage> {
  final _formKey = GlobalKey<FormState>();
  final _authAPI = AuthAPi();
  var _username = '', _email = '', _password = '';
  String _blood = null;
  List<String> _lst_blood = new List<String>();
  String _house = null;
  List<String> _lst_house = new List<String>();
  String _species = null;
  List<String> _lst_species = new List<String>();

  List<Personaje> _peronaje;
  List<Personaje> _peronaje_filter;
  bool _loading;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    _lst_blood.addAll([
      "All",
      "half_blood",
      "half_giant",
      "muggle",
      "muggle_born",
      "pure_blood",
      "quarter_villa",
      "squib",
      "unknown",
    ]);
    _blood = _lst_blood.elementAt(0);
    _lst_house
        .addAll(["All", "Ravenclaw", "Slytherin", "Hufflepuff", "Gryffindor"]);
    _house = _lst_house.elementAt(0);
    _lst_species.addAll([
      "All",
    ]);
    _species = _lst_species.elementAt(0);
    _loading = true;
    _submit();
  }

  List<Personaje> _listFilter() {
    List<Personaje> _personajeTmp;
    _personajeTmp = _peronaje;
    _personajeTmp = _peronaje
        .where((f) =>
            (_blood == "All"
                ? true
                : (f.bloodStatus.toString().split('.').last.toLowerCase()) ==
                    _blood.toLowerCase()) &&
            (_house == "All"
                ? true
                : (f.house.toString().split('.').last.toLowerCase())
                    .startsWith(_house.toLowerCase())) &&
            (_species == "All" ? true : f.species.startsWith(_species)))
        .toList();

    return _personajeTmp;
  }

  void _onChangedBlood(String blood) {
    setState(() {
      _blood = blood;
      _peronaje_filter = _listFilter();
    });
  }

  void _onChangedHouse(String house) {
    setState(() {
      _house = house;
      _peronaje_filter = _listFilter();
    });
  }

  void _onChangedSpecies(String species) {
    setState(() {
      _species = species;
      _peronaje_filter = _listFilter();
    });
  }

  _submit() async {
    _peronaje = await _authAPI.getCharacters();
    setState(() {
      _peronaje = _peronaje;
      _peronaje_filter = _peronaje;
      _peronaje.forEach((element) => {_lst_species.add(element.species)});
      Set<String> colorSet = Set.from(_lst_species);
      _lst_species = colorSet.toList();
      //_lst_species.addAll(_peronaje.forEach((element) => {element.species}))
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        body: GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Container(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                width: size.width,
                height: size.height,
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(32.0),
                            child: Column(
                              children: [
                                DropdownButton(
                                    value: _blood,
                                    items: _lst_blood.map((String blood) {
                                      return DropdownMenuItem(
                                        value: blood,
                                        child: Row(
                                          children: [
                                            new Icon(Icons.accessibility),
                                            new Text("Sangre: ${blood}")
                                          ],
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (String blood) {
                                      _onChangedBlood(blood);
                                    }),
                                DropdownButton(
                                    value: _house,
                                    items: _lst_house.map((String house) {
                                      return DropdownMenuItem(
                                        value: house,
                                        child: Row(
                                          children: [
                                            new Icon(Icons.account_balance),
                                            new Text("Casa: ${house}")
                                          ],
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (String house) {
                                      _onChangedHouse(house);
                                    }),
                                DropdownButton(
                                    value: _species,
                                    items: _lst_species.map((String species) {
                                      return DropdownMenuItem(
                                        value: species,
                                        child: Row(
                                          children: [
                                            new Icon(Icons.album),
                                            new Text("Especie: ${species}")
                                          ],
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (String species) {
                                      _onChangedSpecies(species);
                                    }),
                                SizedBox(
                                  width: size.width,
                                  height: size.height * 0.7,
                                  child: ListView.builder(
                                    itemCount: null == _peronaje_filter
                                        ? 0
                                        : _peronaje_filter.length,
                                    itemBuilder: (context, index) {
                                      Personaje personaje =
                                          _peronaje_filter[index];
                                      return ListTile(
                                        title: Text(personaje.name +
                                            " (" +
                                            personaje.species.toString() +
                                            ")"),
                                        subtitle: Text((null == personaje.house
                                                ? " "
                                                : personaje.house
                                                    .toString()
                                                    .split('.')
                                                    .last) +
                                            "\n" +
                                            (null == personaje.bloodStatus
                                                ? " "
                                                : personaje.bloodStatus
                                                    .toString()
                                                    .split('.')
                                                    .last)),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          //SizedBox(height: 10,),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              child: SafeArea(
                child: CupertinoButton(
                  padding: EdgeInsets.all(10),
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.black12,
                  onPressed: () => Navigator.pop(context),
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
