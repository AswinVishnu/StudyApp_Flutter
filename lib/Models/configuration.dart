import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Color primaryGreen = Color(0xff416d6d);
List<BoxShadow> shadowList = [
  BoxShadow(color: Colors.grey[300], blurRadius: 30, offset: Offset(0, 10))
];



List<Map> drawerItems=[
  {
    'icon': Icons.home,
    'title' : 'Home'
  },
  {
    'icon': FontAwesomeIcons.userAlt,
    'title' : 'Edit Profile'
  },
  {
    'icon': Icons.backpack,
    'title' : 'Perfomance'
  },
  {
    'icon': Icons.pages,
    'title' : 'Current Affairs'
  },
  {
    'icon': Icons.book,
    'title' : 'Study Materials'
  },
  {
    'icon': Icons.accessibility_new,
    'title' : 'Practice Tests'
  },
  {
    'icon': Icons.flag,
    'title' : 'Question Bank'
  },
];