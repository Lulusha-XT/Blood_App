import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/features/core/pages/my_request_page/widget/my_request_widget.dart';
import 'package:flutter_application_1/src/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyRequestPage extends ConsumerWidget {
  const MyRequestPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: _myRequestData(context, ref),
    );
  }

  Widget _myRequestData(BuildContext context, WidgetRef ref) {
    final myRequestViewModel = ref.read(myRequestsProvider.notifier);
    final myRequestState = ref.watch(myRequestsProvider);

    if (myRequestState.hasNext && !myRequestState.isLoading) {
      myRequestViewModel.getMyRequests();
    }

    if (myRequestState.myRequests.isEmpty) {
      if (!myRequestState.hasNext && !myRequestState.isLoading) {
        return const Center(
          child: Text("no data"),
        );
      }
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return RequestCardWidget(
      myRequest: myRequestState.myRequests,
    );
  }
}
