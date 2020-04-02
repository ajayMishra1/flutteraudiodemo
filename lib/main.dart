import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

typedef void OnError(Exception exception);

void main() {
  runApp(new MaterialApp(home: new ExampleApp()));
}

class ExampleApp extends StatefulWidget {
  @override
  _ExampleAppState createState() => new _ExampleAppState();
}

class _ExampleAppState extends State<ExampleApp> {

  AudioPlayer advancedPlayer;
  AudioCache audioCache;
  AudioPlayer advancedPlayer1;
  AudioCache audioCache1;
  AudioPlayer advancedPlayer2;
  
  AudioCache audioCache2;

  @override
  void initState(){
    super.initState();
    initPlayer();
  }

  void initPlayer(){
    advancedPlayer = new AudioPlayer();
    audioCache = new AudioCache(fixedPlayer: advancedPlayer);

    advancedPlayer1 = new AudioPlayer();
    audioCache1 = new AudioCache(fixedPlayer: advancedPlayer1);

    advancedPlayer2 = new AudioPlayer();
    audioCache2 = new AudioCache(fixedPlayer: advancedPlayer2);

  }

  String localFilePath;

  Widget _tab(List<Widget> children) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: children
              .map((w) => Container(child: w, padding: EdgeInsets.all(6.0)))
              .toList(),
        ),
      ),
    );
  }

  Widget _btn(String txt, VoidCallback onPressed) {
    return ButtonTheme(
        minWidth: 48.0,
        child: RaisedButton(child: Text(txt), onPressed: onPressed));
  }

  Widget localAsset() {
    return _tab([
      Text('Demo for local audio file play'),
      _btn('Play', () {
        playfirst();
      }),
      _btn('loop', () {
        playsecond();
      }),
      _btn('play', ()
      {
        playthird();
      }),
      _btn('play multiple at a time', () {
        playmultiple();
      }),

      _btn('Stop All', () {
        stopall();
      }),
     // slider()
    ]);
  }

  void playfirst(){
    audioCache.play('audio1.mp3');
    advancedPlayer1.stop();
    advancedPlayer2.stop();
  }

  void playsecond(){

    audioCache1.loop('audio.mp3');
    advancedPlayer.stop();
    advancedPlayer2.stop();

  }

  void playthird(){
    audioCache2.play('audio2.mp3');
    advancedPlayer.stop();
    advancedPlayer1.stop();
  }
  void playmultiple(){
    advancedPlayer.stop();
    advancedPlayer1.stop();
    advancedPlayer2.stop();
    audioCache.loop('audio1.mp3');
    audioCache1.loop('audio.mp3');

  }

  void stopall(){
    advancedPlayer.stop();
    advancedPlayer1.stop();
    advancedPlayer2.stop();

  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(text: 'Audio file demo'),
            ],
          ),
          title: Text(''),
        ),
        body: TabBarView(
          children: [localAsset()],
        ),
      ),
    );
  }
}