class Config {
  static const String appName = "Blood Donation";
  static const String apiURL = "10.0.2.2:8080";
  static const String url = "http://10.0.2.2:8080";
  static const String registerApi = "api/user/register";
  static const String loginApi = "api/user/login";
  static const String getUser = "api/user";
  static const String getTokenValue = "api/user/tokens";
  static const String getUserById = "api/user/";
  static const String updateUserById = "api/user/update";
  static const String imageURL = "http://10.0.2.2:8080/";
  static const String bloodRequest = "api/bloodRequest";
  static const String getBloodRequest = "api/bloodRequest/";
  static const String getSponser = "api/sponser/";
  static const String createSponser = "api/sponser/register";
  static const String createSponserToken = "api/sponserToken/register";
  static const String donation = "api/donate/";
  static const String approvedDonation = "api/donate/doner/approved";
  static const String getDoners = "api/donate/doner/";
  static const String getMyDonation = "api/donate/getApproved";
  static const int pageSize = 10;
}
