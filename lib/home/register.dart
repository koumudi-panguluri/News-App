import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news/constants.dart';
import 'package:news/home/buttons.dart';

class Register extends StatelessWidget {
  final formKey = new GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  String _email;
  String _password;
  String _confirmPassword;
  static String password;

  String _submit() {
    _email = emailController.text;
    _password = passwordController.text;
    _confirmPassword = confirmPasswordController.text;

    if (formKey.currentState.validate()) {
      print("value $_email, $_password, $_confirmPassword");
      return "valid";
    } else {
      print("form invalid");
      return "invalid";
    }
  }

  Future<String> firebaseRegister() async {
    if (_submit() == "valid") {
      try {
        var user = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: _email, password: _password);
        print("user $user");
        return "valid";
      } catch (err) {
        print("Error occured while register $err");
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
                      _textFields("Email", emailController),
                      SizedBox(
                        height: 10,
                      ),
                      _textFields("Password", passwordController),
                      SizedBox(
                        height: 10,
                      ),
                      _textFields(
                          "Confirm Password", confirmPasswordController),
                      Button(
                        size: size,
                        text: "Sign Up",
                        submit: () => firebaseRegister(),
                      )
                      // FlatButton(
                      //     child: Text("Sign Up"), onPressed: () => _submit()),
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
          case "Confirm Password":
            return 'Please confirm your Password';
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
            } else {
              Register.password = value;
            }
            break;
          case "Confirm Password":
            if (Register.password != value) {
              return 'Password does not match';
            }
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
