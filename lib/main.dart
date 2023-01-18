import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/cupertino.dart';

void main() {
  runApp(GameWidget(game: BeeHoney()));
}

class BeeHoney extends FlameGame {
  // SpriteComponent -> Definir Posição Cor tipo imagem tamanho
  Bg bg = Bg();
  SpriteComponent bee = SpriteComponent();
  @override
  Future<void>? onLoad() async {
    bg
      ..sprite = await Sprite.load("bg.png")
      ..size.x = 500 // tamanho em X
      ..size.y = 900 //tamanho em Y
      ..position = Vector2(0, 0); // Posicao em X | Y

    add(bg); // Adicione o objeto na tela

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
    bg.move(dt);
    super.update(dt);
  }
}

class Bg extends SpriteComponent {
  move(dt) {
    y += 100 * dt; //Pega posicao eixo y adiciona 1
  }
}
