import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' ;


class ConnectionScreen extends StatefulWidget {
  @override
  _ConnectionScreenState createState() => _ConnectionScreenState();
}


//  ------------------------- STATE  ------------------------
class _ConnectionScreenState extends State<ConnectionScreen> {
  static Socket socket;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('ConnectionScreen -> initState');
    try {
      // socket = io(
      //   // 'http://localhost:4000',
      //   'http://localhost:7000',
      //   <String, dynamic>{
      //     'transports': ['websocket']
      //   },
      // );
      socket = io(
        // 'http://localhost:4000',
        'https://efbb76a00324.ngrok.io',
        // OptionBuilder()
        //   .setTransports(['websocket']) // for Flutter or Dart VM
        //   .disableAutoConnect()  // disable auto-connection
        //   .setExtraHeaders({'foo': 'bar'}) // optional
        //   .build()
        <String, dynamic> {
          'transports':['websocket'],
          'autoConnect': true
        }
      );

      // IO.Socket socket = IO.io('http://localhost:4000', 
      //   IO.OptionBuilder()
      //     .setTransports(['websocket']) // for Flutter or Dart VM
      //     .disableAutoConnect()  // disable auto-connection
      //     .setExtraHeaders({'foo': 'bar'}) // optional
      //     .build()
      // ) ;
      
      // socket.connect();
      socket.onConnect((_) {
      print('connect');
      // socket.emit('msg', 'test');
      });
      // socket.on('event', (data) => print(data));
      socket.onDisconnect((_) => print('disconnect'));
      // socket.on('fromServer', (_) => print(_));
      socket.connect();
      print(socket);

    } catch (err) {
      print('ConnectionScreen -> initState -> err ->');
      print(err);
    }
  }
  @override
  void dispose() {
    // TODO: implement dispose
    socket.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Connect Screen'),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [

            ],
          ),
        ),
      ),
    );
  }
}