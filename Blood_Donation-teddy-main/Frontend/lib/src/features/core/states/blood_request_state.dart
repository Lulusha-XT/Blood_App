import 'package:flutter_application_1/src/features/core/models/blood_request_model.dart';

class BloodRequestState {
  List<BloodRequest> bloodRequests;
  final bool hasNext;
  bool isLoading;

  BloodRequestState({
    required this.bloodRequests,
    required this.hasNext,
    required this.isLoading,
  });

  factory BloodRequestState.initial() {
    return BloodRequestState(
      bloodRequests: <BloodRequest>[],
      hasNext: true,
      isLoading: false,
    );
  }

  BloodRequestState copyWith({
    List<BloodRequest>? bloodRequests,
    bool? hasNext,
    bool? isLoading,
  }) {
    return BloodRequestState(
      bloodRequests: bloodRequests ?? this.bloodRequests,
      hasNext: hasNext ?? this.hasNext,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BloodRequestState &&
          runtimeType == other.runtimeType &&
          bloodRequests == other.bloodRequests &&
          hasNext == other.hasNext &&
          isLoading == other.isLoading;

  @override
  int get hashCode =>
      bloodRequests.hashCode ^ hasNext.hashCode ^ isLoading.hashCode;

  @override
  String toString() {
    return 'BloodRequestState{BloodRequests: $bloodRequests, hasNext: $hasNext, isLoading: $isLoading}';
  }
}
