import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

var alphabets = [
  'B',
  'C',
  'D',
  'F',
  'G',
  'H',
  'J',
  'K',
  'L',
  'M',
  'N',
  'P',
  'Q',
  'R',
  'S',
  'T',
  'V',
  'W',
  'X',
  'Y',
  'Z'
];
var vowels = "AEIOU";
Future<List<String>> generateWord() async {
  final response = await http.get(Uri.parse(
      "https://retailor11.000webhostapp.com/HangWoman/generateWord.php"));
  // final response = await http.get(
  //     Uri.parse("https://api.api-ninjas.com/v1/randomword"),
  //     headers: {'X-Api-Key': 'RqCWIJq5Rm72NvuQNuFg0A==n4jLcFsseVe05CLB'});
  var data = jsonDecode(response.body);
  return [data["word"], data["meaning"]];
}



String calculateInitDisplay(String word) {
  word = word.toUpperCase();
  var finalString = "";
  word.characters.forEach((element) {
    finalString += vowels.contains(element) ? "$element " : "_ ";
  });
  return finalString.trim();
}

Characters generateOptions(String word, String current, String eliminated) {
  var remaining = "";
  var finalString = "";
  current = current.replaceAll(" ", "");
  for (int i = 0; i < word.length; i++) {
    if (current[i] == "_" && !remaining.contains(word[i])) {
      remaining += word[i];
    }
  }
  var rand = Random();
  for (int i = 0; i < 6; i++) {
    int index = rand.nextInt(21);
    if (finalString.contains(alphabets[index]) ||
        eliminated.contains(alphabets[index]) ||
        current.contains(alphabets[index])) {
      i--;
      continue;
    }
    finalString += alphabets[index];
  }

  var contains = false;
  for (int i = 0; i < finalString.length; i++) {
    if (word.contains(finalString[i])) contains = true;
  }
  int randIndex2;
  if (!contains) {
    var randIndex1 = Random().nextInt(finalString.length);
    if (remaining.length > 1) {
      randIndex2 = Random().nextInt(remaining.length);
    } else {
      randIndex2 = 0;
    }

    finalString = replaceCharAt(finalString, randIndex1, remaining[randIndex2]);
  }
  return finalString.characters;
}

String replaceCharAt(String oldString, int index, String newChar) {
  return oldString.substring(0, index) +
      newChar +
      oldString.substring(index + 1);
}

List<Widget> generateWidgets(Characters characters, Function optionClicked) {
  var finalList = <Widget>[];
  int counter = 0;
  for (int c = 0; c < 2; c++) {
    var row = Row(
      children: [],
    );
    for (int i = 0; i < 3; i++) {
      var alphabet = characters.elementAt(counter++);
      row.children.add(
        Expanded(
          child: GestureDetector(
            onTap: () {
              optionClicked.call(alphabet);
            },
            child: Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: const Color.fromARGB(255, 251, 252, 250),
              ),
              child: Center(
                child: Text(
                  alphabet,
                  style: const TextStyle(fontSize: 26),
                ),
              ),
            ),
          ),
        ),
      );
    }
    finalList.add(row);
    if (c == 0) {
      finalList.add(
        const SizedBox(
          height: 26,
        ),
      );
    }
  }
  return finalList;
}

String reveal(String word, String current, String alphabet) {
  current = current.replaceAll(" ", "");
  for (int i = 0; i < word.length; i++) {
    if (word[i] == alphabet) {
      current = replaceCharAt(current, i, alphabet);
    }
  }
  String newCurrent = "";
  for (int i = 0; i < current.length * 2; i++) {
    newCurrent += i % 2 == 0 ? "${current[(i / 2).floor()]} " : "";
  }
  return newCurrent;
}

String remaining(String word, String current) {
  current = current.replaceAll(" ", "");
  var remainingChar = "";
  for (int i = 0; i < word.length; i++) {
    if (current[i] == "_") {
      remainingChar += word[i];
    }
  }
  Random random = Random();
  var index = random.nextInt(remainingChar.length);
  String toReveal = remainingChar[index];
  return toReveal;
}

showLoaderDialog(BuildContext context,
    {bool isCancellable = true, String title = "Loading..."}) {
  AlertDialog alert = AlertDialog(
    content: Row(
      children: [
        const CircularProgressIndicator(),
        Container(
            margin: const EdgeInsets.only(left: 16),
            child: const Text("Loading...")),
      ],
    ),
  );
  showDialog(
    barrierDismissible: isCancellable,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

showLevelEndDialog(
  BuildContext context,
  int score,
  String word,
  String meaning,
  VoidCallback onNegativeClicked,
  VoidCallback onPositiveClicked, {
  bool won = false,
  int increment = 0,
}) {
  AlertDialog alert = AlertDialog();
  if (won) {
    alert = AlertDialog(
        content: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.all(8),
          child: Text(
            "That's correct!",
            style: TextStyle(fontFamily: 'Rockwell', fontSize: 30),
          ),
        ),
        RichText(
          text: TextSpan(
              text: "$score",
              style: TextStyle(
                  fontFamily: 'Rockwell', fontSize: 30, color: Colors.black),
              children: [
                TextSpan(
                    text: " +$increment",
                    style: TextStyle(
                        fontFamily: 'Rockwell',
                        fontSize: 16,
                        color: Colors.green))
              ]),
        ),
        SizedBox(
          height: 16,
        ),
        RichText(
          text: TextSpan(text: "", children: [
            TextSpan(
                text: "$word",
                style: TextStyle(
                  fontFamily: 'Rockwell',
                  fontSize: 20,
                  color: Colors.black,
                  decoration: TextDecoration.underline,
                  fontWeight: FontWeight.bold,
                )),
            TextSpan(
                text: ": ",
                style: TextStyle(
                  fontFamily: 'Rockwell',
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                )),
            TextSpan(
                text: meaning,
                style: TextStyle(fontSize: 16, color: Colors.grey))
          ]),
        ),
        SizedBox(
          height: 16,
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Expanded(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Text(
                    "Quit",
                    style: TextStyle(
                      fontFamily: 'Rockwell',
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              flex: 1,
            ),
            SizedBox(
              width: 16,
            ),
            Expanded(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Text("Next",
                      style: TextStyle(fontFamily: 'Rockwell', fontSize: 16)),
                ),
              ),
              flex: 1,
            )
          ],
        )
      ],
    ));
  }
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
