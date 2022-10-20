

class User {
  String name;
  String password;
  String email;
  String channelId;
  bool channelStatus;



  User(
      {
        this.name="",
         this.password="",
        this.email="",
        this.channelId="",
        this.channelStatus=false
        });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        name: json['name'],
        password: json['password'],
        email: json['email'],
        channelId: json['channelId'],
        channelStatus: json['channelStatus'],
      );

  }
  Map<String, dynamic> toJson() => {
    "name": name,
    "password": password,
    "email": email,
    "channelId": channelId,
    "channelStatus": channelStatus,
  };
}
