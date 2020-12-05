import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news/constants.dart';
import 'package:news/home/buttons.dart';

class Login extends StatelessWidget {
  final formKey = new GlobalKey<FormState>();
  final loginEmailController = TextEditingController();
  final loginPasswordController = TextEditingController();
  String _email;
  String _password;
  String _submit() {
    _email = loginEmailController.text;
    _password = loginPasswordController.text;
    if (formKey.currentState.validate()) {
      print("value $_email, $_password,");
      return "valid";
    } else {
      print("form invalid");
      return "invalid";
    }
  }

  Future<String> firebaseLogin() async {
    if (_submit() == "valid") {
      try {
        var user = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _email, password: _password);
        print("user $user");
        return "valid";
      } catch (err) {
        print("Error occured while login $err");
        return "invalid";
      }
    } else {
      print("form invalid");
      return "invalid";
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text("Login for News App"),
          elevation: 0,
        ),
        body: SingleChildScrollView(
            child: Container(
          height: size.height,
          margin: EdgeInsets.only(top: defaultPadding * 1.2),
          child: Column(
            children: [
              Center(
                  child: Text("Login",
                      style: GoogleFonts.shadowsIntoLight(
                          textStyle: TextStyle(
                              fontSize: 20,
                              color: textColor,
                              fontWeight: FontWeight.bold)))),
              Container(
                child: SvgPicture.asset(
                  "assets/images/login.svg",
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
                      _textFields("Email", loginEmailController),
                      SizedBox(
                        height: 10,
                      ),
                      _textFields("Password", loginPasswordController),
                      SizedBox(
                        height: 10,
                      ),
                      Button(
                          size: size,
                          text: "Sign In",
                          submit: () => firebaseLogin())
                    ],
                  ),
                ),
              )
            ],
          ),
        )));
  }
}

Widget _textFields(text, label) {
  return TextFormField(
    controller: label,
    obscureText: text == "Email" ? false : true,
    validator: (value) {
      if (value.isEmpty) {
        switch (text) {
          case "Email":
            return 'Please enter your Email Id';
            break;
          case "Password":
            return 'Please enter your Password';
            break;
        }
      } else {
        switch (text) {
          case "Email":
            RegExp emailRegExp = new RegExp(emailPattern);
            if (!emailRegExp.hasMatch(value)) {
              return 'Please enter proper Email Id';
            }
            break;
          case "Password":
            if (value.length < 6) {
              return 'Password should be greater than 6 characters';
            }
            break;
        }
      }
      return null;
    },
    decoration: new InputDecoration(
        border: new OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            const Radius.circular(50),
          ),
        ),
        filled: true,
        hintStyle: new TextStyle(color: Colors.grey, fontSize: 15),
        hintText: text == "Email" ? "john@gmail.com" : text,
        fillColor: Colors.white70),
  );
}
