import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:safetybuddy/constants.dart';
import 'package:safetybuddy/pages/danger_info.dart';
import 'package:geolocator/geolocator.dart';

class DangerMenuContainer extends StatefulWidget {
  @override
  State<DangerMenuContainer> createState() => _DangerMenuContainerState();
}

class _DangerMenuContainerState extends State<DangerMenuContainer> {
  double screenWidth = getScreenWidth();

  int groupValue = 1;

  int selectValue = 0;

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
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (ctx) => const DangerInfoForm(
                                    type: 'Bad lights',
                                  ));
                        },
                        icon: SizedBox(
                          //width: 60.0,
                          //height: 60.0,
                          child: Image.asset(
                            "assets/bulb.png",
                          ),
                        ),
                      ),
                      const Text('Bad lights'),
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
                      const Text('Stray dogs'),
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
                      const Text('TEST'),
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
                      const Text('DE ADUGAT'),
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
                      const Text('++++'),
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
                      const Text('DE ADAUGAT'),
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
              color: const Color.fromRGBO(219, 219, 218, 1),
              margin: const EdgeInsets.only(top: 8),
            ),
          ),
        ),
      ],
    );
  }
}
