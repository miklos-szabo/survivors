import 'dart:developer';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hw_survivors/game/bullet.dart';
import 'package:hw_survivors/game/enemy.dart';
import 'package:hw_survivors/game/experience.dart';
import 'package:hw_survivors/game/spawner.dart';
import 'package:hw_survivors/mainMenuPage.dart';

import 'game/player.dart';
import 'game/map.dart';
import 'gameOverPage.dart';
import 'levelUpPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        "/": (context) => overlayBuilder(),
        //"/game": (context) => MyHomePage(title: "asd"),
      },
    );
  }
}

class SurvivorsGame extends FlameGame with HasCollisionDetection, HasKeyboardHandlerComponents {
  late Player player;
  late Spawner spawner;

  @override
  Future<void>? onLoad() {
    player = Player();
    spawner = Spawner();

    camera.viewport = FixedResolutionViewport(Vector2(480, 270));
    add(Map());
    camera.speed = 1;
    camera.followComponent(player, worldBounds: Map.bounds);


    log("Game onload");

    return null;
  }

  void restartGame(){
    log("${children.length}");
    for (var element in children) {
      log(element.runtimeType.toString());
      if(element is Experience || element is Enemy || element is Player || element is Spawner || element is Bullet){
        element.removeFromParent();
        if(element is Player)
          log("Player removed");
      }
    }

    player = Player();
    spawner = Spawner();
    camera.followComponent(player, worldBounds: Map.bounds);
    add(player);
    add(spawner);

    log("restarted");

    if (overlays.isActive('MainMenu')) {
      overlays.remove('MainMenu');
    }
    if (overlays.isActive('GameOver')) {
      overlays.remove('GameOver');
    }

    paused = false;
  }

  void GameOver(){
    paused = true;
    overlays.add('GameOver');
  }

  void BackToMainMenu(){
    overlays.remove('GameOver');
    overlays.add('MainMenu');
  }

  void ShowLevelUpscreen(){
    overlays.add('LevelUp');
  }

  void closeLevelUpScreen(){
    if (overlays.isActive('LevelUp')) {
      overlays.remove('LevelUp');
    }
  }
}

Widget overlayBuilder() {
  return GameWidget<SurvivorsGame>(
    game: SurvivorsGame()..paused = true,
    overlayBuilderMap: const {
      'MainMenu': MainMenuBuilder,
      'LevelUp': LevelUpBuilder,
      'GameOver': GameOverBuilder,
    },
    initialActiveOverlays: const ['MainMenu'],
  );
}

