import 'dart:developer';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:hw_survivors/game/enemy.dart';
import 'package:hw_survivors/main.dart';

class Bullet extends SpriteComponent with HasGameRef<SurvivorsGame>, CollisionCallbacks{
  var damage = 3;
  var velocity = Vector2.zero();
  static double speed = 300;

  late Timer countdown;

  Bullet(Vector2 direction){
    if(direction.x == 0 && direction.y == 0){
      velocity = Vector2(-1, 0);
    }
    else{
      velocity = Vector2(direction.x, direction.y);
    }
  }

  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite('projectile.png');

    x = gameRef.player.position.x;
    y = gameRef.player.position.y;
    width = 8;
    height = 8;
    anchor = Anchor.center;

    add(RectangleHitbox());

    countdown = Timer(3, onTick: () => removeFromParent(), repeat: false);
  }

  void move(Vector2 delta) {
    position.add(delta);
  }

  void update(double dt) {
    super.update(dt);
    countdown.update(dt);
    final deltaPosition = velocity * (speed * dt);
    position.add(deltaPosition);
  }
}