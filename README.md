# Flutter Socket Client that works in coordinance with Node.js Backend


- Node.js Backend Repo Link -> [Node.js Backend Link](https://github.com/komnatadeveloper/node_for_flutter_socket)



## Getting Started

- Go to [Node.js Backend Link](https://github.com/komnatadeveloper/node_for_flutter_socket) 
- Clone to your computer, open terminal and run
```
npm i
```
and then ->
```
node index.js
```


- On terminal copy the ngrok.io url and update url -> "https://fdb7c61856cd.ngrok.io"  to this new link you pasted from Node.js Terminal on [ConnectionScreen2.dart](https://github.com/komnatadeveloper/flutter_socket_client/blob/master/lib/screens/connection_screen/connection_screen2.dart)
```
_socketIO = SocketIOManager().createSocketIO(
  // "http://localhost:4000", 
  // "http://localhost:3000", 
  // "http://127.0.0.1:3000", 
  "https://fdb7c61856cd.ngrok.io", // <<<<<<<<<<<< YOU WILL UPDATE THIS URL
  "/", 
  // query: "userId=21031", 
  // socketStatusCallback: () {
  //   print('ConnectionScreen2 -> _initSocket -> socketStatusCallback');
  // }
);
```

- Build your App and you will have connected bi-directionally




