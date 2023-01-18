import 'dart:ffi';
import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/src/geometry/ray2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(GameWidget(game: BeeHoney()));
}

class BeeHoney extends FlameGame with HasCollisionDetection, KeyboardEvents {
  // SpriteComponent -> Definir Posição Cor tipo imagem tamanho
  Bg bg = Bg();
  Bg bg2 = Bg();
  Bee bee = Bee();
  Spider spider = Spider();
  Flower flower = Flower();
  @override
  Future<void>? onLoad() async {
    bg
      ..sprite = await Sprite.load("bg.png")
      ..size.x = 500 // tamanho em X
      ..size.y = 900 //tamanho em Y
      ..position = Vector2(0, 0); // Posicao em X | Y

    add(bg); // Adicione o objeto na tela
    add(bg2);
    bg2
      ..sprite = await Sprite.load("bg.png")
      ..size.x = 500 // tamanho em X
      ..size.y = 900 //tamanho em Y
      ..position = Vector2(0, -900)
      ..add(RectangleHitbox());

    bee
      ..sprite = await Sprite.load("bee1.png")
      ..size = Vector2.all(50) //---> Define tamanho
      ..position = Vector2(250, 800)
      ..anchor = Anchor.center // Define ela no ponto central
      ..add(RectangleHitbox());

    add(bee);
    spider
      ..sprite = await Sprite.load("spider1.png")
      ..size = Vector2.all(80)
      ..position = Vector2(250, 500)
      ..anchor = Anchor.center
      ..add(RectangleHitbox());

    add(spider);

    flower
      ..sprite = await Sprite.load("florwer1.png")
      ..size = Vector2.all(30)
      ..position = Vector2(200, 400)
      ..anchor = Anchor.center
      ..add(RectangleHitbox());
    add(flower);

    return super.onLoad();
  }

  @override
  void update(double dt) {
    //delta time- independente do nivel de processamento
    bg.move(dt, 100, 900, 0.0);
    bg2.move(dt, 100, 0, -900.0);

    bee.move(dt, 10);
    bee.animation(8, 4, 'bee');

    spider.animation(8, 4, 'spider');
    spider.move(dt, bee);

    flower.move(dt, 110);
    flower.animation(8, 2, 'florwer');
    super.update(dt);
  }

  @override
  KeyEventResult onKeyEvent(
      RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    if (event.data.keyLabel == "a") {
      bee.left = true;
    } else if (event.data.keyLabel == "d") {
      bee.right = true;
    } else {
      bee.left = false;
      bee.right = false;
    }
    return super.onKeyEvent(event, keysPressed);
  }
}

class Obj extends SpriteComponent with CollisionCallbacks {
  int timer = 0;
  int img = 1;
  String name = "";

  random(min, max) {
    var r = Random();

    return min + r.nextInt(max - min);
  }

  animation(time, spritelimit, name) async {
    timer += 1;
    if (timer > time) {
      timer = 1;
      img += 1;
    }
    if (img > spritelimit) {
      img = 1;
    }
    sprite = await Sprite.load("$name$img.png");
  }
}

class Bg extends SpriteComponent {
  move(dt, speed, limit, posy) {
    y += speed * dt; //Pega posicao eixo y adiciona 1
    if (y >= limit) {
      y = posy;
    }
  }
}

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
    // TODO: implement onCollision
    super.onCollision(intersectionPoints, other);
    if (other is Spider) {
      other.position.y = -100.0;
    } else if (other is Flower) {
      other.position.y = -100.0;
    }
  }
}

class Spider extends Obj {
  move(dt, bee) {
    y += 100 * dt;
    if (y > 950) {
      y = -50;
    }

    if (x < bee.x) {
      x += 2;
    } else if (x > bee.x) {
      x -= 2;
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    // TODO: implement onCollision
    super.onCollision(intersectionPoints, other);
    if (other is Spider) {
      print('teste');
      other.position.y = -100.0;
    }
  }
}

class Flower extends Obj {
  move(dt, speed) {
    y += speed * dt;
    if (y > 900) {
      y = -50;
      x = random(50, 500).toDouble();
    }
  }
}
