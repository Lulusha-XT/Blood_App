import 'package:flutter_application_1/src/features/core/models/blood_request_model.dart';

class MyDonationState {
  List<BloodRequest> bloodRequests;
  final bool hasNext;
  bool isLoading;

  MyDonationState({
    required this.bloodRequests,
    required this.hasNext,
    required this.isLoading,
  });

  factory MyDonationState.initial() {
    return MyDonationState(
      bloodRequests: <BloodRequest>[],
      hasNext: true,
      isLoading: false,
    );
  }

  MyDonationState copyWith({
    List<BloodRequest>? bloodRequests,
    bool? hasNext,
    bool? isLoading,
  }) {
    return MyDonationState(
      bloodRequests: bloodRequests ?? this.bloodRequests,
      hasNext: hasNext ?? this.hasNext,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MyDonationState &&
          runtimeType == other.runtimeType &&
          bloodRequests == other.bloodRequests &&
          hasNext == other.hasNext &&
          isLoading == other.isLoading;

  @override
  int get hashCode =>
      bloodRequests.hashCode ^ hasNext.hashCode ^ isLoading.hashCode;

  @override
  String toString() {
    return 'MyDonationState{BloodRequests: $bloodRequests, hasNext: $hasNext, isLoading: $isLoading}';
  }
}
