import 'package:dash/models/message.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<Message> messages = [
    Message(
      text: "Hello, how are you doing today",
      date: DateTime.now().subtract(const Duration(minutes: 1)),
      isSentByMe: false,
    ),
    Message(
      text: "Im fine, thank you",
      date: DateTime.now().subtract(const Duration(minutes: 1)),
      isSentByMe: true,
    ),
    Message(
      text: "how can i help you",
      date: DateTime.now().subtract(const Duration(minutes: 2)),
      isSentByMe: false,
    ),
    Message(
      text: "i have some issues with my wallet",
      date: DateTime.now().subtract(const Duration(minutes: 2)),
      isSentByMe: true,
    ),
    Message(
      text: "today is a good day",
      date: DateTime.now().subtract(const Duration(hours: 2)),
      isSentByMe: true,
    ),
    Message(
      text: "yes sure every thing is fine",
      date: DateTime.now().subtract(const Duration(hours: 2)),
      isSentByMe: false,
    ),
    Message(
      text: "sometimes i wonder about how things will end up be",
      date: DateTime.now().subtract(const Duration(days: 1, minutes: 3)),
      isSentByMe: false,
    ),
    Message(
      text: "yes totally agree with you",
      date: DateTime.now().subtract(const Duration(days: 1, minutes: 4)),
      isSentByMe: true,
    ),
    Message(
      text: "sometimes i wonder about how things will end up be",
      date: DateTime.now().subtract(const Duration(days: 2, minutes: 3)),
      isSentByMe: false,
    ),
    Message(
      text: "yes totally agree with you",
      date: DateTime.now().subtract(const Duration(days: 2, minutes: 4)),
      isSentByMe: true,
    ),
    Message(
      text: "sometimes i wonder about how things will end up be",
      date: DateTime.now().subtract(const Duration(days: 3, minutes: 3)),
      isSentByMe: false,
    ),
    Message(
      text: "yes totally agree with you",
      date: DateTime.now().subtract(const Duration(days: 3, minutes: 4)),
      isSentByMe: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat Application"),
        backgroundColor: Colors.blue.shade800,
      ),
      body: Column(
        children: [
          Expanded(
            child: GroupedListView<Message, DateTime>(
              padding: const EdgeInsets.all(8),
              elements: messages,
              reverse: true,
              order: GroupedListOrder.DESC,
              useStickyGroupSeparators: true,
              floatingHeader: true,
              groupBy: (message) => DateTime(
                  message.date.year, message.date.month, message.date.day),
              groupHeaderBuilder: (Message message) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: SizedBox(
                  height: 40,
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(4)),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          DateFormat('MMMM d, yyyy').format(message.date),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              itemBuilder: (context, Message message) => Align(
                alignment: message.isSentByMe
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width *
                        0.75, // Limit bubble width
                  ),
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: message.isSentByMe
                        ? Colors.blue.shade900
                        : Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(12),
                      topRight: const Radius.circular(12),
                      bottomLeft: message.isSentByMe
                          ? const Radius.circular(12)
                          : const Radius.circular(0),
                      bottomRight: message.isSentByMe
                          ? const Radius.circular(0)
                          : const Radius.circular(12),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Text(
                    message.text,
                    style: TextStyle(
                      color: message.isSentByMe
                          ? Colors.white
                          : Colors.blue.shade900,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Row(
              children: [
                const Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 16),
                      hintText: "Type your message...",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    // Handle submit action
                  },
                  icon: const Icon(Icons.send),
                  color: Colors.blue.shade900,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
