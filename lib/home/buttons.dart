import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news/constants.dart';
import 'package:news/home/body.dart';
import 'package:news/home/login.dart';
import 'package:news/home/register.dart';

class Button extends StatelessWidget {
  final size;
  final text;
  final Function submit;
  Button({this.size, this.text, this.submit});
  @override
  Widget build(BuildContext context) {
    return Container(
        width: size.width * 0.6,
        margin: EdgeInsets.only(top: defaultPadding),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: FlatButton(
              color: buttonColor,
              padding: EdgeInsets.only(
                  left: defaultPadding,
                  right: defaultPadding,
                  top: 10,
                  bottom: 10),
              onPressed: () {
                switch (text) {
                  case 'Register':
                    print("register");
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Register()),
                    );
                    break;
                  case 'Login':
                    print("login");
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Login()),
                    );
                    break;
                  case 'Sign Up':
                    print("register");
                    submit().then((value) => {
                          if (value == "valid")
                            {
                              print("future value register $value"),
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Login()),
                              )
                            }
                          else
                            {
                              print("future value register $value"),
                            }
                        });
                    break;
                  case 'Sign In':
                    print("login");
                    submit().then((value) => {
                          if (value == "valid")
                            {
                              print("future value login $value"),
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Body()),
                              )
                            }
                          else
                            {
                              print("future value register $value"),
                            }
                        });
                    break;
                  default:
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Body()),
                    );
                }
              },
              child: Text(
                text,
                style: GoogleFonts.oswald(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.normal),
              ),
            )));
  }
}
