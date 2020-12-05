import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news/home/circularAvatar.dart';
import 'package:news/home/home.dart';

import '../main.dart';

class SideNav extends StatefulWidget {
  @override
  _SideNavState createState() => _SideNavState();
}

class _SideNavState extends State<SideNav> {
  Size size;
  bool _theme = false;

  void signOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Column(children: [
              Text(
                'Welcome Mate',
                style: GoogleFonts.teko(
                    textStyle: TextStyle(color: Colors.white, fontSize: 25)),
              ),
              CircularDisplay(size),
            ]),
            decoration: BoxDecoration(
                // color: primaryColor,
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/images/backgroundSidenav.jpg'))),
          ),
          ListTile(
            leading: Icon(Icons.input),
            title: Text('Welcome'),
            onTap: () => {},
          ),
          ListTile(
            leading: Icon(Icons.verified_user),
            title: Text('Profile'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          SwitchListTile(
              value: _theme,
              title: Text("Theme"),
              secondary: Icon(Icons.grass),
              onChanged: (bool value) {
                setState(() {
                  _theme = value;
                });
              }),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.border_color),
            title: Text('Feedback'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () => {
              signOut(),
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => MyHome(title: 'World News')),
              )
            },
          ),
        ],
      ),
    );
  }
}
