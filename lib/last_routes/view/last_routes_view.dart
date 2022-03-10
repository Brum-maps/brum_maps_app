import 'package:brummaps/implementation/iroute_provider.dart';
import 'package:brummaps/last_routes/cubit/last_routes_cubit.dart';
import 'package:brummaps/mock/mock_routes_controller.dart';
import 'package:brummaps/model/model.dart' as m;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class LastRoutesPage extends StatelessWidget {
  LastRoutesPage({Key? key}) : super(key: key);
  final IRouteProvider _iRouteProvider = MockRouteController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LastRoutesCubit(dataProvider: _iRouteProvider),
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
    context.read<LastRoutesCubit>().fetch();
    return BlocBuilder<LastRoutesCubit, LastRoutesState>(
      builder: (context, state) {
        print(state.routes);
        if(state.routes == null || state.routes!.isEmpty){
          return Scaffold();
        }
        return Scaffold(
          appBar: AppBar(
            title: const Text('Mes Parcours'),
          ),
          body: ListView.separated(
            separatorBuilder: (context, index) {
              return const SizedBox(
                height: 15,
              );
            },
            itemCount: state.routes!.length,
            itemBuilder: (context, index) {
              return RouteItem(
                route: state.routes![index]
              );
            },
          ),
        );
      },
    );
  }
}

class RouteItem extends StatelessWidget {
  const RouteItem({Key? key, required this.route}) : super(key: key);

  final m.Route route;
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
                      "À Venir",
                      style: GoogleFonts.montserrat(
                          color: Colors.green,
                          fontSize: 12
                      ),)
                  ],
                ),
              ),
              Row(
                children: [
                  const Icon(
                    Icons.route_outlined
                  ),
                  Column(
                    children: [
                      Text(
                        "${route.distance}",
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
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
