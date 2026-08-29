import 'package:flutter/material.dart';

class DrawingPoint {
  int id;
  List<Offset> offsets;
  Color color;
  double width;

  DrawingPoint({
    this.id = -1,
    this.offsets = const [],
    this.color = Colors.black,
    this.width = 2,
  });

  DrawingPoint copyWith({
    List<Offset>? offsets,
    Color? color,
    double? width,
  }) {
    return DrawingPoint(
      id: this.id,
      color: color ?? this.color,
      width: width ?? this.width,
      offsets: offsets ?? this.offsets,
    );
  }
}
