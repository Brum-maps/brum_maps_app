import 'dart:math';

import 'package:brummaps/tinder/widget/card_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TinderCard extends StatefulWidget {
  final bool isLiked;
  const TinderCard({Key? key, this.isLiked = false}) : super(key: key);

  @override
  State<TinderCard> createState() => _TinderCardState();
}

class _TinderCardState extends State<TinderCard> {
  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      final size = MediaQuery.of(context).size;

      final provider = Provider.of<CardProvider>(context, listen: false);
      provider.setScreenSize(size);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: (details) {
        Provider.of<CardProvider>(context, listen: false)
            .startPosition(details);
      },
      onPanUpdate: (details) {
        Provider.of<CardProvider>(context, listen: false)
            .updatePosition(details);
      },
      onPanEnd: (details) {
        Provider.of<CardProvider>(context, listen: false).endPosition(details);
      },
      child: LayoutBuilder(builder: (context, constraints) {
        final provider = Provider.of<CardProvider>(context);
        final position = provider.position;
        final milliseconds = provider.isDragging ? 0 : 300;

        final center = constraints.smallest.center(Offset.zero);

        final angle = provider.angle * pi / 180;
        final rotatedMatrix = Matrix4.identity()
          ..translate(center.dx, center.dy)
          ..rotateZ(angle)
          ..translate(-center.dx, -center.dy);

        return AnimatedContainer(
          curve: Curves.easeInOut,
          transform: rotatedMatrix..translate(position.dx, position.dy),
          duration: Duration(milliseconds: milliseconds),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: const DecorationImage(
                  image: AssetImage("assets/images/MAPS.png"),
                  fit: BoxFit.cover,
                )),
          ),
        );
      }),
    );
  }
}
