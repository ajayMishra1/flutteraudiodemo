import 'dart:async';
import 'dart:convert';
import 'dart:ffi';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:adhara_socket_io/adhara_socket_io.dart';

import 'Socket_bloc.dart';
import 'TagValues.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Dynamic audio demo'),
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
    AudioPlayer advancedPlayer1;
  AudioCache audioCache1;
    AudioPlayer advancedPlayer2;
  AudioCache audioCache2;
    AudioPlayer advancedPlayer3;
  AudioCache audioCache3;
    AudioPlayer advancedPlayer4;
  AudioCache audioCache4;
    AudioPlayer advancedPlayer5;
  AudioCache audioCache5;
    AudioPlayer advancedPlayer6;
  AudioCache audioCache6;
    AudioPlayer advancedPlayer7;
  AudioCache audioCache7;
    AudioPlayer advancedPlayer8;
  AudioCache audioCache8;
    AudioPlayer advancedPlayer9;
  AudioCache audioCache9;
  SocketBloc _socketBloc;
  List<String> _totalAudioCounts = List<String>();


  double _value = 1.0;
  List<String> _numberOfUsers = ['1','2','3','4','5','10', '20', '30', '40','50', '60', '70', '80', '90', '100'];
List<String> _firstPlayerUsers = ['0','1','2','3','4','5','10','15', '20','25', '30','35', '40','45','50','55', '60','65', '70','75', '80','85', '90','95', '100'];

