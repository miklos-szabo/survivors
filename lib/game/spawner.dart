import 'dart:developer' as dev;
import 'dart:math';

import 'package:flame/components.dart';
import 'package:hw_survivors/game/enemy.dart';
import 'package:hw_survivors/main.dart';

class Spawner extends Component with HasGameRef<SurvivorsGame>{
  var random = Random();

  late Timer interval;

  @override
  Future<void> onLoad() async {
    interval = Timer(1,
      onTick: () => spawnEnemy(),
      repeat: true);
    interval.start();
  }

  void spawnEnemy(){
    Vector2 currentPos = gameRef.player.position;

    var x = currentPos.x - 500 + random.nextInt(1000);
    var y = currentPos.y - 250 + random.nextInt(500);
    if((currentPos.x - x).abs() < 250 && (currentPos.y - y).abs() < 200){
      if(random.nextInt(1) > 0){
        y += 200;
      }
      else{
        y -= 200;
      }
    }
    
    add(Enemy(Vector2(x, y)));
  }

  @override
  void update(double dt) {
    interval.update(dt);
  }
}