import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:memespace/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:memespace/models/user.dart' as model;

class MobileLayout extends StatefulWidget {
  const MobileLayout({Key? key}) : super(key: key);

  @override
  State<MobileLayout> createState() => _MobileLayoutState();
}

class _MobileLayoutState extends State<MobileLayout> {

  // model.User user = Provider.of<UserProvider>(context).getUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Text('Mobile view'));
  }
}
