import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'TagValues.dart';
//Todo create by Parth Pitroda

class SocketBloc with ChangeNotifier {
  IOWebSocketChannel channel;
  List<String> _data = new List();
  JsonDecoder _decoder = new JsonDecoder();
  bool _isConnected = false;

  get data => _data;

  get isConnected => _isConnected;

  set data(List<String> data) {
    if (data != _data) {
      _data = data;
      notifyListeners();
    }
  }

  set isConnected(bool data){
    if(data){
      sendDataToSocket('"${TagValues.JOIN_JAM}",{"name":"manthan"}');
    }

    _isConnected = data;
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

  void sendDataToSocket(String data) {
    if (channel != null) {
//       channel.sink.add('{"action":"$action","params":"$params"}');
       channel.sink.add(data);
    }
  }


  void errorHandler(error, StackTrace trace){
    _data.clear();
    print("@@@@@@@@@ socket error"+error);
    isConnected = false;
  }

  void doneHandler(){
    print("@@@@@@@@@ socket closed");
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