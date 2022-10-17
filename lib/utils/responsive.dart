import 'package:flutter/material.dart';

extension Responsive on num {
  double get h => this * ResponsiveUtil.height / 100;
  double get w => this * ResponsiveUtil.width / 100;
  double get zoom => this * ResponsiveUtil.zoom;
}

class ResponsiveUtil {
  static late double height;
  static late double width;
  static late double zoom;

  static void setScreenSize(MediaQueryData size) {
    zoom = size.textScaleFactor;
    width = size.size.width;
    height = size.size.height;
  }
}
