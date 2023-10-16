import 'package:flutter/material.dart';

class VeerfiyToken extends StatelessWidget {
  const VeerfiyToken({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Widget Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Enter your text...',
              ),
            ),
            SizedBox(height: 16), // Adding some vertical spacing
            ElevatedButton(
              onPressed: () {
                // Button onPressed logic
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
