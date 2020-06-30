class User {
  String name;
  String email;
  String imgURL;
  String uid;
  
  User({this.name, this.email, this.imgURL, this.uid});

  User.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        email = json['email'],
        imgURL = json['picture']['data']['url'],
        uid = json['id'];

  Map<String, dynamic> toJson(User user) {
    return <String, dynamic>{
      'name': user.name,
      'email': user.email,
      'img': user.imgURL,
      'uid': user.uid
    };
  }
}
