import 'package:flutter/material.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:myapp/widgets/text.dart';

class PlaceCard extends StatelessWidget {
  final String name;
  final String intro;

  const PlaceCard(
    {
      Key? key,
      required this.name,
      required this.intro
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Place card
    return Container(
        margin: const EdgeInsets.only(bottom: 28),
        height: 250,
        width: 326,
        decoration: ShapeDecoration(
          color: const Color(0xffD9D9D9),
          shape: SmoothRectangleBorder(
              borderRadius:
                  SmoothBorderRadius(cornerRadius: 20, cornerSmoothing: 1)),
        ),
        child: Stack(fit: StackFit.expand, // Fitiing stack to place card
            children: [
              // Image
              // <--- Image --->

              // Inner shadow overlay
              Opacity(
                opacity: 0.5,
                child: Container(
                  decoration: ShapeDecoration(
                    shape: SmoothRectangleBorder(
                      borderRadius: SmoothBorderRadius(
                          cornerRadius: 20, cornerSmoothing: 1),
                    ),
                    gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Colors.black],
                        stops: [0.5, 1]),
                  ),
                ),
              ),

              // Text section positioned to bottom of card
              Positioned(
                bottom: 18,
                left: 24,
                // Sizing text section
                child: SizedBox(
                  width: 278,
                  // height: 78,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Place name
                      TextCustom(
                        text: name,
                        color: 0xffFFFFFF,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                      const SizedBox(height: 6),
                      // Intro text
                      TextCustom(
                        text: intro,
                        color: 0xffFFFFFF,
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                ),
              ),
            ]));
  }
}
