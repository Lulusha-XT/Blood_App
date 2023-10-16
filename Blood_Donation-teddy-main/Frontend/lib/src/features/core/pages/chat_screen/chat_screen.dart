import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/constants/colors.dart';
import 'package:flutter_application_1/src/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatScreen extends ConsumerWidget {
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final socket = ref.watch(socketProvider);
    final currentUser = 'user123'; // Replace with the actual current user ID

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Consumer(
              builder: (context, watch, _) {
                final messages = ref.watch(messagesProvider.notifier).state;
                return ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(messages[index]),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      hintText: 'Type a message',
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    color: cPrimaryColor,
                    Icons.send,
                  ),
                  onPressed: () {
                    final message = _messageController.text.trim();
                    if (message.isNotEmpty) {
                      final selectedUser =
                          ref.read(selectedUserProvider.notifier).state;
                      final data = {
                        'senderId': currentUser,
                        'receiverId': selectedUser,
                        'message': message,
                      };
                      socket.emit('sendMessage', data);

                      // ref.read(messagesProvider.notifier).state = [..message];
                      _messageController.clear();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// class ChatScreen extends StatefulWidget {
//   const ChatScreen({super.key});

//   @override
//   State<ChatScreen> createState() => _ChatScreenState();
// }

// class _ChatScreenState extends State<ChatScreen> {
//   TextEditingController msgInputControllers = TextEditingController();
//   late IO.Socket socket;
//   ChatController chatController = ChatController();
//   @override
//   void initState() {
//     socket = IO.io(
//       Config.url,
//       IO.OptionBuilder()
//           .setTransports(['websocket']) // for Flutter or Dart VM
//           .disableAutoConnect() // disable auto-connection
//           .build(),
//     );
//     socket.connect();
//     setUpSocketListener();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     print(socket.id);
//     return Scaffold(
//       body: Column(
//         children: [
//           Expanded(
//             flex: 9,
//             child: Obx(
//               () => ListView.builder(
//                 itemCount: chatController.chatMessages.length,
//                 itemBuilder: (context, index) {
//                   var currentItem = chatController.chatMessages[index];
//                   return MessageItem(
//                     msg: currentItem.message!,
//                     sendByMe: currentItem.sentByMe == socket.id,
//                   );
//                 },
//               ),
//             ),
//           ),
//           Expanded(
//             child: Container(
//               padding: const EdgeInsets.all(10.0),
//               child: TextField(
//                 style: const TextStyle(color: cDarkColor),
//                 cursorColor: AppColors.purple,
//                 controller: msgInputControllers,
//                 decoration: InputDecoration(
//                   enabledBorder: OutlineInputBorder(
//                     borderSide: const BorderSide(color: cPrimaryColor),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderSide: const BorderSide(color: cPrimaryColor),
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   suffixIcon: Container(
//                     margin: const EdgeInsets.only(right: 10),
//                     decoration: BoxDecoration(
//                       color: cPrimaryColor,
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: IconButton(
//                       onPressed: () {
//                         sendMsg(msgInputControllers.text);
//                         msgInputControllers.text = "";
//                       },
//                       icon: const Icon(
//                         Icons.send,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   setUpSocketListener() {
//     socket.on("message-recive", (data) {
//       print(data);
//       chatController.chatMessages.add(Message.fromJson(data));
//     });
//   }

//   void sendMsg(String text) {
//     var messageJson = {"message": text, "sender": socket.id};
//     socket.emit('meshsage', messageJson);
//     chatController.chatMessages.add(Message.fromJson(messageJson));
//   }
// }
