import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memespace/providers/user_provider.dart';
import 'package:memespace/utils/colors.dart';
import 'package:provider/provider.dart';
import 'package:memespace/models/user.dart' as model;

class MobileLayout extends StatefulWidget {
  const MobileLayout({Key? key}) : super(key: key);

  @override
  State<MobileLayout> createState() => _MobileLayoutState();
}

class _MobileLayoutState extends State<MobileLayout> {
  late PageController pageController;
  int _page = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void navigationTapped(int page) {
    pageController.jumpToPage(page);
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  // model.User user = Provider.of<UserProvider>(context).getUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: [],
        controller: pageController,
        onPageChanged: onPageChanged,
        physics: const NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: CupertinoTabBar(
          backgroundColor: mobileBackgroundColor,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home,
                    color: _page == 0 ? primaryColor : secondaryColor),
                label: '',
                backgroundColor: primaryColor),
            BottomNavigationBarItem(
                icon: Icon(Icons.search,
                    color: _page == 1 ? primaryColor : secondaryColor),
                label: '',
                backgroundColor: primaryColor),
            BottomNavigationBarItem(
                icon: Icon(Icons.add_circle,
                    color: _page == 2 ? primaryColor : secondaryColor),
                label: '',
                backgroundColor: primaryColor),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite,
                    color: _page == 3 ? primaryColor : secondaryColor),
                label: '',
                backgroundColor: primaryColor),
            BottomNavigationBarItem(
                icon: Icon(Icons.person,
                    color: _page == 4 ? primaryColor : secondaryColor),
                label: '',
                backgroundColor: primaryColor),
          ],
          onTap: navigationTapped),
    );
  }
}
