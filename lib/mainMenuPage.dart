import 'package:flutter/material.dart';
import 'package:hw_survivors/main.dart';

Widget MainMenuBuilder(BuildContext buildContext, SurvivorsGame game) {
  return Center(
    child: Container(
      width: 480,
      height: 270,
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Text("Survivor", style: TextStyle(
            color: Colors.white,
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
