import 'package:flutter/material.dart';

class ColorParse {
  static Color parse(String color) {
    return Color(int.parse('0xff$color'));
  }
}