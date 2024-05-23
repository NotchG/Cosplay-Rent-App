import 'dart:convert';

import 'package:faker/faker.dart';
import 'package:flutter/services.dart';

class Measurements {
  double Bust = 0;
  double Waist = 0;
  double Hips = 0;

  Measurements(Bust, Waist, Hips);
  Measurements.none(): Bust = 0, Waist = 0, Hips = 0;
}

class MockDatabase {
  List<CatalogueData> mockCatalogues = [];

  void getData() async {
    mockCatalogues = [];
    Faker faker = Faker();
    final String response = await rootBundle.loadString('assets/mockdata/data.json');
    final List<dynamic> data = jsonDecode(response);
    for (dynamic doc in data) {
      CatalogueData catalogueData = CatalogueData.fromJson(doc);
      catalogueData.imgUrl = faker.image.image(keywords: ['cosplay'], random: true);
      mockCatalogues.add(catalogueData);
    }
  }
  CatalogueData? queryByID(String id) {
    for (CatalogueData cat in mockCatalogues) {
      if (cat.uid == id) {
        return cat;
      }
    }
    return null;
  }

  MockDatabase();
}

class CatalogueData {
  String uid = "";
  String imgUrl = "";
  String sellerID = "";
  String itemName = "";
  double itemRating = 0;
  double itemPrice = 0;
  int itemLikes = 0;
  Measurements measurements = Measurements.none();
  String location = "";


  CatalogueData({
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

  CatalogueData.none();

  factory CatalogueData.fromJson(Map<String, dynamic> json) => CatalogueData(
      uid: json["uid"],
      imgUrl: json["imgUrl"],
      sellerID: json["sellerID"],
      itemName: json["itemName"],
      itemRating: (json["itemRating"] as int).toDouble(),
      itemPrice: (json["itemPrice"] as int).toDouble(),
      itemLikes: json["itemLikes"],
      measurements: Measurements(json["Bust"], json["Waist"], json["Hips"]),
      location: json["Location"]
  );
}