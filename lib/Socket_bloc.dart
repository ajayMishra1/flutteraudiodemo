import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'TagValues.dart';
//Todo create by Parth Pitroda

class SocketBloc with ChangeNotifier {
  IOWebSocketChannel channel;
  List<String> _getData = new List();
  JsonDecoder _decoder = new JsonDecoder();
  bool _isConnected = false;

  get getData => _getData;

  get isConnected => _isConnected;

  set getData(List<String> data1) {
    if (data1 != _getData) {
      _getData = data1;
      notifyListeners();
    }
  }

  set isConnected(bool connect){
    if(connect){
            print("ajay mishra111");

     // sendDataToSocket('"${TagValues.JOIN_JAM}",{"name":"manthan"}');
     
     sendDataToSocket("'joinjam', {'name': 'Manthan'}'");
    }

    _isConnected = connect;
    notifyListeners();
  }


  void connect() {

    channel = IOWebSocketChannel.connect(TagValues.BaseUrl);

    channel.stream.listen(dataHandler,
        onError: errorHandler,
        onDone: doneHandler,
        cancelOnError: false);
  }

  void dataHandler(data){

    print("@@@@@@@@@"+"received!"+data);

 

//    _data.add(TradeLiveData.fromJson(_decoder.convert(data)[0]));
  }

  void sendDataToSocket(String strsend) {
    if (channel != null) {
//       channel.sink.add('{"action":"$action","params":"$params"}');

      print("ajay mishra");
       channel.sink.add(strsend);
    }
  }

void errorHandler(err){
    print(err.runtimeType.toString());
    WebSocketChannelException ex = err;
    print(ex.message);
        isConnected = false;

  }

  void doneHandler(){
  //  print("@@@@@@@@@ socket closed");
    isConnected = true;
  }

  void _closeChannel() {
    if (channel != null) {
      channel.sink.close();
    }
  }


  Future<bool> _checkInternetConnectivity() async{
    var result = await Connectivity().checkConnectivity();

    if(result== ConnectivityResult.none){
      return false;
    }else if(result== ConnectivityResult.mobile){
      return true;
    }else if(result== ConnectivityResult.wifi){
      return true;
    }
  }

}