import 'package:chat_app/widgets/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chat')
            .orderBy(
              'createAt',
              descending: false,
            )
            .snapshots(),
        builder: (ctx, snapshots) {
          if (snapshots.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshots.hasError) {
            return const Center(
              child: Text('Fetching messages failed!'),
            );
          }
          if (!snapshots.hasData || snapshots.data!.size == 0) {
            return const Center(
              child: Text('No messages yet.'),
            );
          }

          final messages = snapshots.data!.docs;
          final currentUser = FirebaseAuth.instance.currentUser;
          return ListView.builder(
            padding: const EdgeInsets.only(
              bottom: 40,
              left: 13,
              right: 13,
              top: 10,
            ),
            itemCount: messages.length,
            itemBuilder: (ctx, index) {
              final message = messages[index];
              final isMe = message.get('userId') == currentUser?.uid;
              final prevMessage = index == 0 ? null : messages[index - 1];

              final isSameUser =
                  message.get('userId') == prevMessage?.get('userId');

              if (isSameUser) {
                return MessageBubble(
                  isMe: isMe,
                  text: message.get('text'),
                );
              } else {
                return MessageBubble(
                  isMe: isMe,
                  text: message.get('text'),
                  userName: message.get('userName'),
                  userImage: message.get('userImage'),
                );
              }
            },
          );
        });
  }
}
