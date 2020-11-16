
class PostLoginResponse {
  /* Access token required for accessing protected API endpoints */
  String accessToken = null;
  
/* Access token expiry in seconds */
  int expiresIn = null;
  
/* Refresh token for refreshing the access token once it expires */
  String refreshToken = null;
  
/* Type of access token, will always be `bearer` */
  String tokenType = null;
  
  PostLoginResponse();

  @override
  String toString() {
    return 'PostLoginResponse[accessToken=$accessToken, expiresIn=$expiresIn, refreshToken=$refreshToken, tokenType=$tokenType, ]';
  }

  PostLoginResponse.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    accessToken =
        json['access_token']
    ;
    expiresIn =
        json['expires_in']
    ;
    refreshToken =
        json['refresh_token']
    ;
    tokenType =
        json['token_type']
    ;
  }

  Map<String, dynamic> toJson() {
    return {
      'access_token': accessToken,
      'expires_in': expiresIn,
      'refresh_token': refreshToken,
      'token_type': tokenType
     };
  }

  static List<PostLoginResponse> listFromJson(List<dynamic> json) {
    return json == null ? new List<PostLoginResponse>() : json.map((value) => new PostLoginResponse.fromJson(value)).toList();
  }

  static Map<String, PostLoginResponse> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, PostLoginResponse>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new PostLoginResponse.fromJson(value));
    }
    return map;
  }
}

