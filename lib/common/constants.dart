import 'package:flutter/material.dart';

// Colors
const primaryColor = Color(0xff0f17ad);
const normalBmiColor = Color(0xFF66BB6A);
const activeButtonBgColor = Colors.white;
const activeButtonTextColor = Color(0xFFffffff);
final inactiveButtonBgColor = const Color(0xFFb7bce8).withOpacity(.5);
final inactiveButtonTextColor = Colors.white.withOpacity(.7);
const containerGradientColors = <Color>[Color(0xFFb7bce8), Color(0xFF6d8dea)];

// Decorations
final actionButtonDecoration = BoxDecoration(
  shape: BoxShape.circle,
  boxShadow: [
    BoxShadow(
      color: primaryColor.withOpacity(.4),
      blurRadius: 6,
      offset: const Offset(0, 2),
    ),
  ],
);

const mainContainerDecoration = BoxDecoration(
  boxShadow: [
    BoxShadow(blurRadius: .5, color: primaryColor),
  ],
  gradient: LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: containerGradientColors,
  ),
);

// Text Styles
const appBarTextStyle = TextStyle(
  color: Color(0xFF5564d8),
  fontSize: 22,
  fontWeight: FontWeight.w900,
);
