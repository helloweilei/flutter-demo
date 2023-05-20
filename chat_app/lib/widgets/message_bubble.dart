import 'dart:io';

import 'package:flutter/material.dart';

const bubbleRadius = 8.0;

class MessageBubble extends StatelessWidget {
  const MessageBubble({
    super.key,
    required this.isMe,
    required this.text,
    this.userImage,
    this.userName,
  });

  final bool isMe;
  final String text;
  final String? userName;
  final String? userImage;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final avatar = userImage != null
        ? CircleAvatar(
            radius: 20,
            foregroundImage: NetworkImage(userImage!),
          )
        : const SizedBox(
            width: 40,
          );

    final messageBox = Column(
      crossAxisAlignment:
          isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        if (userName != null)
          Text(
            userName!,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        if (userName != null) const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft:
                  !isMe ? Radius.zero : const Radius.circular(bubbleRadius),
              topRight:
                  !isMe ? const Radius.circular(bubbleRadius) : Radius.zero,
              bottomLeft: const Radius.circular(bubbleRadius),
              bottomRight: const Radius.circular(bubbleRadius),
            ),
            color: !isMe ? colorScheme.primaryContainer : Colors.black26,
          ),
          child: Text(text,
              style: TextStyle(
                color: !isMe
                    ? colorScheme.onPrimaryContainer
                    : colorScheme.onBackground,
              )),
        ),
      ],
    );

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 0,
      ),
      child: Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: isMe
            ? [
                messageBox,
                const SizedBox(width: 6),
                avatar,
              ]
            : [
                avatar,
                const SizedBox(width: 6),
                messageBox,
              ],
      ),
    );
  }
}
