import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'game_lib.dart';
import 'package:sensors/sensors.dart';
import 'package:audioplayers/audioplayers.dart';


const alarmAudioPath = "test.mp3";

class MiniGameEngine extends GameEngine {
  Size? _MinigameViewSize;
  double _targetPositionX = 10.0;
  double _targetPositionY = 0.0;


  double get targetPosX => _targetPositionX;
  double get targetPosY => _targetPositionY;


  @override
  void stateChanged(GameState oldState, GameState newState) {
    if (newState == GameState.running) {
      _targetPositionX = 60.0;
      _targetPositionY = 0.0;
    }
  }

  @override
  void updatePhysicsEngine(int tickCounter) {
    _targetPositionY += 2;
    if (_targetPositionY > _MinigameViewSize!.height) {
      _targetPositionY = -20.0;
    }
    updateViews();

  }

  void setGameViewSize(Size? size) {
    if (size != null) _MinigameViewSize = size;
  }
}


class MiniGameView extends GameView {
  final MiniGameEngine gameEngine;
  AudioCache audioCache = AudioCache();
  AudioPlayer advancedPlayer = AudioPlayer();
  MiniGameView(String title, this.gameEngine) : super(title);

  Future<AudioPlayer> playLocalAsset() async {
    AudioCache cache = new AudioCache();
    //At the next line, DO NOT pass the entire reference such as assets/yes.mp3. This will not work.
    //Just pass the file name only.
    return await cache.play("test.mp3");
  }

  @override
  Widget getEndOfGamePageContent(BuildContext context) {
    GameEngine engine = Provider.of<GameEngine>(context);
    return Scaffold (
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("./images/roadrage.jpg"),
                fit: BoxFit.cover)),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            // Stroked text as border
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.yellowAccent,
                      textStyle: TextStyle(
                        fontSize: 30,
                      ),
                      elevation: 2),

                  onPressed: () => { audioCache.play('test.mp3'),


                  },
                  child:
              Text(
                'Start',
                style: TextStyle(
                  color: Colors.black,
                ),
              )),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Text(
                'Highway Speeder',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 90,
                  foreground: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 6
                    ..color = Colors.black,
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Text(
                'Highway Speeder',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 90,
                  color: Colors.yellowAccent[400],

                ),
              ),
            ),
          ],
        ),
      ),
    );

  }

  @override
  Widget getRunningPageContent(BuildContext context) {


    GameEngine engine = Provider.of<GameEngine>(context);
    return SizeProviderWidget(
      onChildSize: (size) {
        gameEngine.setGameViewSize(size);
      },

      child: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/roadrage.jpg"),
                fit: BoxFit.cover)),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            // Stroked text as border
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.yellowAccent,
                      textStyle: TextStyle(
                        fontSize: 30,
                      ),
                      elevation: 2),

                  onPressed: () => {
                    }, child:
              Text(
                'End',
                style: TextStyle(
                  color: Colors.black,
                ),
              )),
            ),
            Positioned(
                child: Image.asset(
                    "images/racecar.jpg",
                    width: 175,
                    height: 150,
                    fit: BoxFit.fill
                )
            ),
            Positioned(
              top: gameEngine.targetPosY,
              left: gameEngine.targetPosX,
                child: Image.asset(
                    "images/car4.png",
                    width: 150,
                    height: 150,

                ),
            ),

            Positioned(
              top: gameEngine.targetPosY + 200,
              right: gameEngine.targetPosX,
              child: Image.asset(
                "images/car4.png",
                width: 150,
                height: 150,

              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget getStartPageContent(BuildContext context) {
    GameEngine engine = Provider.of<GameEngine>(context);
    return Scaffold (
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/roadrage.jpg"),
                fit: BoxFit.cover)),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            // Stroked text as border
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.yellowAccent,
                      textStyle: TextStyle(
                        fontSize: 30,
                      ),
                      elevation: 2),

                  onPressed: () => { audioCache.play('test.mp3'),
                    }, child:
              Text(
                'Start',
                style: TextStyle(
                  color: Colors.black,
                ),
              )),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Text(
                'Highway Speeder',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 90,
                  foreground: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 6
                    ..color = Colors.black,
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Text(
                'Highway Speeder',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 90,
                  color: Colors.yellowAccent[400],

                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}