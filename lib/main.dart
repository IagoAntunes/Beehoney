import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(GameWidget(game: BeeHoney()));
}

class BeeHoney extends FlameGame with KeyboardEvents {
  // SpriteComponent -> Definir Posição Cor tipo imagem tamanho
  Bg bg = Bg();
  Bg bg2 = Bg();
  Bee bee = Bee();
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
      ..position = Vector2(0, -900); //

    bee
      ..sprite = await Sprite.load("bee1.png")
      ..size = Vector2.all(50) //---> Define tamanho
      ..position = Vector2(250, 800)
      ..anchor = Anchor.center; // Define ela no ponto central

    add(bee);
    return super.onLoad();
  }

  @override
  void update(double dt) {
    //delta time- independente do nivel de processamento
    bg.move(dt, 100, 900, 0.0);
    bg2.move(dt, 100, 0, -900.0);
    bee.move(dt, 10);
    bee.animation();
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

class Bg extends SpriteComponent {
  move(dt, speed, limit, posy) {
    y += speed * dt; //Pega posicao eixo y adiciona 1
    if (y >= limit) {
      y = posy;
    }
  }
}

class Bee extends SpriteComponent {
  bool right = false;
  bool left = false;
  int timer = 0;
  int img = 1;
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

  animation() async {
    timer += 1;
    if (timer > 8) {
      timer = 1;
      img += 1;
    }
    if (img > 4) {
      img = 1;
    }
    sprite = await Sprite.load("bee$img.png");
  }
}
