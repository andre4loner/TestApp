import 'package:flutter/material.dart';
import 'package:myapp/screens/cities_places_list_page.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:myapp/widgets/text.dart';

class CityCard extends StatelessWidget {
  final String code;
  final String name;

  const CityCard(
    {
      Key? key,
      required this.code,
      required this.name,
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) {
            return CitiesPlacesListPage(
              name: name,
              code: code,
            );
          }
        )
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 24),
        height: 94,
        width: 326,
        decoration: ShapeDecoration(
          color: const Color(0xffD9D9D9),
          shape: SmoothRectangleBorder(
            borderRadius:
              SmoothBorderRadius(
                cornerRadius: 15,
                cornerSmoothing: 0.6,
              ),
          ),
        ),
        child: Center(
          child: TextCustom(
            text: name,
            fontSize: 20,
            color: 0xff000000,
            fontWeight: FontWeight.w500,
          )
        )
      ),
    );
  }
}
