import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import 'Socket_bloc.dart';
import 'TagValues.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  AudioPlayer advancedPlayer;
  AudioCache audioCache;
  SocketBloc _socketBloc;

  @override
  void initState() {
    super.initState();
    _socketBloc = new SocketBloc();
    _socketBloc.connect();
    initPlayer();
  }

  void initPlayer() {
    advancedPlayer = new AudioPlayer();
    audioCache = new AudioCache(fixedPlayer: advancedPlayer);
  }

  void playfirst() {
    audioCache.play('audio1.mp3');
  }

  void stop() {
    advancedPlayer.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text(_socketBloc.data.toString()),
            RaisedButton(
                child: Text("Drum"), onPressed:()=> _socketBloc.sendDataToSocket('"${TagValues.PLAY_INSTUMENT}",{"Drum"}')),
            RaisedButton(
                child: Text("Trebble"),  onPressed: ()=>
                _socketBloc.sendDataToSocket('"${TagValues.PLAY_INSTUMENT}",{"Trebble"}')),
            RaisedButton(
                child: Text("Dish"),  onPressed: ()=>
                _socketBloc.sendDataToSocket('"${TagValues.PLAY_INSTUMENT}",{"Dish"}')),


            ButtonTheme(
                minWidth: 48.0,
                child: RaisedButton(
                    child: Text("play"), onPressed: playfirst)),
              ButtonTheme(
                  minWidth: 48.0,
                  child: RaisedButton(child: Text("stop"), onPressed: stop))
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
