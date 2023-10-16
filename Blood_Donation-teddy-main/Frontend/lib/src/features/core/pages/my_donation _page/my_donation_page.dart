import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/features/core/pages/my_donation%20_page/widget/my_donation_widget.dart';
import 'package:flutter_application_1/src/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyDonationPage extends ConsumerWidget {
  const MyDonationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: _bloodRequestData(context, ref),
    );
  }

  Widget _bloodRequestData(BuildContext context, WidgetRef ref) {
    final myDonationViewModel = ref.read(myDonationProvider.notifier);
    final myDonationState = ref.watch(myDonationProvider);
    if (myDonationState.hasNext && !myDonationState.isLoading) {
      myDonationViewModel.getMyDonation();
    }
    if (myDonationState.bloodRequests.isEmpty) {
      if (!myDonationState.hasNext && !myDonationState.isLoading) {
        return const Center(
          child: Text("No Data"),
        );
      }
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return MyDonationWidget(
      bloodRequest: myDonationState.bloodRequests,
    );
  }
}
