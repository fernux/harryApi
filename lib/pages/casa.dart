import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_harry/api/auth_api.dart';
import 'package:flutter_app_harry/model/casa.dart';
import 'package:flutter_app_harry/model/peronaje.dart';

class CasaPage extends StatefulWidget {
  @override
  _CasaPageState createState() => _CasaPageState();
}

class _CasaPageState extends State<CasaPage> {
  final _authAPI = AuthAPi();
  ScrollController controller = ScrollController();
  bool closeTopContainer = false;
  double topContainer = 0;
  List<Casa> rList;
  String _filtra_casa="gryffindor";

  bool _reloader=true;

  List<Casa> _responseList = List<Casa>();
  List<Personaje> responseList =[];
  List<Widget> itemsData = [];

  void getPostsData() async {

      responseList = await _authAPI.getCharacters();
     // rList = await _authAPI.gethouses();
      responseList =
          responseList.where((f) => (f.house.toString().split('.').last.toLowerCase()).startsWith(_filtra_casa.toLowerCase())).toList();
    List<Widget> listItems = [];
    responseList.forEach((post) {
      listItems.add(
          GestureDetector(
              onTap: () =>
              {
                print(post.name)
              },
              child:
              Container(
                  height: 150,
                  margin: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(color: Colors.black.withAlpha(100),
                            blurRadius: 10.0),
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              post.name,
                              style: const TextStyle(
                                  fontSize: 28, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              post.species,
                              style: const TextStyle(
                                  fontSize: 17, color: Colors.grey),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "${post.role}",
                              style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.black26,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),

                      ],
                    ),
                  ))));
    });
    setState(() {
      itemsData = listItems;
    });
  }

  _respuestaData() async {
    _responseList = await _authAPI.gethouses();
  }

  @override
  void initState() {
    super.initState();
    _respuestaData();
    getPostsData();
    setState(() {
      _responseList = _responseList;
    });

    // categoriesScroller = CategoriesScroller()._submit();

    controller.addListener(() {
      double value = controller.offset / 119;

      setState(() {
        topContainer = value;
        closeTopContainer = controller.offset > 50;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;
    final double categoryHeight = size.height * 0.30;
    return Scaffold(
        body: Container(
            width: size.width,
            height: size.height,
            child: Stack(
              children: [
                Column(
                  children: <Widget>[
                    const SizedBox(
                      height: 10,
                    ),
                    AnimatedOpacity(
                      duration: const Duration(milliseconds: 200),
                      opacity: closeTopContainer ? 0 : 1,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: size.width,
                        alignment: Alignment.topCenter,
                        height: closeTopContainer ? 0 : categoryHeight,
                        child: SingleChildScrollView(
                          child: Container(
                            width: size.width,
                            height: size.height,
                            child: SafeArea(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(32.0),
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: size.height * 0.2,
                                              child: ListView.builder(
                                                scrollDirection: Axis
                                                    .horizontal,
                                                itemCount: null == _responseList
                                                    ? 0
                                                    : _responseList.length,
                                                itemBuilder: (context, index) {
                                                  Casa casa = _responseList[index];
                                                  return  InkWell(
                                                    child: Container(
                                                      width: 150,
                                                      margin:
                                                      EdgeInsets.only(right: 20),
                                                      height: 200,
                                                      decoration: BoxDecoration(
                                                          image: DecorationImage(
                                                            image: AssetImage(
                                                                "assets/${casa.name.toString().split('.').last.toLowerCase()}.png"),
                                                            fit: BoxFit.cover,
                                                            colorFilter:
                                                            ColorFilter.mode(
                                                                Colors.black54,
                                                                BlendMode
                                                                    .hardLight),
                                                          ),
                                                          borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  20.0))),
                                                      child: Padding(
                                                        padding: const EdgeInsets
                                                            .all(
                                                            12.0),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                          children: <Widget>[
                                                            Text(
                                                              casa.name,
                                                              style: TextStyle(
                                                                  fontSize: 25,
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                            ),
                                                            SizedBox(
                                                              height: 10,
                                                            ),
                                                            Text(
                                                              casa.name,
                                                              style: TextStyle(
                                                                  fontSize: 16,
                                                                  color:
                                                                  Colors.white),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    onTap: (){
                                                      print(casa.name);
                                                      _filtra_casa=casa.name;
                                                      getPostsData();
                                                    },
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
                      ),
                    ),
                    Expanded(
                        child: ListView.builder(
                            controller: controller,
                            itemCount: itemsData.length,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              double scale = 1.0;
                              if (topContainer > 0.5) {
                                scale = index + 0.5 - topContainer;
                                if (scale < 0) {
                                  scale = 0;
                                } else if (scale > 1) {
                                  scale = 1;
                                }
                              }
                              return Opacity(
                                opacity: scale,
                                child: Transform(
                                  transform: Matrix4.identity()
                                    ..scale(scale, scale),
                                  alignment: Alignment.bottomCenter,
                                  child: Align(
                                      heightFactor: 0.7,
                                      alignment: Alignment.topCenter,
                                      child: itemsData[index]),
                                ),
                              );
                            })),
                  ],
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
        );
  }
}
