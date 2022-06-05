import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scanner/constants/strings.dart';
import 'package:scanner/cubits/events_cubit.dart';

import 'package:scanner/screens/events_screen.dart';
import 'package:scanner/services/events_service.dart';
import 'package:scanner/services/login_service.dart';
import 'package:scanner/theme/zeplin_colors.dart';
import 'package:scanner/theme/zeplin_text_style.dart';

import '../models/login.dart';
import 'event_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late Future<Login> _login;

  @override
  void initState() {
    super.initState();
    _login = LoginService().getLogin();
  }

  @override
  Widget build(BuildContext context) {
    bool _secureText = true;
    TextEditingController _userNameController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();

    return Scaffold(
      body: Container(
        color: ZeplinColors.scaffold_background,
        child: FutureBuilder(
          future: _login,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            print(snapshot.hasData);
            if (snapshot.hasData) {
              Login login = snapshot.data;
              return Column(
                children: [
                  Padding(
                      padding:
                          EdgeInsets.only(left: 16.0, right: 16.0, top: 140.0),
                      child: Container(
                        height: 50,
                        width: 328,
                        child: Image.asset(Strings.graphics_golden_logo),
                      )),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 17.0, right: 15.0, top: 64.0),
                    child: TextField(
                      controller: _userNameController,
                      decoration: InputDecoration(
                        hintText: 'Username',
                        hintStyle: TextStyle(fontSize: 16, color: Colors.grey),
                        border: OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.remove_red_eye),
                          onPressed: () {
                            setState(() {
                              _secureText = !_secureText;
                            });
                          },
                        ),
                      ),
                      obscureText: _secureText,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 17.0, right: 15.0),
                    child: TextField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        hintStyle: TextStyle(fontSize: 16, color: Colors.grey),
                        border: OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.remove_red_eye),
                          onPressed: () {
                            setState(
                              () {
                                _secureText = !_secureText;
                              },
                            );
                          },
                        ),
                      ),
                      obscureText: _secureText,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 36.0, right: 36.0),
                    child: Container(
                      width: 162,
                      height: 36,
                      child: TextButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              ZeplinColors.primary_pink),
                          //Background Color
                          elevation: MaterialStateProperty.all(3),
                          //Defines Elevation
                          shadowColor: MaterialStateProperty.all(
                              ZeplinColors.primary_pink), //Defines shadowColor
                        ),
                        onPressed: () {
                          if (_userNameController.text == login.username &&
                              _passwordController.text == login.password) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => BlocProvider(
                                        create: (_) => EventsCubit(
                                            service: EventsService()),
                                        child: EventsScreen())));
                          } else {
                            // Center(
                            //     child: AlertDialog(
                            //   title: Text('FALSCHE LOGIN-DATEN !!'),
                            // ));

                            print('falsche Login Daten');
                          }
                        },
                        child: Text(Strings.button_sign_in.toUpperCase(),
                            style: ZeplinTextStyles.BodyBoldCAPSWhite14SP),
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.yellow,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
