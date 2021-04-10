import 'package:flutter/material.dart';

class Space {
  static SizedBox v(double verticalSize) {
    return SizedBox(width: 1, height: verticalSize < 0 ? 0 : verticalSize);
  }

  static SizedBox h(double horizontalSize) {
    return SizedBox(
      width: horizontalSize < 0 ? 0 : horizontalSize,
      height: 1,
    );
  }

  static Expanded ex() {
    return Expanded(child: Container());
  }

  static EdgeInsets vEdge(double verticalEdge) {
    return EdgeInsets.only(top: verticalEdge, bottom: verticalEdge);
  }

  static EdgeInsets hEdge(double horizontalEdge) {
    return EdgeInsets.only(left: horizontalEdge, right: horizontalEdge);
  }
}