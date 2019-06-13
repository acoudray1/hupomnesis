// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
import 'package:flutter/material.dart';

ThemeData buildDarkTheme() {
  const Color primaryColor = Colors.deepPurple;//Color(0xFF5e35b1);
  const Color secondaryColor = Colors.deepPurpleAccent;
  const Color accentColor = Color(0xFFffb300);
  final ColorScheme colorScheme = const ColorScheme.dark().copyWith(
    primary: primaryColor,
    secondary: secondaryColor,
  );
  final ThemeData base = ThemeData(
    brightness: Brightness.dark,
    accentColorBrightness: Brightness.dark,
    primaryColor: primaryColor,
    primaryColorDark: const Color(0xFF0050a0),
    primaryColorLight: secondaryColor,
    buttonColor: secondaryColor,
    indicatorColor: Colors.white,
    toggleableActiveColor: const Color(0xFF40BCD8),
    accentColor: accentColor,
    canvasColor: const Color(0xFF202124),
    scaffoldBackgroundColor: const Color(0xFF202124),
    backgroundColor: const Color(0xFF202124),
    errorColor: const Color(0xFFB00020),
    buttonTheme: ButtonThemeData(
      colorScheme: colorScheme,
      textTheme: ButtonTextTheme.primary,
    ),
  );
  return base;
}

ThemeData buildLightTheme() {
  const Color primaryColor = Colors.blue;
  const Color secondaryColor = Colors.blueAccent;//Color(0xFF1976d2);
  const Color accentColor = Colors.indigoAccent;
  final ColorScheme colorScheme = const ColorScheme.light().copyWith(
    primary: primaryColor,
    secondary: secondaryColor,
  );
  final ThemeData base = ThemeData(
    brightness: Brightness.light,
    accentColorBrightness: Brightness.dark,
    colorScheme: colorScheme,
    primaryColor: primaryColor,
    buttonColor: secondaryColor,
    indicatorColor: Colors.white,
    toggleableActiveColor: const Color(0xFF1e88e5),
    splashColor: Colors.white24,
    splashFactory: InkRipple.splashFactory,
    accentColor: accentColor,
    canvasColor: Colors.white,
    scaffoldBackgroundColor: Colors.white,
    backgroundColor: Colors.white,
    errorColor: const Color(0xFFB00020),
    buttonTheme: ButtonThemeData(
      colorScheme: colorScheme,
      textTheme: ButtonTextTheme.primary,
    ),
  );
  return base;
}