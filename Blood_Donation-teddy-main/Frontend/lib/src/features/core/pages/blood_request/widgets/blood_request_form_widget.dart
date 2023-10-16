import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/common_widgets/circularProgressBar/circular_progress_widget.dart';
import 'package:flutter_application_1/src/constants/colors.dart';
import 'package:flutter_application_1/src/constants/sizes.dart';
import 'package:flutter_application_1/src/constants/text_string.dart';
import 'package:flutter_application_1/src/features/core/controllers/blood_request_controller.dart';
import 'package:flutter_application_1/src/features/core/models/blood_request_model.dart';
import 'package:flutter_application_1/src/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class BloodRequiestFormWidget extends ConsumerWidget {
  const BloodRequiestFormWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controllers = Get.put(BloodRequestControllers());
    final formKey = GlobalKey<FormState>();
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    // Obtain ScaffoldMessenger outside the asynchronous function

    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DropdownButtonFormField<String>(
            value: controllers.defaultValue, // set the default value here
            decoration: InputDecoration(
              label: Text("BloodType".tr),
              prefixIcon: const Icon(Icons.bloodtype),
            ),
            items: <String>['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? value) {
              controllers.bloodType.text = value!;
            },
            validator: (value) => validate(value, "BloodType".tr),
          ),
          const SizedBox(height: cFormHeigth - 20),
          TextFormField(
            controller: controllers.reason,
            decoration: InputDecoration(
              label: Text("Reason".tr),
              prefixIcon: const Icon(Icons.abc_outlined),
            ),
            validator: (value) => validate(value, "Reason".tr),
          ),
          const SizedBox(height: cFormHeigth - 20),
          // set the default value to 'A'

// build the DropdownButtonFormField widget
          const SizedBox(height: cFormHeigth - 20),
          TextFormField(
            controller: controllers.unitRequired,
            decoration: InputDecoration(
              label: Text("UnitRequired".tr),
              prefixIcon: const Icon(Icons.ac_unit),
            ),
            validator: (value) => validate(value, "UnitRequired".tr),
          ),
          const SizedBox(height: cFormHeigth - 20),
          InkWell(
            onTap: () async {
              final selectedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime(DateTime.now().year + 1),
              );

              if (selectedDate != null) {
                // Update the selectedDeadline variable in the controller
                controllers.selectedDeadline.value = selectedDate;

                // Update the text in the TextFormField
                controllers.deadLine.text =
                    DateFormat('yyyy-MM-dd').format(selectedDate);
              }
            },
            child: AbsorbPointer(
              child: TextFormField(
                controller: controllers.deadLine,
                decoration: InputDecoration(
                  labelText: "DeadLine".tr,
                  prefixIcon: const Icon(Icons.dangerous),
                  suffixIcon:
                      const Icon(Icons.calendar_today), // Add a calendar icon
                ),
                validator: (value) => validate(value, "DeadLine".tr),
                readOnly: true, // Prevent manual text input
              ),
            ),
          ),

          const SizedBox(height: cFormHeigth - 20),
          TextFormField(
            controller: controllers.hospital,
            decoration: InputDecoration(
              label: Text("Hospital".tr),
              prefixIcon: const Icon(Icons.local_hospital_outlined),
            ),
            validator: (value) => validate(value, "Hospital".tr),
          ),
          const SizedBox(height: cFormHeigth - 20),
          TextFormField(
            controller: controllers.personInCharge,
            decoration: InputDecoration(
              label: Text("PersonInCharge".tr),
              prefixIcon: const Icon(Icons.person),
            ),
            validator: (value) => validate(value, "PersonInCharge".tr),
          ),
          const SizedBox(height: cFormHeigth - 20),
          TextFormField(
            controller: controllers.contactNumber,
            decoration: InputDecoration(
              label: Text("ContactNumber".tr),
              prefixIcon: const Icon(Icons.contact_emergency),
            ),
            validator: (value) => validate(value, "ContactNumber".tr),
          ),
          const SizedBox(height: cFormHeigth - 20),
          TextFormField(
            controller: controllers.patientName,
            decoration: InputDecoration(
              label: Text("PatientName".tr),
              prefixIcon: const Icon(Icons.local_hospital),
            ),
            validator: (value) => validate(value, "PatientName".tr),
          ),
          const SizedBox(height: cFormHeigth - 20),
          TextFormField(
            controller: controllers.location,
            decoration: InputDecoration(
              label: Text("Location".tr),
              prefixIcon: const Icon(
                Icons.location_on,
              ), // Change the icon to location
            ),
            validator: (value) => validate(value, "Location".tr),
          ),

          const SizedBox(height: cFormHeigth - 10),

          Consumer(
            builder: (context, ref, _) {
              final notifier = ref.read(bloodRequestProvider.notifier);
              final state = ref.watch(bloodRequestProvider);
              return state.isLoading
                  ? const Center(
                      child: DottedCircularProgressIndicatorFb(
                        currentDotColor: cSecondaryColor,
                        defaultDotColor: cPrimaryColor,
                        numDots: 8,
                      ),
                    )
                  : SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            // Show circular progress indicator while creating user
                            // notifier.start();

                            final bloodRequest = BloodRequest(
                              bloodType: controllers.bloodType.text.trim(),
                              reason: controllers.reason.text.trim(),
                              unitRequired: double.parse(
                                controllers.unitRequired.text.trim(),
                              ),
                              deadLine: controllers.deadLine.text.trim(),
                              hospital: controllers.hospital.text.trim(),
                              personInCharge:
                                  controllers.personInCharge.text.trim(),
                              contactNumber:
                                  controllers.contactNumber.text.trim(),
                              patientName: controllers.patientName.text.trim(),
                              location: controllers.location.text.trim(),
                            );
                            try {
                              final success = await notifier
                                  .createBloodRequest(bloodRequest);

                              if (success) {
                                // Show success message
                                ref.invalidate(myRequestsProvider);
                                ref.invalidate(bloodRequestProvider);
                                scaffoldMessenger.showSnackBar(
                                  SnackBar(
                                    backgroundColor: Colors.green,
                                    content: Text(
                                      "Bloodrequestcreatedsuccessfully".tr,
                                    ),
                                  ),
                                );
                                controllers.resetControllers();
                              } else {
                                // Show error message
                                scaffoldMessenger.showSnackBar(
                                  SnackBar(
                                    backgroundColor: Colors.red,
                                    content:
                                        Text("Errorcreatingbloodrequest".tr),
                                  ),
                                );
                              }
                            } catch (e) {
                              if (kDebugMode) {
                                print(e);
                              }
                              // Show error message
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Colors.red,
                                  content: Text("Errorcreatingbloodrequest".tr),
                                ),
                              );
                            }
                          }
                        },
                        child: Text("CreateBloodRequest".tr),
                      ),
                    );
            },
          ),
        ],
      ),
    );
  }

  String? validate(String? value, String inputName) {
    if (value!.isEmpty) {
      return "$inputName is required";
    }
    return null;
  }
}
