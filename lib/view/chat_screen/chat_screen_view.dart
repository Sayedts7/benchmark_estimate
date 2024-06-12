import 'package:benchmark_estimate/utils/constants/colors.dart';
import 'package:flutter/material.dart';


class ChatScreen extends StatelessWidget {
  final List<Map<String, dynamic>> messages = [
    {'isMe': false, 'text': 'Hello!', 'imageUrl': 'https://example.com/user.jpg'},
    {'isMe': true, 'text': 'Hi! How are you?'},
    {'isMe': false, 'text': 'I\'m good, thanks!', 'imageUrl': 'https://example.com/user.jpg'},
    {'isMe': true, 'text': 'Great to hear!'}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(8.0),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                return ChatMessage(
                  isMe: message['isMe'],
                  text: message['text'],
                  imageUrl: message['isMe'] ? null : message['imageUrl'],
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Send a message...',
                suffixIcon: IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    // Implement send message functionality here
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  final bool isMe;
  final String text;
  final String? imageUrl;

  ChatMessage({required this.isMe, required this.text, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: <Widget>[
          if (!isMe) ...[
            if (imageUrl != null)
              CircleAvatar(
                backgroundImage: NetworkImage(imageUrl!),
              ),
            SizedBox(width: 10.0),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment:
              isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                  decoration: BoxDecoration(
                    color: isMe ? primaryColor : Color(0xffF2F4F5),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Text(
                    text,
                    style: TextStyle(
                      color: isMe ? whiteColor : blackColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (isMe) SizedBox(width: 10.0),
        ],
      ),
    );
  }
}
