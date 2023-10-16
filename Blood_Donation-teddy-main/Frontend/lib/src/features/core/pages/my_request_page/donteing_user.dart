import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/constants/colors.dart';
import 'package:flutter_application_1/src/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

class UserDetailsScreen extends StatelessWidget {
  const UserDetailsScreen({
    super.key,
    required this.requestId,
  });
  final String requestId;
  @override
  Widget build(BuildContext context) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Donating Users Details'),
      ),
      body: _myDonatingUserData(context, scaffoldMessenger),
    );
  }

  Widget _myDonatingUserData(
      BuildContext context, ScaffoldMessengerState scaffoldMessenger) {
    return Consumer(
      builder: (context, ref, _) {
        final donatingUser = ref.watch(donationProvider);
        final donationNotifier = ref.watch(donationProvider.notifier);
        if (donationNotifier.isNull) {
          // Fetching data failed
          return const Center(
            child: Text('Failed to fetch donating users.'),
          );
        } else if (donatingUser.isEmpty) {
          // Fetching data in progress
          donationNotifier.getDonatingUsers(requestId);
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          // Show user profile page
          return ListView.builder(
            itemCount: donatingUser.length,
            itemBuilder: (context, index) {
              final donatUser = donatingUser[index];
              return Card(
                child: ListTile(
                  title: Text('User Name: ${donatUser.donor.fullName}'),
                  subtitle: Text('Status: ${donatUser.status}'),
                  trailing: donatUser.status == "Completed"
                      ? Container(
                          height: 40,
                          width: 80,
                          padding: const EdgeInsets.all(4.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: cPrimaryColor.withOpacity(0.5),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              'Completed'.tr,
                              style: const TextStyle(color: cWhiteColor),
                            ),
                          ),
                        )
                      : Container(
                          height: 40,
                          width: 80,
                          padding: const EdgeInsets.all(4.0),
                          decoration: BoxDecoration(
                            color: cPrimaryColor,
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: GestureDetector(
                            onTap: () async {
                              final approved = await ref
                                  .read(donationProvider.notifier)
                                  .approvedUserDoners(
                                    donatUser.donationId,
                                    donatUser.donor.userId!,
                                    requestId,
                                  );
                              if (approved) {
                                ref.invalidate(myRequestsProvider);
                                scaffoldMessenger.showSnackBar(
                                  SnackBar(
                                    backgroundColor: Colors.green,
                                    content: Text(
                                      "userisapprovedsuccessfully".tr,
                                    ),
                                  ),
                                );
                              } else {
                                scaffoldMessenger.showSnackBar(
                                  SnackBar(
                                    backgroundColor: Colors.green,
                                    content: Text(
                                      "userapprovalfailed".tr,
                                    ),
                                  ),
                                );
                              }
                            },
                            child: const Center(
                              child: Text(
                                'Approve',
                                style: TextStyle(color: cWhiteColor),
                              ),
                            ),
                          ),
                        ),
                ),
              );
            },
          );
        }
      },
    );
  }
}
