import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/features/core/models/sponser.dart';
import 'package:flutter_application_1/src/features/core/pages/tooken/tooken_page.dart';
import 'package:get/get.dart';

class SponserCardWidget extends StatelessWidget {
  const SponserCardWidget({super.key, required this.mySponser});
  final List<Sponser> mySponser;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height:
          double.infinity, // Set an appropriate height or use double.infinity
      child: ListView.builder(
        itemCount: mySponser.length,
        itemBuilder: (context, index) {
          return SponserListWidget(mySponser: mySponser[index]);
        },
      ),
    );
  }
}

class SponserListWidget extends StatelessWidget {
  const SponserListWidget({super.key, required this.mySponser});
  final Sponser mySponser;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to the TookenPage when the card is tapped
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  TokenValuePage(sponserId: mySponser.sponserId)),
        );
      },
      child: Card(
        elevation: 4, // Add shadow
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0), // Add border radius
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  const Icon(
                    Icons.person,
                    color: Colors.red, // Set text color to red
                  ),
                  const SizedBox(width: 8.0), // Add space here
                  Expanded(
                    child: Text(
                      'SponserName:'.tr,
                      style: const TextStyle(
                          color: Colors.red), // Set text color to red
                    ),
                  ),
                  Text(
                    mySponser.sponserName,
                    style: const TextStyle(
                        color: Colors.red), // Set text color to red
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  const Icon(
                    Icons.email,
                    color: Colors.red, // Set text color to red
                  ),
                  const SizedBox(width: 8.0), // Add space here
                  Expanded(
                    child: Text(
                      'Email:'.tr,
                      style: const TextStyle(
                          color: Colors.red), // Set text color to red
                    ),
                  ),
                  Text(
                    mySponser.email,
                    style: const TextStyle(
                        color: Colors.red), // Set text color to red
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  const Icon(
                    Icons.phone,
                    color: Colors.red, // Set text color to red
                  ),
                  const SizedBox(width: 8.0), // Add space here
                  Expanded(
                    child: Text(
                      'PhoneNumber:'.tr,
                      style: const TextStyle(
                          color: Colors.red), // Set text color to red
                    ),
                  ),
                  Text(
                    mySponser.phoneNo,
                    style: const TextStyle(
                        color: Colors.red), // Set text color to red
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
