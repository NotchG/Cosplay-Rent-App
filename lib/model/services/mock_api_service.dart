import 'dart:convert';

import 'package:cosplayrentapp/model/data/catalogue_class.dart';
import 'package:cosplayrentapp/model/data/profile_class.dart';
import 'package:flutter/services.dart';

class MockApiService {

  Future<Profile> getProfileById(String? uid) async {
    if (uid == null) throw Exception("UID is empty");
    final jsonFile = await rootBundle.loadString('assets/mockdata/ProfileData.json');

    await Future.delayed(Duration(seconds: 2));

    final jsonData = jsonDecode(jsonFile);

    for (Map<String, dynamic> json in jsonData) {
      Profile temp = Profile.fromJson(json);

      if (temp.uid == uid) {
        return temp;
      }
    }

    throw Exception("User Not Found");
  }

  Future<List<Catalogue>> getCatalogueList() async {
    final jsonFile = await rootBundle.loadString('assets/mockdata/CatalogueData.json');

    await Future.delayed(Duration(seconds: 2));

    final jsonData = jsonDecode(jsonFile);

    List<Catalogue> data = [];

    for (Map<String, dynamic> json in jsonData) {
      Catalogue temp = Catalogue.fromJson(json);
      data.add(temp);
    }

    return data;
  }

  Future<Catalogue> getCatalogueByID(String id) async {
    final jsonFile = await rootBundle.loadString('assets/mockdata/CatalogueData.json');

    await Future.delayed(Duration(seconds: 2));

    final jsonData = jsonDecode(jsonFile);

    for (Map<String, dynamic> json in jsonData) {
      Catalogue temp = Catalogue.fromJson(json);

      if (temp.uid == id) {
        return temp;
      }
    }

    throw Exception("No Catalogue Found.");
  }

}