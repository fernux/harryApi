import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../api/auth_api.dart';
import 'package:flutter/services.dart';
import 'package:flare_dart/actor.dart';


class SombreroPage extends StatefulWidget {
  @override
  _SombreroState createState() => _SombreroState();
}

class _SombreroState extends State<SombreroPage> {

  final _formKey =GlobalKey<FormState>();
  final _authAPI=AuthAPi();
  var _casa='', _email='',_password='';
  var _dirimg='';
  var _isFetching=false;


  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  }

  _submit() async{
    if(_isFetching) return;
    //final isValid=_formKey.currentState.validate();
    //if(isValid){
    setState(() {
      _isFetching = true;
    });
      final isOk= await _authAPI.sortingHat();
    setState(() {
      _isFetching = false;
    });
      if(isOk.isNotEmpty){
        _casa = isOk;
        print("llamado correcto" +isOk);

        var command = isOk;
        switch (command) {
          case 'Gryffindor':
            _dirimg = 'assets/gryffindor.png';
            break;
          case 'Hufflepuff':
            _dirimg = 'assets/hufflepuff.png';
            break;
          case 'Ravenclaw':
            _dirimg = 'assets/ravenclaw.png';
            break;
          case 'Slytherin':
            _dirimg = 'assets/slytherin.png';
            break;
          default:
            _dirimg = 'assets/';
        }
      }
   // }


  }

  @override
  Widget build(BuildContext context) {

    final size =MediaQuery.of(context).size;

    return Scaffold(

      body: GestureDetector(
        onTap: (){
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

                            SizedBox(height: 30,),
                            Text(

                              "mmmm tu casa es... \n$_casa",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w300
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(32.0),
                              child: Container(
                                width: 200,
                                height: 200,
                                child: FlareActor(
                                  "assets/hatmagic.flr",
                                  animation: "mmm",
                                  color: Colors.black,
                                ),
                              )
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Container(
                                width: 200,
                                height: 200,
                                child: Image.asset(_dirimg),
                              )
                            )
                          ],
                        ),
                        Column(

                          children: [
                            ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxWidth: 350,
                                  minWidth: 350,
                                ),
                                child: Form(
                                  key: _formKey,
                                  child:  Column(


                                  ),
                                ),
                            ),
                            SizedBox(height: 50),
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth: 350,
                                minWidth: 350,
                              ),
                              child: CupertinoButton(
                                padding: EdgeInsets.symmetric(vertical: 17),
                                color: Colors.blueAccent,
                                child: Text("Usar sombrero seleccionador",
                                  style: TextStyle(fontSize: 20),

                                ),
                                borderRadius: BorderRadius.circular(4),
                                onPressed:() => _submit(),
                              ),
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,

                            ),
                            SizedBox(height: size.height*0.08,)


                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              _isFetching? Positioned.fill(child: Container(
                color: Colors.black45,
                child: Center(
                  child: CupertinoActivityIndicator(radius: 15),
                ),
              )):Container(),
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
      )

    );
  }
}
