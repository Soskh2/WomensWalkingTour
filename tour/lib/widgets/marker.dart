import 'package:widget_to_marker/widget_to_marker.dart';
import 'package:flutter/material.dart';


class MarkerWidget extends StatelessWidget {
  const MarkerWidget({
    super.key,
    required this.index,
  });
  final int index;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image(
          image: const AssetImage(
            "assets/images/marker.jpg",
          ),
          height: 150,
          width: 150,
        ),
        Text(
          "$index",
          style: TextStyle(color: Colors.black),
        )
      ],
    );
  }
}