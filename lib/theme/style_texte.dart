import 'package:flutter/material.dart';

// ignore: avoid_classes_with_only_static_members
class Style {
  // Roboto Style - Header & Title
  static const TextStyle robotoBaseTextStyle = TextStyle(
    fontFamily: 'Roboto'
  );
  static final TextStyle headerTextStyle = robotoBaseTextStyle.copyWith(
    color: Colors.black,
    fontSize: 40.0,
    fontWeight: FontWeight.bold
  );
  static final TextStyle titleTextStyle = robotoBaseTextStyle.copyWith(
    color: Colors.black,
    fontSize: 22.0,
    fontWeight: FontWeight.w600
  );
  static final TextStyle subtitleTextStyle = robotoBaseTextStyle.copyWith(
    color: Colors.black,
    fontSize: 16.0,
    fontWeight: FontWeight.w400
  );
  static final TextStyle commonTextStyle = robotoBaseTextStyle.copyWith(
    color: Colors.black,
    fontSize: 14.0,
    fontWeight: FontWeight.w400
  );
  static final TextStyle smallTextStyle = robotoBaseTextStyle.copyWith(
    color: Colors.black,
    fontSize: 12.0,
    fontWeight: FontWeight.w400
  );
}