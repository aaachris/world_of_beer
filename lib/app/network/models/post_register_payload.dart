
class PostRegisterPayload {
  /* Password to register with */
  String password = null;
  
/* Username to register with */
  String username = null;
  
  PostRegisterPayload();

  @override
  String toString() {
    return 'PostRegisterPayload[password=$password, username=$username, ]';
  }

  PostRegisterPayload.fromJson(Map<String, dynamic> json) {
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

  static List<PostRegisterPayload> listFromJson(List<dynamic> json) {
    return json == null ? new List<PostRegisterPayload>() : json.map((value) => new PostRegisterPayload.fromJson(value)).toList();
  }

  static Map<String, PostRegisterPayload> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, PostRegisterPayload>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new PostRegisterPayload.fromJson(value));
    }
    return map;
  }
}

