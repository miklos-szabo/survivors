import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:hw_survivors/game/player.dart';
import 'package:hw_survivors/main.dart';

class Experience extends SpriteComponent with HasGameRef<SurvivorsGame>, CollisionCallbacks{

  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite('experience.png');

    width = 7;
    height = 7;
    anchor = Anchor.center;

    add(RectangleHitbox());
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if(other is Player){
      other.incrementXp();
      removeFromParent();
    }
  }
}