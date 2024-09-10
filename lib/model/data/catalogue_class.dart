class Measurements {
  final double bust;
  final double waist;
  final double hips;

  Measurements({
    required this.bust,
    required this.waist,
    required this.hips
  });
}

class Catalogue {
  final String uid;
  final String imgUrl;
  final String sellerID;
  final String itemName;
  final double itemRating;
  final double itemPrice;
  final int itemLikes;
  final Measurements measurements;
  final String location ;


  Catalogue({
    required this.uid,
    required this.imgUrl,
    required this.sellerID,
    required this.itemName,
    required this.itemRating,
    required this.itemPrice,
    required this.itemLikes,
    required this.measurements,
    required this.location
  });

  factory Catalogue.fromJson(Map<String, dynamic> json) => Catalogue(
      uid: '${json["uid"]}',
      imgUrl: json["imgUrl"] as String,
      sellerID: json["sellerID"] as String,
      itemName: json["itemName"] as String,
      itemRating: json["itemRating"].toDouble(),
      itemPrice: json["itemPrice"].toDouble(),
      itemLikes: json["itemLikes"] as int,
      measurements: Measurements(
          bust: json["Bust"].toDouble(),
          waist: json["Waist"].toDouble(),
          hips: json["Hips"].toDouble()
      ),
      location: json["Location"] as String
  );
}