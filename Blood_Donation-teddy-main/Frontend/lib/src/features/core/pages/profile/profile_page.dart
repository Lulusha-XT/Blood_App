import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/constants/colors.dart';
import 'package:flutter_application_1/src/features/core/pages/profile/widget/profile_widget.dart';
import 'package:flutter_application_1/src/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Icon(color: cPrimaryColor, Icons.arrow_back_ios_new),
          ),
        ),
        title: Text(
          "Profile",
          style: const TextStyle(
            fontSize: 16,
            color: cPrimaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [],
      ),
      backgroundColor: Colors.red,
      body: _userData(context),
    );
  }

  Widget _userData(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        final user = ref.watch(userProvider);
        if (user.userId == null) {
          // fetch user data
          ref.read(userProvider.notifier).getUser();
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          // show user profile page
          return ProfileWidget(user: user);
        }
      },
    );
  }
}
