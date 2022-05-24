import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'Scores.dart';

class ScorePage extends StatelessWidget{
  late Scores scores;
  final storageRef = FirebaseStorage.instance.ref();
  late int newScore;

  @override
  Widget build(BuildContext context) {
    newScore = ModalRoute.of(context)!.settings.arguments as int;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text("Last scores: (latest: $newScore)", style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        ),
        Container(
          height: 10,
        ),
        FutureBuilder<List<String>>(
          future: loadScores(),
            builder: (context, snapshot) {
            if (snapshot.hasError){
              return Center(
                child: Text(
                  "Error: ${snapshot.error}"
                  ),
                );
            } else if (snapshot.hasData){
                var list = snapshot.data!;
                return ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, i){
                  return Center(
                      child: Text(list[i], style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),));
              },
                itemCount: list.length,
              );
            } else {
            return Center(
              child: CircularProgressIndicator(),
                );
            }
            },
        ),
      ElevatedButton(onPressed: () { uploadScore(); }, child: Text("Upload new score")),
      Container(
        height: 5,
      ),
      ElevatedButton(onPressed: () { Navigator.of(context).pop(); }, child: Text("Back"))],
    );
  }

  Future<List<String>> loadScores() async  {
    final gsReference = FirebaseStorage.instance.refFromURL("gs://flutter-survivors.appspot.com/scores.txt");
    final Uint8List? data = await gsReference.getData(1000000);
    if(data != null){
      scores = Scores(data);
      return scores.scores.reversed.take(10).toList();
    }
    else{
      log("Failed to download scores!");
      return Future.error("Fail");
    }
  }

  uploadScore() async{
    final scoresRef = storageRef.child("scores.txt");
    scores.addScore(newScore);
    await scoresRef.putData(scores.getAsString());
    log("uploaded!");
  }
}