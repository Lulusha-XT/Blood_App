import 'package:flutter_application_1/src/features/core/states/buttontapd.state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ButtonTapedNotifier extends StateNotifier<ButtonTapedState> {
  ButtonTapedNotifier() : super(ButtonTapedState.initial());

  void setButtonTapped(bool isTapped) {
    state = state.copyWith(buttonTappedController: isTapped);
  }
}
