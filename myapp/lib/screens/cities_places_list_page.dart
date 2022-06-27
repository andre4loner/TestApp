import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

import '../models.dart';
import '../widgets/place_card.dart';
import '../widgets/place_info_popup.dart';
import '../widgets/button.dart';
import '../widgets/text.dart';


class CitiesPlacesListPage extends StatelessWidget {
  final String code;
  final String name;

  CitiesPlacesListPage(
    {
      Key? key,
      required this.code,
      required this.name
    }) : super(key: key);

  // Fetching place information
  Future<List<Place>> fetchPlaces() async {
    Response res = await post(
      Uri.parse('http://127.0.0.1:5000/rest/places'),
      body: {}
    );

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);

      List<Place> places =
          body.map((dynamic item) => Place.fromJson(item)).toList();

      return places;
    } else {
      throw "Couldn't get places";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 60.0, horizontal: 24.0),
        // ignore: duplicate_ignore
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Back button
                InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    child: const Text("back")),

                // Button
                Button(
                  child: const TextCustom(
                    text: "Log out",
                    fontWeight: FontWeight.w600,
                  ),
                  onPressed: () => {
                    
                  },
                  height: 35,
                  width: 88,
                ),
              ],
            ),

            const SizedBox(height: 24),

            // City name
            TextCustom(
                text: name,
                fontSize: 36,
                color: 0xff0000000,
                fontWeight: FontWeight.w600),

            const SizedBox(height: 16),

            Expanded(
              // child: ListView.builder(
              //   itemCount: places.length,
              //   itemBuilder: (context, index) {
              //     // Place card
              //     final String shortIntro;
              //     if (places[index]["intro"].length > 150) {
              //       shortIntro = places[index]["intro"].substring(0, 150) + "...";
              //     } else {
              //       shortIntro = places[index]["intro"];
              //     }
              //     return PlaceCard (
              //       name: places[index]["name"],
              //       intro: shortIntro
              //     );
              //   },
              // ),
              child: FutureBuilder(
                future: fetchPlaces(),
                builder: (BuildContext context, AsyncSnapshot<List<Place>> snapshot) {
                  if (snapshot.hasData) {
                    List<Place>? places = snapshot.data;

                    return ListView(
                      children: places!.map((Place place) =>
                        InkWell(
                          onTap: () => {
                            showCupertinoModalPopup(
                              context: context,
                              builder: (builder) {
                                return PlaceInfoPopup(
                                  name: place.name,
                                  landing: place.landing,
                                  alt: place.alternative,
                                  desc: place.full,
                                  latitude: place.latitude,
                                  longitude: place.longitude
                                );
                              },
                            ),
                          },
                          child: PlaceCard(name: place.name, intro: place.intro)
                        ),
                      ).toList(),
                    );
                  } else {
                    throw "Couldn't fetch data.";
                  }
                }
              ),
            ),
          ],
        ),
      )
    );
  }
}
