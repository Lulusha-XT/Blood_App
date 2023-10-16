class ButtonTapedState {
  final bool buttonTappedController;

  ButtonTapedState({
    required this.buttonTappedController,
  });

  factory ButtonTapedState.initial() {
    return ButtonTapedState(buttonTappedController: false);
  }

  ButtonTapedState copyWith({
    bool? buttonTappedController,
  }) {
    return ButtonTapedState(
      buttonTappedController:
          buttonTappedController ?? this.buttonTappedController,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ButtonTapedState &&
          runtimeType == other.runtimeType &&
          buttonTappedController == other.buttonTappedController;

  @override
  int get hashCode => buttonTappedController.hashCode;

  @override
  String toString() {
    return 'ButtonTapedState{buttonTappedController: $buttonTappedController}';
  }
}
