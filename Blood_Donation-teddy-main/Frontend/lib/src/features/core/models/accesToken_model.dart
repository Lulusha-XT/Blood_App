List<AccessToken> accessTokenFromJson(dynamic str) =>
    List<AccessToken>.from((str).map((x) => AccessToken.fromJson(x)));

class AccessToken {
  String? sponserId;
  String? tokenOwnerId;
  String? token;
  String? status;

  AccessToken({this.sponserId, this.tokenOwnerId, this.token, this.status});

  factory AccessToken.fromJson(Map<String, dynamic> json) {
    return AccessToken(
      sponserId: json['sponserId'],
      tokenOwnerId: json['tokenOwnerId'],
      token: json['token'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sponserId': sponserId,
      'tokenOwnerId': tokenOwnerId,
      'token': token,
      'status': status
    };
  }
}
