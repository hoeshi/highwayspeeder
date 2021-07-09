import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'game/game.dart';
import 'game/game_lib.dart';

void main() {
  var gameEngine = MiniGameEngine();
  var gameView = MiniGameView('Highway Speeder', gameEngine);
  var game = Game(gameView, gameEngine);
  runApp(MyApp(game));
}

class MyApp extends StatelessWidget {
  final Game game;

  MyApp(this.game);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(value: game.gameEngine,
        child: MaterialApp(
            title: game.gameView.title,
            theme: ThemeData(
              primarySwatch: Colors.blue,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            home: game.gameView));
  }
}



