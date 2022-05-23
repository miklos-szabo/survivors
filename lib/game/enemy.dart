import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:hw_survivors/game/bullet.dart';
import 'package:hw_survivors/game/experience.dart';
import 'package:hw_survivors/game/player.dart';
import 'package:hw_survivors/main.dart';

class Enemy extends SpriteComponent with HasGameRef<SurvivorsGame>, CollisionCallbacks{
  int health = 5;
  int speed = 100;
  late Vector2 pos;

  Enemy(Vector2 coords){
    pos = coords;
  }

  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite('enemy.png');

    position = pos;
    width = 15;
    height = 15;
    anchor = Anchor.center;

    add(RectangleHitbox());
  }

  @override
  void onCollision(Set<Vector2> points, PositionComponent other) {
    super.onCollision(points, other);
    if (other is Bullet) {
      other.removeFromParent();
      health -= other.damage;
      if(health <= 0) {
        removeFromParent();
        gameRef.player.score++;
        Experience()
          ..position = position
          ..addToParent(gameRef);
      }
    }
  }

  @override
  void update(double dt) {
    var followVector = (gameRef.player.position - position).normalized();
    position.add(followVector * (speed * dt));
  }
}