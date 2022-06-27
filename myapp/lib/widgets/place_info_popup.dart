import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../widgets/text.dart';

class PlaceInfoPopup extends StatelessWidget {
  final String name;
  final String landing;
  final List<String> alt;
  final String desc;
  final double latitude;
  final double longitude;

  const PlaceInfoPopup({Key? key, required this.name, required this.landing, required this.alt, required this.desc, required this.latitude, required this.longitude}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPopupSurface(
        child: Container(
      color: Colors.white,
      alignment: Alignment.center,
      width: double.infinity,
      height: 600,
      child: ListView(
        children: [
          // Images,

          SizedBox(height: 24),
          
          // Text,
          TextCustom(
            text: name,
            color: 0xff000000,
            fontSize: 20,
            fontWeight: FontWeight.w600
          ),

          SizedBox(height: 20),

          // Text,
          SizedBox(
            width: 294,
            child: TextCustom(
              text: desc,
              color: 0xff000000,
              fontSize: 10,
              fontWeight: FontWeight.w600,
              textAlign: TextAlign.justify
            ),
          ),

          SizedBox(height: 20),

          TextCustom(
            text: "Approximately 00km from current location.",
            color: 0xff777777,
            fontSize: 10,
            fontWeight: FontWeight.w600,
          ),

          // Distance
        ],
      ),
    ));
  }
}
