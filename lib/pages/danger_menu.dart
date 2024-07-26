import 'package:flutter/material.dart';
import 'package:safetybuddy/constants.dart';

class DangerMenuContainer extends StatelessWidget {
  double screenWidth = getScreenWidth();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 183, 183, 183),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(26.0),
              topRight: Radius.circular(26.0),
            ),
          ),
          width: screenWidth,
          height: 400,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(20, 26, 0, 10),
                child: Text(
                  'What disturbed you?',
                  style: TextStyle(
                    color: Color.fromRGBO(48, 48, 48, 1),
                    fontSize: 20,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                        onPressed: () {},
                        icon: SizedBox(
                          //width: 60.0,
                          //height: 60.0,
                          child: Image.asset(
                            "assets/bulb.png",
                          ),
                        ),
                      ),
                      Text('Bad lights'),
                    ],
                  )),
                  Container(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                        onPressed: () {},
                        icon: SizedBox(
                          //width: 60.0,
                          //height: 60.0,
                          child: Image.asset(
                            "assets/dog.png",
                          ),
                        ),
                      ),
                      Text('Stray dogs'),
                    ],
                  )),
                  Container(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                        onPressed: () {},
                        icon: SizedBox(
                          //width: 60.0,
                          //height: 60.0,
                          child: Image.asset(
                            "assets/bulb.png",
                          ),
                        ),
                      ),
                      Text('TEST'),
                    ],
                  )),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                        onPressed: () {},
                        icon: SizedBox(
                          //width: 60.0,
                          //height: 60.0,
                          child: Image.asset(
                            "assets/bulb.png",
                          ),
                        ),
                      ),
                      Text('DE ADUGAT'),
                    ],
                  )),
                  Container(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                        onPressed: () {},
                        icon: SizedBox(
                          //width: 60.0,
                          //height: 60.0,
                          child: Image.asset(
                            "assets/dog.png",
                          ),
                        ),
                      ),
                      Text('++++'),
                    ],
                  )),
                  Container(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                        onPressed: () {},
                        icon: SizedBox(
                          //width: 60.0,
                          //height: 60.0,
                          child: Image.asset(
                            "assets/bulb.png",
                          ),
                        ),
                      ),
                      Text('DE ADAUGAT'),
                    ],
                  )),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: 4,
              width: 100,
              color: Color.fromRGBO(219, 219, 218, 1),
              margin: EdgeInsets.only(top: 8),
            ),
          ),
        ),
      ],
    );
  }
}
