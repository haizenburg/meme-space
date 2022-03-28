import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:memespace/resources/storage_methods.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //signUp function
  Future<String> signUpUser({
    required String email,
    required String username,
    required String bio,
    required String password,
    required Uint8List file,
  }) async {
    String res = "Picked up an error";

    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          bio.isNotEmpty ||
          file != null) {
        //register user
        UserCredential user = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        //upload profile img to db
        String photoUrl = await StorageMethods()
            .uploadImageToStorage('profilePicture', file, false);

        _firestore.collection('users').doc(user.user!.uid).set({
          "bio": bio,
          "username": username,
          "uid": user.user!.uid,
          "email": email,
          "followers": [],
          "following": [],
          "profileimgUrl": photoUrl,
        });

        res = 'successful';
      }
    } on FirebaseAuthException catch (err) {
      if (err.code == 'invalid-email') {
        res = 'email is badly formatted.';
      } else if (err.code == 'weak-password') {
        res = 'password should atleast be six characters';
      }
    } catch (e) {
      res = e.toString();
    }

    return res;
  }
}
