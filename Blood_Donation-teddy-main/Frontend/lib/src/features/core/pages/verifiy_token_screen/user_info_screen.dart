import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/features/core/models/user_model.dart';

class VerifiydTokenUserInfoScreen extends StatelessWidget {
  const VerifiydTokenUserInfoScreen({
    super.key,
    required this.user,
    required this.tokenCount,
  });
  final User user;
  final int tokenCount;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(user.fullImagePath),
            ),
            SizedBox(height: 16), // Adding some vertical spacing
            Text(
              user.fullName,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8), // Adding some vertical spacing
            Text(
              'Tokens: $tokenCount',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
