import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../models.dart';
import '../screens/cities_places_list_page.dart';
import '../widgets/city_card.dart';
import '../widgets/text.dart';
import '../widgets/button.dart';



class CitiesListPage extends StatelessWidget {
  final Map userCred;

  CitiesListPage({Key? key, required this.userCred}) : super(key: key);

  // Fetching list of cities
  Future<List<City>> fetchCities() async {
    final token = userCred["access_token"];
    Response res =
        await post(
          Uri.parse('http://10.32.3.17:5000/rest/cities'),
          headers: {
            "Content-Type": "application/json",
            'Authorization': 'Bearer $token',
          },
        );

    debugPrint(jsonDecode(res.statusCode.toString()));
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);

      List<City> cities = body.map((dynamic item) => City.fromJson(item))
        .toList();

      return cities;
    } else {
      throw "Couldn't get cities";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(vertical: 60.0, horizontal: 24.0),
      child: Column(children: [
        Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          // Log out button
          Button(
            child: const TextCustom(
              text: "Log out",
              fontWeight: FontWeight.w600,
            ),
            onPressed: () => {},
            height: 35,
            width: 88,
          ),
        ]),
        SizedBox(height: 54),

        // City name
        TextCustom(
            text: "Choose a city",
            fontSize: 16,
            color: 0xff000000,
            fontWeight: FontWeight.w500),
        const SizedBox(height: 16),

        // City card
        Expanded(
          child: FutureBuilder(
            future: fetchCities(),
            builder: (BuildContext context, AsyncSnapshot<List<City>> snapshot) {
              if (snapshot.hasData) {
                List<City>? cities = snapshot.data;

                return ListView(
                  children: cities!.map((City city) =>
                    InkWell(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => CitiesPlacesListPage(code: city.code, name:city.name),
                        )
                      ),
                      child: CityCard(code: city.code, name: city.name)
                    ),
                  ).toList(),
                );
              } else {
                throw "Couldn't fetch data.";
              }
            }
          ),
        )
      ]),
    ));
  }
}
