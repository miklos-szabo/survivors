
import 'dart:developer' as dev;
import 'dart:math';
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/services.dart';
import 'package:hw_survivors/game/bullet.dart';
import 'package:hw_survivors/main.dart';
import 'package:flame/palette.dart';

import 'enemy.dart';

class Player extends SpriteComponent with HasGameRef<SurvivorsGame>, CollisionCallbacks, KeyboardHandler  {
  static const double speed = 150;
  final Vector2 playerVelocity = Vector2.zero();
  Vector2 shootingDirection = Vector2(-1, 0);
  double shotDelay = 500;
  int xp = 0;
  int score = 0;

  late Timer interval;

  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite('player-character.png');
    
    position = gameRef.size / 2;
    width = 20;
    height = 20;
    anchor = Anchor.center;

    add(RectangleHitbox());

      interval = Timer(
        0.4,
        onTick: () => {
          shootBullet()
        },
        repeat: true,
      );
      interval.start();
  }

  void move(Vector2 delta) {
    position.add(delta);

  }

  void shootBullet(){
    Bullet(shootingDirection).addToParent(gameRef);
  }

  @override
  void update(double dt) {
    super.update(dt);
    interval.update(dt);
    final deltaPosition = playerVelocity * (speed * dt);
    position.add(deltaPosition);
  }

  @override
  void onCollision(Set<Vector2> points, PositionComponent other) {
    super.onCollision(points, other);
    if(other is Enemy){
      gameRef.GameOver();
    }
  }

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    final isKeyDown = event is RawKeyDownEvent;

    bool handled = false;
    if (event.logicalKey == LogicalKeyboardKey.keyA) {
      playerVelocity.x = isKeyDown ? -1 : 0;
      handled = true;
    } else if (event.logicalKey == LogicalKeyboardKey.keyD) {
      playerVelocity.x = isKeyDown ? 1 : 0;
      handled = true;
    }

    if (event.logicalKey == LogicalKeyboardKey.keyW) {
      playerVelocity.y = isKeyDown ? -1 : 0;
      handled = true;
    } else if (event.logicalKey == LogicalKeyboardKey.keyS) {
      playerVelocity.y = isKeyDown ? 1 : 0;
      handled = true;
    }

    if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
      shootingDirection.x = isKeyDown ? -1 : 0;
      handled = true;
    } else if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
      shootingDirection.x = isKeyDown ? 1 : 0;
      handled = true;
    }

    if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
      shootingDirection.y = isKeyDown ? -1 : 0;
      handled = true;
    } else if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
      shootingDirection.y = isKeyDown ? 1 : 0;
      handled = true;
    }

    if (handled) {
      return false;
    } else {
      return super.onKeyEvent(event, keysPressed);
    }
  }
}

