import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class AppGradients {
  static final linear = LinearGradient(colors: [
    Color(0xFF7CBCC9),
    Color(0XFF034B8D),
  ], stops: [
    0.0,
    0.695
  ], transform: GradientRotation(0.5 * pi / 3));
}
