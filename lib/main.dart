import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/cupertino.dart';

void main() {
  runApp(GameWidget(game: BeeHoney()));
}

class BeeHoney extends FlameGame {
  // SpriteComponent -> Definir Posição Cor tipo imagem tamanho
  Bg bg = Bg();
  Bg bg2 = Bg();
  SpriteComponent bee = SpriteComponent();
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
    super.update(dt);
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
