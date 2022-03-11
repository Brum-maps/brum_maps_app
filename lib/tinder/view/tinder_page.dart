import 'package:brummaps/googleMaps/view/maps_page.dart';
import 'package:brummaps/home/view/home_view.dart';
import 'package:brummaps/home/widget/drawer.dart';
import 'package:brummaps/tinder/cubit/tinder_cubit.dart';
import 'package:brummaps/tinder/widget/card_provider.dart';
import 'package:brummaps/tinder/widget/tinder_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'package:brummaps/model/model.dart' as model;

class TinderPage extends StatelessWidget {
  static Page page() => const MaterialPage<Widget>(child: TinderPage());
  const TinderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TinderCubit()..getTinderCardList(),
      child: BlocBuilder<TinderCubit, TinderState>(builder: (context, state) {
        return ChangeNotifierProvider(
          create: (context) => CardProvider(steps: state.steps),
          child: Scaffold(
            drawer: AppDrawer(),
            appBar: AppBar(
              iconTheme: const IconThemeData(color: Colors.black),
              elevation: 0,
              backgroundColor: Colors.transparent,
              actions: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: IconButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) {
                            return const HomePage();
                          },
                        ));
                      },
                      icon: Icon(Icons.route_rounded)),
                )
              ],
            ),
            body: SafeArea(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Text("Customise ton parcours !",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold)),
                  ),
                  Expanded(
                    child: Builder(builder: (context) {
                      var steps = state.steps;
                      if (steps == null) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Color(0xFFAE9387),
                          ),
                        );
                      }
                      return buildCards(context);
                    }),
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
      }),
    );
  }

  Widget buildCards(BuildContext context) {
    List<model.Step>? steps = Provider.of<CardProvider>(context).steps;
    List<model.Step>? likedSteps =
        Provider.of<CardProvider>(context).likedSteps;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: steps!.isNotEmpty
          ? Stack(
              children: steps
                  .map<Widget>((e) => TinderCard(
                        step: e,
                        isFront: steps.last == e,
                      ))
                  .toList(),
            )
          : Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextButton(
                    onPressed: () async {
                      List<model.Step> newStep =
                          BlocProvider.of<TinderCubit>(context)
                              .sendItinary(likedSteps);
                      Navigator.of(context)
                          .push(
                            MaterialPageRoute(
                              builder: (context) => MapsPage(
                                steps: newStep,
                              ),
                              fullscreenDialog: true,
                            ),
                          )
                          .then((_) => context
                              .read<TinderCubit>()
                              .getTinderCardList(reload: true));
                    },
                    style: TextButton.styleFrom(
                        backgroundColor: const Color(0xFFAE9387)),
                    child: const Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "Générer mon parcours !",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: const Color(0xFFAE9387)),
                      onPressed: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const TinderPage(),
                            ),
                          ),
                      child: const Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "Refaire une selection",
                          style: TextStyle(color: Colors.white),
                        ),
                      ))
                ],
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
