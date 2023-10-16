class BloodState {
  final String location;
  final String bloodType;

  BloodState({required this.location, required this.bloodType});

  factory BloodState.initial() {
    return BloodState(location: "Location", bloodType: "Blood Type");
  }

  BloodState copywith({
    String? location,
    String? bloodType,
  }) {
    return BloodState(
        location: location ?? this.location,
        bloodType: bloodType ?? this.bloodType);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BloodState &&
          runtimeType == other.runtimeType &&
          location == other.location &&
          bloodType == other.bloodType;

  @override
  int get hashCode => location.hashCode ^ bloodType.hashCode;

  @override
  String toString() {
    return 'BloodRequestState{BloodRequests:  location: $location, bloodType: $bloodType}';
  }
}
