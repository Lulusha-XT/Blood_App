List<Sponser> sponserFromJson(dynamic str) =>
    List<Sponser>.from((str).map((x) => Sponser.fromJson(x)));

class Sponser {
  String sponserId;
  String sponserName;
  String email;
  String phoneNo;

  Sponser(
      {required this.sponserId,
      required this.sponserName,
      required this.email,
      required this.phoneNo});

  factory Sponser.fromJson(Map<String, dynamic> json) {
    return Sponser(
        sponserId: json['sponserId'],
        sponserName: json['sponserName'],
        email: json['email'],
        phoneNo: json['phoneNo']);
  }

  Map<String, dynamic> toJson() {
    return {
      'sponserId': sponserId,
      'sponserName': sponserName,
      'email': email,
      'phoneNo': phoneNo
    };
  }
}
