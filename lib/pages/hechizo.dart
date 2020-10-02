import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app_harry/model/hechizo.dart';
import '../api/auth_api.dart';
import 'package:flutter/services.dart';

class HechizoPage extends StatefulWidget {
  @override
  _HechizoState createState() => _HechizoState();
}

class _HechizoState extends State<HechizoPage> {
  final _formKey = GlobalKey<FormState>();
  final _authAPI = AuthAPi();
  String _type = null;
  List<String> _lst_type = new List<String>();

  List<Hechizo> _hechizo;
  List<Hechizo> _hechizo_filter;
  bool _loading;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    _lst_type.addAll([
      "All",
    ]);
    _type = _lst_type.elementAt(0);
    _loading = true;
    _submit();
  }

  List<Hechizo> _listFilter() {
    List<Hechizo> _personajeTmp;
    _personajeTmp = _hechizo;
    _personajeTmp = _hechizo
        .where((f) => (_type == "All"
            ? true
            : (f.type.toString().split('.').last.toLowerCase()) ==
                _type.toLowerCase()))
        .toList();

    return _personajeTmp;
  }

  void _onChangedType(String type) {
    setState(() {
      _type = type;
      _hechizo_filter = _listFilter();
    });
  }

  _submit() async {
    _hechizo = await _authAPI.getSpells();
    setState(() {
      _hechizo = _hechizo;
      _hechizo_filter = _hechizo;
      _hechizo.forEach((element) => {
            _lst_type.add(element.type.toString().split('.').last.toLowerCase())
          });
      Set<String> colorSet = Set.from(_lst_type);
      _lst_type = colorSet.toList();
      //_lst_type.addAll(_peronaje.forEach((element) => {element.species}))
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
                                    value: _type,
                                    items: _lst_type.map((String type) {
                                      return DropdownMenuItem(
                                        value: type,
                                        child: Row(
                                          children: [
                                            new Icon(Icons.album),
                                            new Text("Tipo: ${type}")
                                          ],
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (String type) {
                                      _onChangedType(type);
                                    }),
                                SizedBox(
                                  width: size.width,
                                  height: size.height * 0.8,
                                  child: ListView.builder(
                                    itemCount: null == _hechizo_filter
                                        ? 0
                                        : _hechizo_filter.length,
                                    itemBuilder: (context, index) {
                                      Hechizo hechizo = _hechizo_filter[index];
                                      return ListTile(
                                        title: Text(hechizo.spell +
                                            " (" +
                                            hechizo.type.toString() +
                                            ")"),
                                        subtitle: Text((null == hechizo.effect
                                            ? " "
                                            : hechizo.effect
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
