import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerContainer extends StatelessWidget {
  final double width;
  final double height;
  const ShimmerContainer(
      {super.key, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Shimmer.fromColors(
        baseColor: const Color(0XFFDDDDDD),
        highlightColor: const Color(0XFFAAAAAA).withOpacity(0.5),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.grey,
          ),
          height: height,
        ),
      ),
    );
  }
}
