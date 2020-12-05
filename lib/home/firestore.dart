import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> setDetails({shares, likes}) async {
  String userId = FirebaseAuth.instance.currentUser.uid;
  CollectionReference newsDetails =
      FirebaseFirestore.instance.collection('newsDetails');
  newsDetails.add({
    'userId': userId,
    'likes': likes,
    'shares': shares,
  });
  return;
}
