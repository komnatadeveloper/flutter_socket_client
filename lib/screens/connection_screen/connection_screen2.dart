import 'package:flutter/material.dart';
import 'dart:convert' as convert;

import 'package:flutter_socket_io/flutter_socket_io.dart';
import 'package:flutter_socket_io/socket_io_manager.dart';
import 'package:flutter_socket_client/widgets/chat_messages/chat_messages_list.dart';


class ConnectionScreen2 extends StatefulWidget {
  @override
  _ConnectionScreen2State createState() => _ConnectionScreen2State();
}

class _ConnectionScreen2State extends State<ConnectionScreen2> {
  SocketIO _socketIO;
  List<String> messages = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('ConnectionScreen2 -> initState FIRED');
    _initSocket();
    
  }
  Future<void> _initSocket () async {
    try {      
      _socketIO = SocketIOManager().createSocketIO(
        // "http://localhost:4000", 
        // "http://localhost:3000", 
        // "http://127.0.0.1:3000", 
        "https://fdb7c61856cd.ngrok.io", 
        "/", 
        // query: "userId=21031", 
        // socketStatusCallback: () {
        //   print('ConnectionScreen2 -> _initSocket -> socketStatusCallback');
        // }
      );
      //call init socket before doing anything
      _socketIO.init();
      //subscribe event
      _socketIO.subscribe("socket_info", () {});
      _socketIO.subscribe(
        "send_message_sendback", 
        ( data ) {
          print('socketIO -> send_message_sendback -> data ->');
          print(data);
          var extractedData = convert.json.decode(data);
          print("data['message'] ->>>" + extractedData['message'].toString());
          messages.add(
            extractedData['message'].toString()
          );
          setState(() {
            
          });
        }
      );
      //connect socket
      _socketIO.connect();
    } catch ( err ) {
      print(err);
    }
  }

  
  
  @override
  void dispose() {
    // TODO: implement dispose
    _socketIO.disconnect();
    _socketIO.destroy();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Connect Screen2'),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height:30),
              FlatButton(
                child: Text('Send Hello Message'),
                onPressed: (){ 
                  _socketIO.sendMessage(
                    'send_message', 
                    convert.json.encode({'message': 'HELLOOO'})                    
                  );
                  print('ConnectionScreen2 -> send Hello Message Button -> FIRED -> time ->' + DateTime.now().toString());
                }, 
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height - 140,
                child:  Container(
                  color: Colors.grey[300],
                  child: ChatMessagesList(
                  messages: messages,
              ),
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}