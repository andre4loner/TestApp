import 'package:flutter/material.dart';

// City model
class City {
  final String code;
  final String name;

  City({
    Key? key,
    required this.code,
    required this.name,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      code: json["code"] as String,
      name: json["name"] as String,
    );
  }
}

// Place model
class Place {
  final String name;
  final String intro;
  final String full;
  final String landing;
  final List<String> alternative;
  final double latitude;
  final double longitude;

  Place({
    Key? key,
    required this.name,
    required this.intro,
    required this.full,
    required this.landing,
    required this.alternative,
    required this.latitude,
    required this.longitude,
  });

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      name: json["name"],
      intro: json["intro"],
      full: json["full"],
      landing: json["landing"],
      alternative: json["alternative"],
      latitude: json["latitude"],
      longitude: json["name"],
    );
  }
}
