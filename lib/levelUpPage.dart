import 'package:flutter/material.dart';
import 'package:hw_survivors/main.dart';

Widget LevelUpBuilder(BuildContext buildContext, SurvivorsGame game) {
  return Center(
    child: Container(
      width: 400,
      height: 200,
      color: Colors.brown,
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          ElevatedButton(
              onPressed: (){ game.increaseDamage(); game.closeLevelUpScreen();},
              child: const Text("Damage +20%")),
          ElevatedButton(
              onPressed: (){ game.increaseFireRate(); game.closeLevelUpScreen();},
              child: const Text("Fire rate +20%")),
          ElevatedButton(
              onPressed: (){ game.increaseMoveSpeed(); game.closeLevelUpScreen();},
              child: const Text("Move speed +20%")),
          ElevatedButton(
              onPressed: (){ game.increaseProjectileSpeed(); game.closeLevelUpScreen();},
              child: const Text("Projectile speed +20%"))
        ],
      ),
    ),
  );
}