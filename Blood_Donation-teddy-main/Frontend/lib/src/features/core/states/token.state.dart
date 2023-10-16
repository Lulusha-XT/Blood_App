import 'package:flutter_application_1/src/features/core/models/token.model.dart';

class TokenValueState {
  List<TokenValue> tokenValue;
  final bool hasNext;
  bool isLoading;

  TokenValueState(
      {required this.hasNext,
      required this.tokenValue,
      required this.isLoading});

  factory TokenValueState.initial() {
    return TokenValueState(
        hasNext: true, tokenValue: <TokenValue>[], isLoading: false);
  }

  TokenValueState copyWith({
    List<TokenValue>? tokenValue,
    bool? hasNext,
    bool? isLoading,
  }) {
    return TokenValueState(
      tokenValue: tokenValue ?? this.tokenValue,
      hasNext: hasNext ?? this.hasNext,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TokenValueState &&
          runtimeType == other.runtimeType &&
          tokenValue == other.tokenValue &&
          hasNext == other.hasNext &&
          isLoading == other.isLoading;

  @override
  int get hashCode =>
      tokenValue.hashCode ^ hasNext.hashCode ^ isLoading.hashCode;

  @override
  String toString() {
    return 'TokenState{BloodRequests: $tokenValue, hasNext: $hasNext, isLoading: $isLoading}';
  }
}
