enum UserType {
  renter,
  cosplayer;

  String toJson() => name;
  static UserType fromJson(String json) => values.byName(json);
}

class Profile {
  String uid;
  String username;
  String displayName;
  String bannerId;
  String profilePictureId;
  UserType userType;
  int? productCount;
  int followerCount;
  double rating;

  Profile({
    required this.uid,
    required this.username,
    required this.displayName,
    required this.bannerId,
    required this.profilePictureId,
    required this.userType,
    this.productCount,
    required this.followerCount,
    required this.rating
  });

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
      uid: json["uid"] as String,
      username: json["username"] as String,
      displayName: json["displayName"] as String,
      bannerId: json["bannerId"] as String,
      profilePictureId: json["profilePictureId"] as String,
      userType: UserType.fromJson(json["userType"]),
      productCount: json["productCount"] as int,
      followerCount: json["followerCount"] as int,
      rating: json["rating"].toDouble(),
  );
}