import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

late User loggedInUser;

class ChatScreen extends StatefulWidget {
  static const String id = 'chat_screen';
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  final messageTextController = TextEditingController();
  String userName = '';
  String messageText = '';


  @override
  void initState() {
    super.initState();

    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if(user != null) {
        loggedInUser = user;
        //_firestore.collection('user_data').get();
        print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('Chat'),
        backgroundColor: Colors.lightBlue[400],
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Row(
            children: [
              const Icon(Icons.arrow_back_rounded),
              Flexible(
                child: CircleAvatar(
                  backgroundColor: Colors.grey[400],
                  child: const Text('NB', style: TextStyle(fontSize: 14, color: Colors.white)),
                ),
              )
            ],
          ),
        ),
        actions: [
          IconButton(
            onPressed: () { },
            icon: const Icon(Icons.more_vert_rounded)
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            MessagesStream(),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 5),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        color: Colors.white,
                      ),
                      child: TextField(
                        onChanged: (value) {
                          messageText = value;
                        },
                        controller: messageTextController,
                        decoration: const InputDecoration(
                          hintText: 'Type a message',
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(30)),
                        color: Colors.lightBlue[400],
                      ),
                      child: IconButton(
                        onPressed: () {
                          messageTextController.clear();
                          if(messageText != '') {
                            _firestore.collection('messages').add({
                              'text' : messageText,
                              'sender' : loggedInUser.email,
                              'timestamp' : DateTime.now(),
                            });
                          }
                        },
                        icon: const Icon(Icons.send_rounded, color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MessagesStream extends StatelessWidget {
  MessagesStream({Key? key}) : super(key: key);

  final _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('messages').orderBy('timestamp').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
                child: CircularProgressIndicator()
            );
          }
          final messages = snapshot.data!.docs.reversed;
          List<MessageBubble> messageBubbles = [];

          for(var message in messages) {
            final messageText = message.get('text');
            final messageSender = message.get('sender');
            final messageTime = message.get('timestamp') as Timestamp;

            final DateTime dateTime = messageTime.toDate();
            final dateString = DateFormat('hh:mm a').format(dateTime);

            final currentUser = loggedInUser.email;

            final messageBubble = MessageBubble(
                messageTime: dateString,
                text: messageText,
                myself: currentUser == messageSender
            );
            messageBubbles.add(messageBubble);
          }
          return Expanded(
            child: ListView(
              padding: const EdgeInsets.all(7.5),
              reverse: true,
              children: messageBubbles,
            ),
          );
        }
    );
  }
}


class MessageBubble extends StatelessWidget {
  final String messageTime;
  final String text;
  final bool myself;
  const MessageBubble({Key? key, required this.messageTime, required this.text, required this.myself}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: myself ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Material(
            color: myself ? Colors.lightBlue[300]!.withOpacity(0.8) : Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: myself ? const Radius.circular(15) : const Radius.circular(0),
                bottomLeft: const Radius.circular(15),
                topRight: myself ? const Radius.circular(0) : const Radius.circular(15),
                bottomRight: const Radius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Text(text, style: TextStyle(
                  color: myself ? Colors.white : Colors.lightBlue[300]!.withOpacity(0.8)
              )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 1.5),
            child: Text(messageTime.toString(), style: const TextStyle(fontSize: 10, color: Colors.black54)),
          ),
        ],
      ),
    );
  }
}
