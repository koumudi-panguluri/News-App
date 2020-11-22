import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news/constants.dart';
import 'package:news/home/body.dart';
import 'package:news/home/login.dart';
import 'package:news/home/register.dart';

class Button extends StatelessWidget {
  final size;
  final text;
  Button(this.size, this.text);
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Login()),
                    );
                    break;
                  case 'Sign In':
                    print("register");
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Body()),
                    );
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
