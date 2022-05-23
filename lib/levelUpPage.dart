import 'package:flutter/material.dart';
import 'package:hw_survivors/main.dart';

Widget LevelUpBuilder(BuildContext buildContext, SurvivorsGame game) {
  return Center(
    child: Container(
      width: 400,
      height: 200,
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Text("Survivor", style: TextStyle(
            color: Colors.black,
            fontSize: 32,
          ),
          ),
          ElevatedButton(
              onPressed: (){ game.restartGame(); },
              child: Text("Play"))
        ],
      ),
    ),
  );
}