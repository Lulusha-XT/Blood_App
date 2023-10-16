import 'package:flutter/material.dart';

class ProfileCardsWidget extends StatelessWidget {
  const ProfileCardsWidget({
    Key? key,
    this.cardContent,
    required this.cardHeader,
    required this.icon, // New parameter for the icon
  }) : super(key: key);

  final String cardHeader;
  final String? cardContent;
  final Icon icon; // Icon parameter added

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 80,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              icon, // Use the icon parameter here
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cardHeader,
                    style: const TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 8),
                  if (cardContent != null)
                    Text(
                      cardContent!,
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                      ),
                    ),
                  if (cardContent == null)
                    const Text(
                      '...',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                      ),
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
