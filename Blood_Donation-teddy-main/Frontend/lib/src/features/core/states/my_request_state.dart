import 'package:flutter_application_1/src/features/core/models/blood_request_model.dart';

class MyRequestState {
  List<BloodRequest> myRequests;
  final bool hasNext;
  final bool isLoading;

  MyRequestState(
      {required this.myRequests,
      required this.hasNext,
      required this.isLoading});

  factory MyRequestState.initial() {
    return MyRequestState(
        myRequests: <BloodRequest>[], hasNext: true, isLoading: false);
  }

  MyRequestState copywith({
    List<BloodRequest>? myRequest,
    bool? hasNext,
    bool? isLoading,
  }) {
    return MyRequestState(
        myRequests: myRequest ?? myRequests,
        hasNext: hasNext ?? this.hasNext,
        isLoading: isLoading ?? this.isLoading);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MyRequestState &&
          runtimeType == other.runtimeType &&
          myRequests == other.myRequests &&
          hasNext == other.hasNext &&
          isLoading == other.isLoading;

  @override
  int get hashCode =>
      myRequests.hashCode ^ hasNext.hashCode ^ isLoading.hashCode;

  @override
  String toString() {
    return 'BloodRequestState{BloodRequests: $myRequests, hasNext: $hasNext, isLoading: $isLoading}';
  }
}
