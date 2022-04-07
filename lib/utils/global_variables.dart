import 'package:flutter/material.dart';
import 'package:memespace/screens/add_post_screen.dart';
import 'package:memespace/screens/feed_screen.dart';

const webScreenSize = 600;

const homeScreenItems = [
  FeedScreen(),
  Text('search'),
  AddPostScreen(),
  Text('notify'),
  Text('profile'),
];
