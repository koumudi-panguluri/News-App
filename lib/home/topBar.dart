import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:news/constants.dart';
import 'package:news/home/catergory.dart';

class TopBar extends StatelessWidget {
  final Size size;
  TopBar(this.size);
  @override
  Widget build(BuildContext context) {
    return Container(
        height: size.height * 0.55,
        child: Stack(
          children: [
            Container(
                decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomRight,
                  stops: [0.0, 1.0],
                  colors: [Colors.white, primaryColor]),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(36),
                  bottomRight: Radius.circular(36)),
            )),
            _categoryTile(size),
            Column(
              children: [
                _circularDisplay(size),
                Container(
                    padding: EdgeInsets.only(
                        left: size.width * 0.2,
                        right: size.width * 0.2,
                        top: (size.height * 0.25) - size.height * 0.24),
                    child: Row(
                      children: [
                        _trackerTitle(size, "Favorites"),
                        Spacer(
                          flex: 9,
                        ),
                        _trackerTitle(size, "Shares")
                      ],
                    )),
                Container(
                    padding: EdgeInsets.only(
                        left: size.width * 0.24,
                        right: size.width * 0.23,
                        top: size.height * 0.25 * 0.07),
                    child: Row(
                      children: [
                        _trackerTitle(size, "145"),
                        Spacer(
                          flex: 9,
                        ),
                        _trackerTitle(size, "152")
                      ],
                    )),
              ],
            )
            // : Row(
            //     mainAxisAlignment: MainAxisAlignment.start,
            //     children: [
            //       Container(
            //         child: _circularDisplay(size),
            //       ),
            //       Spacer(
            //         flex: 5,
            //       ),
            //       Column(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: [
            //             _trackerTitle(size, "Favorites"),
            //             SizedBox(height: 10),
            //             _trackerTitle(size, "145"),
            //           ]),
            //       Spacer(
            //         flex: 5,
            //       ),
            //       Column(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: [
            //             _trackerTitle(size, "Shares"),
            //             SizedBox(height: 10),
            //             _trackerTitle(size, "152"),
            //           ]),
            //       Spacer(flex: 5)
            //     ],
            //   )
          ],
        ));
  }
}

Widget _circularDisplay(size) {
  return Container(
      padding: EdgeInsets.only(
          left: size.width * 0.05,
          right: size.width * 0.05,
          top: (size.height * 0.25) - size.height * 0.24),
      child: CircleAvatar(
        radius: 35,
        child: Text(
          "K",
          style: TextStyle(color: textColor, fontSize: 28),
        ),
        backgroundColor: Colors.white60,
      ));
}

Widget _trackerTitle(size, name) {
  return Text(
    name,
    style: TextStyle(color: Colors.white, fontSize: 20),
  );
}

Widget _categoryTile(size) {
  return Category(size);
}
