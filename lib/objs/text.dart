import 'package:flame/components.dart';
import 'package:flutter/cupertino.dart';

class GameText extends TextComponent {
  GameText(String text, double x, double y, Color color)
      : super(
            text: text,
            position: Vector2(x, y),
            textRenderer: TextPaint(style: TextStyle(color: color)));
}
