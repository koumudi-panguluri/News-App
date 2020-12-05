import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news/constants.dart';
import 'package:news/home/buttons.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: Text("Welcome to News App",
                  style: GoogleFonts.shadowsIntoLight(
                      textStyle: TextStyle(
                          fontSize: 20,
                          color: textColor,
                          fontWeight: FontWeight.bold)))),
          Container(
            child: SvgPicture.asset(
              "assets/images/chat.svg",
              height: size.height * 0.55,
              width: size.width,
            ),
          ),
          Button(size, "Login"),
          Button(size, "Register"),
        ],
      ),
    );
  }
}
