import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/features/core/pages/donate_blood_page/widget/request_card_widget.dart';
import 'package:flutter_application_1/src/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DonateBloodPage extends ConsumerWidget {
  const DonateBloodPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: _bloodRequestData(context, ref),
    );
  }

  Widget _bloodRequestData(BuildContext context, WidgetRef ref) {
    final bloodRequestViewModel = ref.read(bloodRequestProvider.notifier);
    final bloodRequestState = ref.watch(bloodRequestProvider);

    if (bloodRequestState.hasNext && !bloodRequestState.isLoading) {
      bloodRequestViewModel.getBloodRequest();
    }
    if (bloodRequestState.bloodRequests.isEmpty) {
      if (!bloodRequestState.hasNext && !bloodRequestState.isLoading) {
        return const Center(
          child: Text("No Data"),
        );
      }
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return RequestCardWidget(
      bloodRequest: bloodRequestState.bloodRequests,
    );
  }
}
