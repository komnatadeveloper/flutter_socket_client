import 'package:flutter/material.dart';

class ChatMessagesList extends StatelessWidget {
  List<String> messages;
  ChatMessagesList({
    this.messages
  });

  Widget buildSingleMessage(int index) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(20.0),
        margin: const EdgeInsets.only(bottom: 20.0, left: 20.0),
        decoration: BoxDecoration(
          color: Colors.deepPurple,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Text(
          messages[index],
          style: TextStyle(color: Colors.white, fontSize: 15.0),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(      
      // controller: scrollController,
      itemCount: messages.length,
      itemBuilder: (BuildContext context, int index) {
        return buildSingleMessage(index);
      },
    );
  }
}