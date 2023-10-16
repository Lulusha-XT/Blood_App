import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/constants/colors.dart';
import 'package:flutter_application_1/src/features/core/models/blood_request_model.dart';
import 'package:flutter_application_1/src/features/core/pages/my_request_page/donteing_user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

class RequestCardWidget extends StatelessWidget {
  const RequestCardWidget({super.key, required this.myRequest});
  final List<BloodRequest> myRequest;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: myRequest.length,
      itemBuilder: (context, index) {
        return RequestListWidget(myRequest: myRequest[index]);
      },
    );
  }
}

class RequestListWidget extends ConsumerWidget {
  const RequestListWidget({super.key, required this.myRequest});
  final BloodRequest myRequest;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          SizedBox(
            width: 600,
            height: 220,
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                  side: const BorderSide(color: cPrimaryColor)),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              myRequest.bloodType,
                              style: const TextStyle(
                                color: cPrimaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                              ),
                            ),
                            Text("Type".tr),
                          ],
                        ),
                        const SizedBox(
                          height: 50,
                          child: VerticalDivider(
                            color: cPrimaryColor,
                            thickness: 1,
                            width: 10,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Text(
                                  'Hospital:      '.tr,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: cPrimaryColor,
                                  ),
                                ),
                                Text(
                                  myRequest.hospital,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: cPrimaryColor,
                                  ),
                                ),
                              ],
                            ),
                            // const SizedBox(height: 8),
                            Row(
                              children: [
                                Text(
                                  'Deadline:     '.tr,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: cPrimaryColor,
                                  ),
                                ),
                                Text(
                                  myRequest.deadLine,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: cPrimaryColor,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  'Contact:      '.tr,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: cPrimaryColor,
                                  ),
                                ),
                                Text(
                                  myRequest.contactNumber,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: cPrimaryColor,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  'RequiredUnit:      '.tr,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: cPrimaryColor,
                                  ),
                                ),
                                Text(
                                  myRequest.unitRequired.toString(),
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: cPrimaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    child: Column(
                      children: [
                        Text(
                          'Completed: ${myRequest.completedState}',
                          style: const TextStyle(color: Colors.green),
                        ),
                        Text('Pendding: ${myRequest.pendingState}'),
                        const SizedBox(height: 10),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UserDetailsScreen(
                                    requestId: myRequest.requestId!),
                              ),
                            );
                          },
                          child: Container(
                            height: 40,
                            width: 70,
                            decoration: BoxDecoration(
                              color: cPrimaryColor,
                              borderRadius: BorderRadius.circular(8),
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
                                'View'.tr,
                                style: const TextStyle(
                                  color: cWhiteColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
