import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class CircularDisplay extends StatelessWidget {
  final size;
  CircularDisplay(this.size);
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(
            left: size.width * 0.05,
            right: size.width * 0.05,
            top: (size.height * 0.25) - size.height * 0.24),
        child: CircleAvatar(
          radius: 35,
          child: Text(
            FirebaseAuth.instance.currentUser.email[0].toUpperCase(),
            style: TextStyle(color: textColor, fontSize: 28),
          ),
          backgroundColor: Colors.white60,
        ));
  }
}
