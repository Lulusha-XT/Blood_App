import 'package:flutter_application_1/src/features/core/models/user_doner.dart';

class DonationState {
  List<UserDoner> donation;
  bool hasNext;
  bool isLoading;

  DonationState({
    required this.donation,
    required this.hasNext,
    required this.isLoading,
  });

  factory DonationState.initial() {
    return DonationState(
      donation: <UserDoner>[],
      hasNext: true,
      isLoading: false,
    );
  }

  DonationState copyWith({
    List<UserDoner>? donation,
    bool? hasNext,
    bool? isLoading,
  }) {
    return DonationState(
      donation: donation ?? this.donation,
      hasNext: hasNext ?? this.hasNext,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  String toString() {
    return 'DonationState{donation: $donation,hasNext: $hasNext, isLoading: $isLoading}';
  }
}
