import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/features/core/pages/sponser_page/widget/sponser_widget.dart';
import 'package:flutter_application_1/src/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SponserPage extends ConsumerWidget {
  const SponserPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: _mySponserData(context, ref),
    );
  }

  Future<void> _fetchSponsors(WidgetRef ref) async {
    final mySponserViewModel = ref.read(sponserProvider.notifier);
    await mySponserViewModel.getSponser();
  }

  Widget _mySponserData(BuildContext context, WidgetRef ref) {
    // print("I am here");
    final mySponserState = ref.watch(sponserProvider);
    // print(
    //     'Loading: ${mySponserState.isLoading} and HasNext: ${mySponserState.hasNext}');

    // Check if sponsors need to be fetched (based on your conditions)
    if (mySponserState.hasNext && !mySponserState.isLoading) {
      _fetchSponsors(ref);
    }

    if (mySponserState.sponser.isEmpty) {
      if (!mySponserState.hasNext && !mySponserState.isLoading) {
        return const Center(
          child: Text("No data"),
        );
      }
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return SponserCardWidget(
      mySponser: mySponserState.sponser,
    );
  }
}
