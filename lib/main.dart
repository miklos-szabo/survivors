import 'dart:developer';
import 'package:flutter/services.dart';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hw_survivors/ScorePage.dart';
import 'package:hw_survivors/game/bullet.dart';
import 'package:hw_survivors/game/enemy.dart';
import 'package:hw_survivors/game/experience.dart';
import 'package:hw_survivors/game/spawner.dart';
import 'package:hw_survivors/mainMenuPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

import 'game/player.dart';
import 'game/map.dart';
import 'gameOverPage.dart';
import 'levelUpPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
        "/scores": (context) => ChangeNotifierProvider(
            create: (_) => SumScoreState(),
            child: ScorePage(),
        ),
        //"/game": (context) => MyHomePage(title: "asd"),
      },
    );
  }
}

class SurvivorsGame extends FlameGame with HasCollisionDetection, HasKeyboardHandlerComponents, HasDraggables {
  late Player player;
  late Spawner spawner;

  @override
  Future<void>? onLoad() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);

    player = Player();
    spawner = Spawner();

    camera.viewport = FixedResolutionViewport(Vector2(480, 270));
    add(Map());
    camera.speed = 1;
    camera.followComponent(player, worldBounds: Map.bounds);

    return null;
  }

  void restartGame(){
    for (var element in children) {
      if(element is Experience || element is Enemy || element is Player || element is Spawner || element is Bullet){
        element.removeFromParent();
      }
    }

    player = Player();
    spawner = Spawner();
    camera.followComponent(player, worldBounds: Map.bounds);
    add(player);
    add(spawner);

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
    paused = true;
    overlays.add('LevelUp');
  }

  void closeLevelUpScreen(){
    if (overlays.isActive('LevelUp')) {
      overlays.remove('LevelUp');
    }
    paused = false;
  }

  void increaseDamage(){
    player.damageModifier += 0.2;
  }

  void increaseMoveSpeed(){
    player.moveSpeedModifier += 0.2;
  }

  void increaseProjectileSpeed(){
    player.projectileSpeedModifier += 0.2;
  }

  void increaseFireRate(){
    player.fireRateModifier += 0.2;
    player.reloadTimer();
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

