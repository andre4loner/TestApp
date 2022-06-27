// ignore_for_file: file_names

class City {
  final List<String> cities;
  final Object detailed;

  City({required this.cities, required this.detailed});

  factory City.fromJson(Map<String, dynamic> json) {
    var obj = json["areas"];

    return City(
      cities: json["cities"],
      detailed: List<String>.from(obj),
    );
  }
}
