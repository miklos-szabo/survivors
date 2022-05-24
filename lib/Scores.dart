import 'dart:typed_data';

class Scores{
  List<String> scores = List.empty();

  Scores(Uint8List fromBytes){
    var s = String.fromCharCodes(fromBytes);
    scores = s.split(';').toList();
  }

  Uint8List getAsString(){
    return Uint8List.fromList(scores.join(';').codeUnits);
  }

  void addScore(int score){
    scores.add(score.toString());
  }
}