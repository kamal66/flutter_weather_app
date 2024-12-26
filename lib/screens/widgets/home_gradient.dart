import 'dart:ui';

import 'package:flutter/material.dart';

class HomeGradient extends StatelessWidget {
  const HomeGradient({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: const AlignmentDirectional(1.6, -0.1),
          child: Container(
            height: 310,
            width: 310,
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: Colors.indigo.shade500),
          ),
        ),
        Align(
          alignment: const AlignmentDirectional(-1.6, -0.1),
          child: Container(
            height: 310,
            width: 310,
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: Colors.indigo.shade500),
          ),
        ),
        Align(
          alignment: AlignmentDirectional(1, -1.4),
          child: Container(
            width: MediaQuery.of(context).size.width / 0.8,
            height: 490,
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: Colors.orange.shade300),
          ),
        ),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
          child: Container(
            decoration: const BoxDecoration(color: Colors.transparent),
          ),
        ),
      ],
    );
  }
}
