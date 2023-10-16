import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/constants/sizes.dart';
import 'package:flutter_application_1/src/features/core/pages/blood_request/widgets/blood_request_form_widget.dart';

class BloodRequestPage extends StatelessWidget {
  const BloodRequestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(cDefaultSize),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: cDefaultSize - 10),
                Builder(
                  builder: (context) => const BloodRequiestFormWidget(),
                ),
                const SizedBox(height: cDefaultSize - 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
