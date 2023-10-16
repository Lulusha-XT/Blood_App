import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/features/core/pages/tooken/widget/tokenValue_widget.dart';
import 'package:flutter_application_1/src/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TokenValuePage extends ConsumerWidget {
  const TokenValuePage({super.key, required this.sponserId});

  final String sponserId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: _mySponserData(context, ref),
    );
  }

  Widget _mySponserData(BuildContext context, WidgetRef ref) {
    final myTokenValueState = ref.watch(tokenValueProvider);
    final myTokenValueViewModel = ref.watch(tokenValueProvider.notifier);

    if (myTokenValueState.hasNext && !myTokenValueState.isLoading) {
      myTokenValueViewModel.getTokenValue();
    }

    if (myTokenValueState.tokenValue.isEmpty) {
      if (!myTokenValueState.hasNext && !myTokenValueState.isLoading) {
        return const Center(
          child: Text("no data"),
        );
      }
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return TokenValueCardWidget(
      myTokenValue: myTokenValueState.tokenValue,
      sponserId: sponserId,
    );
  }
}
