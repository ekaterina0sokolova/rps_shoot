import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Камень ножницы бумага'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {
  int userChoice = 0;
  int botChoice = 0;
  bool isUserWinner = false;

  // 1 - камень, 2 - ножницы, 3 - бумага
  String _isUserWinner(userOption, botOption) {
    List<List<int>> winList = [[1, 2], [2, 3], [3, 1],];

    // user win
    if (winList.any((list) => list[0] == userOption && list[1] == botOption)) {
      return "Победа!";
    }
    else if (userOption == botOption) {
      return "Ничья!";
    }
    else return "Поражение!";
  }

  int _generateOption() {
    int rand = Random().nextInt(3) + 1;
    return rand;
  }

  String? _parseChoices(int choice) {
    switch (choice) {
      case 1:
        return "Камень";
      case 2:
        return "Ножницы";
      case 3:
        return "Бумага";
    }
  }

  void _showResultDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(_isUserWinner(userChoice, botChoice).toString()),
          content: Text(_parseChoices(userChoice).toString() + " Х " + _parseChoices(botChoice).toString()),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Закрыть'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Камень, ножницы, бумага!!!",
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                OutlinedButton(
                  onPressed: () {
                    userChoice = 3;
                    botChoice = _generateOption();
                    _isUserWinner(3, botChoice);
                    _showResultDialog(context);
                  },
                  child: Text("🌳Бумага"),
                ),
                OutlinedButton(
                  onPressed: () {
                    userChoice = 2;
                    botChoice = _generateOption();
                    _isUserWinner(3, botChoice);
                    _showResultDialog(context);
                  },
                  child: Text("✂️Ножницы"),
                ),
                OutlinedButton(
                  onPressed: () {
                    userChoice = 1;
                    botChoice = _generateOption();
                    _isUserWinner(3, botChoice);
                    _showResultDialog(context);
                  },
                  child: Text("🗿Камень"),
                ),
              ],
            ),

          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
