import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news/constants.dart';
import 'package:news/home/buttons.dart';

class Register extends StatelessWidget {
  final formKey = new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text("Register for News App"),
          elevation: 0,
        ),
        body: SingleChildScrollView(
            child: Container(
          height: size.height,
          margin: EdgeInsets.only(top: defaultPadding * 1.2),
          child: Column(
            children: [
              Center(
                  child: Text("Register",
                      style: GoogleFonts.shadowsIntoLight(
                          textStyle: TextStyle(
                              fontSize: 20,
                              color: textColor,
                              fontWeight: FontWeight.bold)))),
              Container(
                child: SvgPicture.asset(
                  "assets/images/signup.svg",
                  height: size.height * 0.45,
                  width: size.width,
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    top: defaultPadding,
                    left: defaultPadding * 3,
                    right: defaultPadding * 3),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      _textFields("Email"),
                      SizedBox(
                        height: 10,
                      ),
                      _textFields("Password"),
                      SizedBox(
                        height: 10,
                      ),
                      _textFields("Confirm Password"),
                      Button(size, "Sign Up"),
                    ],
                  ),
                ),
              )
            ],
          ),
        )));
  }
}

Widget _textFields(text) {
  return TextFormField(
    decoration: new InputDecoration(
        border: new OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            const Radius.circular(50),
          ),
        ),
        filled: true,
        hintStyle: new TextStyle(color: buttonColor, fontSize: 18),
        hintText: text,
        fillColor: Colors.white70),
  );
}
