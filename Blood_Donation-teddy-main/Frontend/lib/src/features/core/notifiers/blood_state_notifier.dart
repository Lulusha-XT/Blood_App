import 'package:flutter_application_1/src/features/core/states/bloodstate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BloodStateNotifier extends StateNotifier<BloodState> {
  BloodStateNotifier()
      : super(BloodState(location: "Location", bloodType: "Blood Type"));

  void setLocation(String location) {
    state = state.copywith(location: location);
  }

  void setBloodType(String bloodType) {
    state = state.copywith(bloodType: bloodType);
  }
}
