import 'package:flutter/material.dart';

class SizeUtils {
  static late BoxConstraints boxConstraints;
  static late Orientation orientation;
  static late double height;
  static late double width;

  static void setScreenSize(
    BoxConstraints constraints,
    Orientation currentOrientation,
  ) {
    boxConstraints = constraints;
    orientation = currentOrientation;
    if (orientation == Orientation.portrait) {
      width = boxConstraints.maxWidth.isNonZero(defaultValue: 375);
      height = boxConstraints.maxHeight.isNonZero();
    } else {
      width = boxConstraints.maxHeight.isNonZero(defaultValue: 375);
      height = boxConstraints.maxWidth.isNonZero();
    }
  }
}

extension ResponsiveExtension on num {
  double get h => ((this * SizeUtils.height) / 812);
  double get fSize => ((this * SizeUtils.width) / 375);
}

extension FormatExtension on double {
  double isNonZero({double defaultValue = 0.0}) {
    return this > 0 ? this : defaultValue;
  }
}
