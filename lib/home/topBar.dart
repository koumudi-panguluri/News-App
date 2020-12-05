import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:news/constants.dart';
import 'package:news/home/catergory.dart';
import 'package:news/home/circularAvatar.dart';

class TopBar extends StatelessWidget {
  final Size size;
  TopBar(this.size);
  var totalLikes = 0;
  var totalShares = 0;
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
                CircularDisplay(size),
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
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('newsDetails')
                          .snapshots(),
                      builder: (context, snapshot) {
                        // print("length ${snapshot.data.documents.length}");
                        if (!snapshot.hasData)
                          return Text("Loading, Please wait..!");
                        else {
                          totalLikes = 0;
                          totalShares = 0;

                          snapshot.data.documents.map((value) {
                            if (value['userId'].toString() ==
                                FirebaseAuth.instance.currentUser.uid) {
                              print("match");
                              if (value['likes'] != null) {
                                totalLikes += 1;
                                print("likes $totalLikes");
                              } else if (value['shares'] != null) {
                                totalShares += 1;
                                print("shares $totalShares");
                              }
                            } else {
                              print("not match");
                            }
                          }).toList();
                        }
                        return Row(
                          children: [
                            _trackerTitle(size, totalLikes.toString()),
                            Spacer(
                              flex: 9,
                            ),
                            _trackerTitle(size, totalShares.toString())
                          ],
                        );
                      },
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

Widget _trackerTitle(size, name) {
  return Text(
    name,
    style: TextStyle(color: Colors.white, fontSize: 20),
  );
}

Widget _categoryTile(size) {
  return Category(size);
}
