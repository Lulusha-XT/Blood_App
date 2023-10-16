import 'package:flutter_application_1/src/features/core/models/sponser.dart';

class SponserState {
  List<Sponser> sponser;
  final bool hasNext;
  bool isLoading;

  SponserState(
      {required this.hasNext, required this.sponser, required this.isLoading});

  factory SponserState.initial() {
    return SponserState(hasNext: true, sponser: <Sponser>[], isLoading: false);
  }

  SponserState copyWith({
    List<Sponser>? sponser,
    bool? hasNext,
    bool? isLoading,
  }) {
    return SponserState(
      sponser: sponser ?? this.sponser,
      hasNext: hasNext ?? this.hasNext,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SponserState &&
          runtimeType == other.runtimeType &&
          sponser == other.sponser &&
          hasNext == other.hasNext &&
          isLoading == other.isLoading;

  @override
  int get hashCode => sponser.hashCode ^ hasNext.hashCode ^ isLoading.hashCode;

  @override
  String toString() {
    return 'SponserState{BloodRequests: $sponser, hasNext: $hasNext, isLoading: $isLoading}';
  }
}
