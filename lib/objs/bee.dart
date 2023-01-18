import 'package:flame/components.dart';
import 'package:flametest/objs/flower.dart';
import 'package:flametest/objs/spider.dart';

import '../game/util/utils.dart';
import 'obj.dart';

class Bee extends Obj {
  bool right = false;
  bool left = false;

  move(dt, speed) {
    if (right) {
      if (x <= 475) {
        x += speed;
      }
    }
    if (left) {
      if (x >= 25) {
        x -= speed;
      }
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is Spider) {
      other.position.y = -100.0;
    } else if (other is Flower) {
      other.position.y = -100.0;
      other.position.x = random(50, 500).toDouble();
      score += 1;
    }
  }
}
