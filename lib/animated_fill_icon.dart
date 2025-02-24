// Copyright 2022 Pepe Tiebosch (byme.dev/Jellepepe). All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

class AnimatedFillIcon extends StatelessWidget {
  const AnimatedFillIcon({
    super.key,
    required this.fillValue,
    this.color = Colors.black,
    required this.size,
    required this.fillDirection,
    required this.emptyIcon,
    required this.filledIcon,
  });

  final double fillValue;
  final Color color;
  final double size;
  final TextDirection fillDirection;
  final Widget emptyIcon;
  final Widget filledIcon;

  @override
  Widget build(BuildContext context) {
    Widget child;
    if (fillValue == 1) {
      child = filledIcon;
    } else if (fillValue == 0) {
      child = emptyIcon;
    } else {
      child = Stack(
        children: [
          ShaderMask(
            shaderCallback: (rect) => RadialGradient(
              center: fillDirection == TextDirection.ltr ? Alignment.centerLeft : Alignment.centerRight,
              radius: 1,
              colors: [
                color,
                color,
                Colors.transparent,
              ],
              stops: [
                0,
                fillValue,
                fillValue,
              ],
            ).createShader(rect),
            blendMode: BlendMode.dstIn,
            child: filledIcon,
          ),
          ShaderMask(
            shaderCallback: (rect) => RadialGradient(
              center: fillDirection == TextDirection.ltr ? Alignment.centerLeft : Alignment.centerRight,
              radius: 1,
              colors:  [
                color,
                color,
                Colors.transparent,
              ],
              stops: [
                0,
                fillValue,
                fillValue,
              ],
            ).createShader(rect),
            blendMode: BlendMode.dstOut,
            child: emptyIcon,
          ),
        ],
      );
    }
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: size, maxWidth: size),
      child: IconTheme(
        data: IconThemeData(color: color, size: size),
        child: child,
      ),
    );
  }
}
