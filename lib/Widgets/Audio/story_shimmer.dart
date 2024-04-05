import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class StoryShimmer extends StatelessWidget {
  const StoryShimmer();

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: 5, // Number of shimmer items
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Container(
              width: 120, // Adjust according to your design
              height: 180, // Adjust according to your design
              color: Colors.white,
            ),
          );
        },
      ),
    );
  }
}