import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' ;

// Models
import '../../models/class_model.dart';

// Constants
import '../../constants/constants.dart' as constants;



class ConnectionScreen extends StatefulWidget {
  @override
  _ConnectionScreenState createState() => _ConnectionScreenState();
}


//  ------------------------- STATE  ------------------------
class _ConnectionScreenState extends State<ConnectionScreen> {
  static Socket socket;

  
  var messages = <Message>[];
  void handleSendMessageSendback  ( dynamic sendMessageBack) {
    // messages.add(sendMessageBack['message'] );
    messages.add( new Message(sendMessageBack['message'], true) );
    setState(() {  });
  }
  var messageToSend = '';
  TextEditingController _messageToSendController;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('ConnectionScreen -> initState');
    _messageToSendController = TextEditingController(
      text: ''
    );
    try {
      // socket = io(
      //   // 'http://localhost:4000',
      //   'http://localhost:7000',
      //   <String, dynamic>{
      //     'transports': ['websocket']
      //   },
      // );
      socket = io(
        constants.apiUrl,
        // OptionBuilder()
        //   .setTransports(['websocket']) // for Flutter or Dart VM
        //   .disableAutoConnect()  // disable auto-connection
        //   .setExtraHeaders({'foo': 'bar'}) // optional
        //   .build()
        <String, dynamic> {
          'transports':['websocket'],
          'autoConnect': true,
          'query': {'token': 'THIS IS MY TOKEN FOR AUTHENTICATION'} 
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
      socket.onError((data) {
        print('socket.onError -> data -> ' +  data);
      });
      socket.onConnect((_) {
      print('connect');
      // socket.emit('msg', 'test');
      });
      // socket.on('event', (data) => print(data));
      socket.onDisconnect((_) => print('disconnect'));
      // socket.on('fromServer', (_) => print(_));
      socket.on(
        'send_message_sendback', 
        (sendMessageBack)  {
          print(sendMessageBack);
          handleSendMessageSendback(sendMessageBack);
        }
      );
      socket.on(
        'receive_message', 
        (receivedMessage)  {
          print(receivedMessage);
          // handleSendMessageSendback(receivedMessage);
          messages.add(new Message(receivedMessage, false));
          setState(() {
            
          });
        }
      );
      
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
    _messageToSendController.dispose();
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
        
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode() );
          },
          child: Column(
            children: [
              Expanded(
                child: Container(
                  color: Colors.grey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          // height: MediaQuery.of(context).size.height * 0.5,
                          alignment: Alignment.bottomCenter,
                          
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              if(messages.length > 0) SizedBox(height: 10,),
                              ...messages.map(
                                (messageItem) => Container(
                                  alignment: messageItem.isMyMessage ? Alignment.centerRight : Alignment.centerLeft,
                                  width: double.infinity,
                                  child: Text(messageItem.message, style: TextStyle(color: Colors.black),  ),
                                )
                              ).toList()
                            ],
                          ),
                        ), 
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  children: [
                    TextField(                    
                      controller: _messageToSendController,
                      maxLines: 2,
                      keyboardType: TextInputType.multiline,
                      onChanged: (val) {
                        setState(() {
                        });
                      },
                    ),
                    Container(
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              FocusScope.of(context).requestFocus(new FocusNode() );
                              socket.emit(
                                'send_message',
                                'TEST TEST BUTTON'
                              );
                            }, 
                            child: Text('Test Button')
                          ),
                          ElevatedButton(
                            onPressed: () {
                              FocusScope.of(context).requestFocus(new FocusNode() );
                              if ( _messageToSendController.text.isEmpty) {
                                ScaffoldMessenger.of(context).removeCurrentSnackBar();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    duration: Duration(
                                      milliseconds: 1000
                                    ),
                                    content: Text(
                                     'Please write something to send!',
                                      textAlign: TextAlign.center,
                                    ),
                                    backgroundColor: Colors.redAccent,
                                  ),
                                );
                                return; 
                              }                            
                              socket.emit(
                                'send_message',
                                _messageToSendController.text
                              );
                              setState(() {
                                _messageToSendController.text = '';
                              });                            
                            }, 
                            child: Text('Send Message')
                          ),
                        ],
                      ),
                    ),

                  ],
                )
                
                
              )
            ],
          ),
        )
        
        
      ),
    );
  }
}