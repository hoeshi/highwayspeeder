import 'dart:async';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sensors/sensors.dart';

class Game {
  final GameView gameView;
  final GameEngine gameEngine;
  Game(this.gameView, this.gameEngine);

}
abstract class GameView extends StatelessWidget{
  final String title;
  GameView(this.title);

  Widget getStartPageContent(BuildContext context);
  Widget getRunningPageContent(BuildContext context);
  Widget getEndOfGamePageContent(BuildContext context);

  @override
  Widget build(BuildContext context){
    GameEngine game = Provider.of<GameEngine>(context);
    return Scaffold(
      body: _getPageContents(context, game),
    );
  }

  Widget _getPageContents(BuildContext context, GameEngine game) {
    switch (game.gameState) {
      case GameState.waitForStart:
        return getStartPageContent(context);
      case GameState.running:
        return getRunningPageContent(context);
      case GameState.endOfGame:
        return getEndOfGamePageContent(context);
    }
  }

}

enum GameState {
  waitForStart, running, endOfGame
}
abstract class GameEngine extends ChangeNotifier  {
  Timer? _timer;
  int _tickCounter;
  GameState _gameState;
  GameEngine() : _gameState = GameState.waitForStart, _tickCounter = 0;




  void stateChanged(GameState oldState, GameState newState);
  void updatePhysicsEngine(int tickCounter);

  int get tickCounter => _tickCounter;
  GameState get gameState => _gameState;

  set gameState(GameState newState) {
    if (_gameState == newState) return;

    stateChanged(_gameState, newState);
    _gameState = newState;
    if (_gameState == GameState.running) {
      _startGameLoop();
    } else {
      _stopGameLoop();
    }
    updateViews();
  }

  void _startGameLoop() {
    _stopGameLoop();
    _timer?.cancel();
    _timer = new Timer.periodic(Duration(milliseconds: 20), _processTick);
  }

  void _stopGameLoop() {
    _timer?.cancel();
  }

  void updateViews() {
    notifyListeners();
  }

  void _processTick(dynamic notUsed) {
    ++_tickCounter;
    updatePhysicsEngine(_tickCounter);

  }
}

class SizeProviderWidget extends StatefulWidget {
  final Widget child;
  final Function(Size?) onChildSize;

  const SizeProviderWidget(
      {Key? key, required this.onChildSize, required this.child})
      : super(key: key);
  @override
  _SizeProviderWidgetState createState() => _SizeProviderWidgetState();
}

class _SizeProviderWidgetState extends State<SizeProviderWidget> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      widget.onChildSize(context.size);
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }



}

