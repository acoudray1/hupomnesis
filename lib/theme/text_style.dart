import 'package:flutter/material.dart';

class Style {
  // Roboto Style - Header & Title
  static const TextStyle robotoBaseTextStyle = TextStyle(
    fontFamily: 'Roboto'
  );
  static final TextStyle titleTextStyle = robotoBaseTextStyle.copyWith(
    color: Colors.white,
    fontSize: 22.0,
    fontWeight: FontWeight.w600
  );
  static final TextStyle headerTextStyle = robotoBaseTextStyle.copyWith(
    color: Colors.white,
    fontSize: 40.0,
    fontWeight: FontWeight.bold
  );
  // Poppins Style - Small & Common & Subtitle
  static const TextStyle baseTextStyle = TextStyle(
    fontFamily: 'Poppins'
  );
  final TextStyle smallTextStyle = commonTextStyle.copyWith(
    fontSize: 9.0,
  );
  static final TextStyle commonTextStyle =baseTextStyle.copyWith(
      color: const Color(0xffb6b2df),
    fontSize: 14.0,
      fontWeight: FontWeight.w400
  );
  static final TextStyle subtitleTextStyle = baseTextStyle.copyWith(
    color: Colors.white,
    fontSize: 16.0,
    fontWeight: FontWeight.w400
  );
}