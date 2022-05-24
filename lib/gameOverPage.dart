import 'package:flutter/material.dart';
import 'package:hw_survivors/main.dart';

Widget GameOverBuilder(BuildContext buildContext, SurvivorsGame game) {
  return Center(
    child: Container(
      width: 400,
      height: 200,
      color: Colors.orange,
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Text("Game over!", style: TextStyle(
            color: Colors.black,
            fontSize: 60,
          ),
          ),
          Container(
            height: 40,
          ),
          Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: (){ game.restartGame(); },
                      child: Text("Restart")),
                  Container(
                    width: 5,
                  ),
                  ElevatedButton(
                      onPressed: (){ game.restartGame(); },
                      child: Text("High scores"))],
              )
          )


        ],
      ),
    ),
  );
}