String _firstSelected ;
    String   _secondSelected ;
  String _thirdSelected;
      String _userSelected ;
   String URI = "https://jamunity.oneclickitmarketing.co.in";

  List<String> toPrint = ["trying to connect"];
  SocketIOManager manager;
  Map<String, SocketIO> sockets = {};
  Map<String, bool> _isProbablyConnected = {};

  @override
  void initState() {
    super.initState();
    // _socketBloc = new SocketBloc();
    // _socketBloc.connect();z
    initPlayer();
    manager = SocketIOManager();
    initSocket("default");
  }


  initSocket(String identifier) async {
    setState(() => _isProbablyConnected[identifier] = true);
    SocketIO socket = await manager.createInstance(SocketOptions(
      //Socket IO server URI
        URI,

        enableLogging: false,
        transports: [Transports.POLLING] //Enable required transport
    ));
    socket.onConnect((data) {
      pprint("connected...");
      pprint(data);
      socket.emit("joinjam", ["{name: Manthan}"]);
    });
    socket.on("play", (data){   //sample event
      print("play");
      print(data);
      setupSound(data.toString());
    });

    socket.connect();
    sockets[identifier] = socket;
  }

  setupSound(String str){
    if(str == "Bell"){
      audioCache.play("bell.mp3");

    }else if(str == "Drum"){
      audioCache1.play("drum.mp3");

    }else if(str == "Khanjari"){
      audioCache2.play("khanjari.mp3");

    }
  }

  sendMessage(identifier, String strType) {
    if (sockets[identifier] != null) {
      pprint("sending message from '$identifier'...");
      sockets[identifier].emit("playinstrument", [
        strType
      ]);
      pprint("Message emitted from '$identifier'...");
    }
  }
  pprint(data) {
    setState(() {
      if (data is Map) {
        data = json.encode(data);
      }
      print(data);
      toPrint.add(data);
    });
  }

  void initPlayer() {
    advancedPlayer = new AudioPlayer();
    audioCache = new AudioCache(fixedPlayer: advancedPlayer);

   advancedPlayer1 = new AudioPlayer();
    audioCache1 = new AudioCache(fixedPlayer: advancedPlayer1);

       advancedPlayer2 = new AudioPlayer();
    audioCache2 = new AudioCache(fixedPlayer: advancedPlayer2);

       advancedPlayer3 = new AudioPlayer();
    audioCache3 = new AudioCache(fixedPlayer: advancedPlayer3);

       advancedPlayer4 = new AudioPlayer();
    audioCache4 = new AudioCache(fixedPlayer: advancedPlayer4);

       advancedPlayer5 = new AudioPlayer();
    audioCache5 = new AudioCache(fixedPlayer: advancedPlayer5);

       advancedPlayer6 = new AudioPlayer();
    audioCache6 = new AudioCache(fixedPlayer: advancedPlayer6);

       advancedPlayer7 = new AudioPlayer();
    audioCache7 = new AudioCache(fixedPlayer: advancedPlayer7);

       advancedPlayer8 = new AudioPlayer();
    audioCache8 = new AudioCache(fixedPlayer: advancedPlayer8);

       advancedPlayer9 = new AudioPlayer();
    audioCache9 = new AudioCache(fixedPlayer: advancedPlayer9);

    advancedPlayer.setVolume(_value);
    advancedPlayer1.setVolume(_value);

    advancedPlayer2.setVolume(_value);
    advancedPlayer3.setVolume(_value);
    advancedPlayer4.setVolume(_value);
    advancedPlayer5.setVolume(_value);
    advancedPlayer6.setVolume(_value);
    advancedPlayer7.setVolume(_value);
    advancedPlayer8.setVolume(_value);
    advancedPlayer9.setVolume(_value);
    // advancedPlayer.playerId = "ajay1";
    // if(advancedPlayer.playerId == "ajay1"){

    // }
  }

  void playMusic() {

  //  sendMessage("default");
    if(_userSelected == null || _userSelected == "") {
      _userSelected = "0";
    }
    if(_firstSelected == null || _firstSelected == "") {
      _firstSelected = "0";
    }
    if(_secondSelected == null || _secondSelected == "") {
      _secondSelected = "0";
    }
    if(_thirdSelected == null || _thirdSelected == "") {
      _thirdSelected = "0";
    }

      if(int.parse(_userSelected) == 0){
     showToast("Please select user first");
    }else if(int.parse(_firstSelected) == 0 && int.parse(_secondSelected) == 0 && int.parse(_thirdSelected) == 0){
     showToast("Please select at least one instrument quantity first");

    }
    else if((int.parse(_firstSelected) + int.parse(_secondSelected)+ int.parse(_thirdSelected)) > int.parse(_userSelected)){
           showToast("Instrument quantity is high then user quantity");

    }else{

      var totalcount = int.parse(_firstSelected) + int.parse(_secondSelected)+ int.parse(_thirdSelected);
    if(_totalAudioCounts != null){
      if(_totalAudioCounts.length > 0){
        _totalAudioCounts.removeRange(0, _totalAudioCounts.length);
        }
    }
      if(totalcount < 10){
        for(var x = 0; x < int.parse(_firstSelected); x ++){
          _totalAudioCounts.add("bell.mp3");
        }
        for(var x = 0; x < int.parse(_secondSelected); x ++){
          _totalAudioCounts.add("drum.mp3");
        }
        for(var x = 0; x < int.parse(_thirdSelected); x ++){
          _totalAudioCounts.add("khanjari.mp3");
        }

      }else{
        if(_firstSelected != null ) {
          if(_firstSelected.length > 0) {
            if (int.parse(_firstSelected) > 0) {
              var totalCountFirst = 10 * int.parse(_firstSelected) /
                  int.parse(_userSelected);
              var first = totalCountFirst.toInt();
              for (var x = 0; x < first; x ++) {
                _totalAudioCounts.add("bell.mp3");
              }
            }
          }
        }
        if(_secondSelected != null ) {
          if (_secondSelected.length > 0) {
            if (int.parse(_secondSelected) > 0) {
              var totalCountSecond = 10 * int.parse(_secondSelected) /
                  int.parse(_userSelected);
              var first = totalCountSecond.toInt();
              for (var x = 0; x < first; x ++) {
                _totalAudioCounts.add("drum.mp3");
              }
            }
          }
        }
        if(_thirdSelected != null ) {
          if (_thirdSelected.length > 0) {
            if (int.parse(_thirdSelected) > 0) {
              var totalCountThird = 10 * int.parse(_thirdSelected) /
                  int.parse(_userSelected);
              var first = totalCountThird.toInt();
              for (var x = 0; x < first; x ++) {
                _totalAudioCounts.add("khanjari.mp3");
              }
            }
          }
        }
      }
    }


    print(_totalAudioCounts);
  playAudio();
  }

  void playAudio(){
       stop("play");
       for(var x = 0; x < _totalAudioCounts.length; x ++){
        if(x == 0){
          //delayedPrint(_totalAudioCounts[0], 0,audioCache );

           audioCache.loop(_totalAudioCounts[0]);

        }else if(x == 1){
        //  delayedPrint(_totalAudioCounts[1], 100,audioCache1 );

          audioCache1.loop(_totalAudioCounts[1]);

        }else if(x == 2){
         // delayedPrint(_totalAudioCounts[2], 200,audioCache2 );

          audioCache2.loop(_totalAudioCounts[2]);

        }else if(x == 3){
         // delayedPrint(_totalAudioCounts[3], 300,audioCache3 );

          audioCache3.loop(_totalAudioCounts[3]);

        }else if(x == 4){

         // delayedPrint(_totalAudioCounts[4], 400,audioCache4 );

          audioCache4.loop(_totalAudioCounts[4]);

        }else if(x == 5){

         // delayedPrint(_totalAudioCounts[5], 500,audioCache5 );

          audioCache5.loop(_totalAudioCounts[5]);

        }else if(x == 6){

         // delayedPrint(_totalAudioCounts[6], 600,audioCache6 );

          audioCache6.loop(_totalAudioCounts[6]);

        }else if(x == 7){

        //  delayedPrint(_totalAudioCounts[7], 700,audioCache7 );

          audioCache7.loop(_totalAudioCounts[7]);

        }else if(x == 8){

         // delayedPrint(_totalAudioCounts[8], 800,audioCache8 );

          audioCache8.loop(_totalAudioCounts[8]);

        }else if(x == 9){
        //  delayedPrint(_totalAudioCounts[9], 900,audioCache9 );

          audioCache9.loop(_totalAudioCounts[9]);

        }
      }
  }

  Future<void> delayedPrint(String audio, int seconds, AudioCache audioCache) async {
    await Future.delayed(Duration(milliseconds: seconds));
    audioCache.loop(audio);
    ;
  }

  void stop(String comefrom) {

    advancedPlayer.stop();
        advancedPlayer1.stop();

    advancedPlayer2.stop();
    advancedPlayer3.stop();
    advancedPlayer4.stop();
    advancedPlayer5.stop();
    advancedPlayer6.stop();
    advancedPlayer7.stop();
    advancedPlayer8.stop();
    advancedPlayer9.stop();
    if(comefrom == "stop"){
//      _firstSelected = "0";
//      _secondSelected = "0";
//      _thirdSelected = "0";
      _value = 1.0;
    }

  }

  void volumechange(){
    advancedPlayer.setVolume(_value);
    advancedPlayer1.setVolume(_value);

    advancedPlayer2.setVolume(_value);
    advancedPlayer3.setVolume(_value);
    advancedPlayer4.setVolume(_value);
    advancedPlayer5.setVolume(_value);
    advancedPlayer6.setVolume(_value);
    advancedPlayer7.setVolume(_value);
    advancedPlayer8.setVolume(_value);
    advancedPlayer9.setVolume(_value);
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
            SizedBox(height: 50,),

            Row(
              children: <Widget>[

             Expanded(
               child:  RaisedButton(
                   child: Text("Play Bell"), onPressed:(){
                 sendMessage("default","Bell");
               }),
             ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: RaisedButton(
                    child: Text("Play Drum"),  onPressed: (){
                    sendMessage("default","Drum");
                }
                ))
                ,

              ],
            ),

            SizedBox(height: 30,),

            RaisedButton(
                child: Text("Play Khanjari"), onPressed:(){
              sendMessage("default","Khanjari");
            }),


          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

    static void showToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1);
  }
}
