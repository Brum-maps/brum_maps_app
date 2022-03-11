import 'package:brummaps/home/cubit/home_cubit.dart';
import 'package:brummaps/home/widget/drawer.dart';
import 'package:brummaps/model/model.dart' as model;
import 'package:brummaps/user_profile/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<Widget>(child: HomePage());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: _Content(),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //drawer: AppDrawer(),
      appBar: AppBar(
        title: const Text("Parcours"),
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          print(state);
          context.read<HomeCubit>().fetch();
          print(state);
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: ListView.separated(
                separatorBuilder: ((context, index) {
                  return const SizedBox(
                    height: 10,
                  );
                }),
                itemCount: state.routes.length,
                itemBuilder: (context, index) {
                  return ListItem(
                    route: state.routes[index]
                  );
                }),
          );
        },
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  const ListItem({Key? key, required this.route}) : super(key: key);
  final model.Route route;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("tapped");
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFAE9387).withOpacity(0.3),
              blurRadius: 10,
              spreadRadius: 3,
              offset: Offset(0, 2),
            )
          ],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 5
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${route.title}",
                      style: GoogleFonts.montserrat(
                          color: Colors.black,
                          fontSize: 20
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "${route.description}",
                      style: GoogleFonts.montserrat(
                          color: Colors.grey[800],
                          fontSize: 17
                      ),)
                  ],
                ),
              ),
              Column(
                children: [
                  Text(
                    '${route.distance}',
                    style: GoogleFonts.montserrat(
                        color: Colors.black,
                        fontWeight: FontWeight.w900,
                        fontSize: 25
                    ),
                  ),
                  Text(
                    'KM',
                    style: GoogleFonts.montserrat(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 17
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
