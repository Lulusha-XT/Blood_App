import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/features/core/pages/chat_screen/chat_screen.dart';
import 'package:flutter_application_1/src/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Online Users',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Consumer(
              builder: (context, ref, _) {
                final onlineUsers =
                    ref.watch(onlineUsersProvider.notifier).state;
                final selectedUser =
                    ref.watch(selectedUserProvider.notifier).state;

                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: onlineUsers.length,
                  itemBuilder: (BuildContext context, int index) {
                    final user = onlineUsers[index];
                    return ListTile(
                      title: Text(user),
                      onTap: () {
                        ref.read(selectedUserProvider.notifier).state = user;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChatScreen(),
                          ),
                        );
                      },
                      tileColor: user == selectedUser ? Colors.grey[300] : null,
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
