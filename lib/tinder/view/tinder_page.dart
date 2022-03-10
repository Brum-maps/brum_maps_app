import 'package:brummaps/tinder/widget/card_provider.dart';
import 'package:brummaps/tinder/widget/tinder_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TinderPage extends StatelessWidget {
  static Page page() => const MaterialPage<Widget>(child: TinderPage());
  const TinderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CardProvider(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: SafeArea(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Text("Customise ton parcours !",
                    style:
                        TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Stack(
                    children: const [
                      TinderCard(),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    TinderButton(
                        icon: Icons.close_rounded,
                        iconColor: Colors.black,
                        isLike: false),
                    TinderButton(
                        icon: Icons.favorite_rounded, iconColor: Colors.red)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TinderButton extends StatelessWidget {
  final bool isLike;
  final IconData icon;
  final Color iconColor;
  const TinderButton(
      {Key? key,
      this.isLike = true,
      required this.iconColor,
      required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration:
            const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
        child: Icon(
          icon,
          color: iconColor,
          size: 50,
        ),
      ),
      onTap: () => isLike
          ? context.read<CardProvider>().like()
          : context.read<CardProvider>().dislike(),
    );
  }
}
