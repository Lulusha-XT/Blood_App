List<TokenValue> tokenValueFromJson(dynamic str) =>
    List<TokenValue>.from((str).map((x) => TokenValue.fromJson(x)));

class TokenValue {
  String? value;

  bool used;
  String? userId;

  TokenValue({this.value, this.used = false, this.userId});

  factory TokenValue.fromJson(Map<String, dynamic> json) {
    return TokenValue(
        value: json['value'], used: json['used'], userId: json['userId']);
  }

  Map<String, dynamic> toJson() {
    return {'value': value, 'used': used, 'userId': userId};
  }
}
