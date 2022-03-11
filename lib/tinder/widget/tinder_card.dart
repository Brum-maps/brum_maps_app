import 'dart:math';
import 'dart:typed_data';

import 'package:brummaps/tinder/cubit/tinder_cubit.dart';
import 'package:brummaps/tinder/widget/card_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:brummaps/model/model.dart' as model;

class TinderCard extends StatefulWidget {
  final bool isLiked;
  final bool isFront;
  final model.Step step;
  const TinderCard(
      {Key? key,
      this.isLiked = false,
      required this.step,
      required this.isFront})
      : super(key: key);

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
    return widget.isFront ? buildFrontCard() : buildCard();
  }

  Widget buildFrontCard() {
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
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFAE9387).withOpacity(0.05),
                  blurRadius: 10,
                  spreadRadius: 5,
                  offset: const Offset(0, 2),
                )
              ],
              image: DecorationImage(
                image: NetworkImage(widget.step.imgUrl!),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(child: Container()),
                  Container(
                    color: Colors.white,
                    child: Text(
                      widget.step.title ?? "",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget buildCard() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(widget.step.imgUrl!),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
