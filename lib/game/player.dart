
import 'dart:developer' as dev;
import 'dart:math';
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hw_survivors/game/bullet.dart';
import 'package:hw_survivors/main.dart';
import 'package:flame/palette.dart';

import 'enemy.dart';

class Player extends SpriteComponent with HasGameRef<SurvivorsGame>, CollisionCallbacks, KeyboardHandler  {
  static const double speed = 150;
  Vector2 playerVelocity = Vector2.zero();
  Vector2 shootingDirection = Vector2(-1, 0);
  double shotDelay = 0.5;
  int xp = 0;
  int level = 1;
  int score = 0;
  double damageModifier = 1;
  double moveSpeedModifier = 1;
  double projectileSpeedModifier = 1;
  double fireRateModifier = 1;

  late Timer interval;
  late final JoystickComponent moveJoystick;
  late final JoystickComponent fireJoystick;

  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite('player-character.png');
    
    position = gameRef.size / 2;
    width = 20;
    height = 20;
    anchor = Anchor.center;

    add(RectangleHitbox());
    interval = Timer(
      shotDelay / fireRateModifier,
      onTick: () => {
        shootBullet()
      },
      repeat: true,
    );
    interval.start();

    moveJoystick = JoystickComponent(
      knob: CircleComponent(radius: 7, paint: Paint()..color = Colors.blueGrey),
      background: CircleComponent(radius: 20, paint: Paint()..color = Colors.lightBlue),
      margin: const EdgeInsets.only(left: -200, bottom: 140),
    );

    fireJoystick = JoystickComponent(
      knob: CircleComponent(radius: 7, paint: Paint()..color = Colors.blueGrey),
      background: CircleComponent(radius: 20, paint: Paint()..color = Colors.lightBlue),
      margin: const EdgeInsets.only(left: 180, bottom: 140),
    );

    add(moveJoystick);
    add(fireJoystick);
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

    if (!moveJoystick.delta.isZero()) {
      playerVelocity = moveJoystick.delta.normalized();
    }
    else{
      playerVelocity = Vector2.zero();
    }

    if (!fireJoystick.delta.isZero()){
      shootingDirection = fireJoystick.delta.normalized();
    }
    else
      shootingDirection = Vector2(-1, 0);

    final deltaPosition = playerVelocity * (speed * moveSpeedModifier * dt);
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



  void reloadTimer() {
    interval = Timer(
      shotDelay / fireRateModifier,
      onTick: () => {
        shootBullet()
      },
      repeat: true,
    );
    interval.start();
  }

  void incrementXp(){
    xp++;
    if(xp >= 3){
      level++;
      xp = 0;
      gameRef.ShowLevelUpscreen();
    }
  }
}

