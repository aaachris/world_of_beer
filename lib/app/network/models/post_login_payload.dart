
class PostLoginPayload {
  /* Password of user to authenticate as */
  String password = null;
  
/* Username of user to authenticate as */
  String username = null;
  
  PostLoginPayload();

  @override
  String toString() {
    return 'PostLoginPayload[password=$password, username=$username, ]';
  }

  PostLoginPayload.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    password =
        json['password']
    ;
    username =
        json['username']
    ;
  }

  Map<String, dynamic> toJson() {
    return {
      'password': password,
      'username': username
     };
  }

  static List<PostLoginPayload> listFromJson(List<dynamic> json) {
    return json == null ? new List<PostLoginPayload>() : json.map((value) => new PostLoginPayload.fromJson(value)).toList();
  }

  static Map<String, PostLoginPayload> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, PostLoginPayload>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new PostLoginPayload.fromJson(value));
    }
    return map;
  }
}

