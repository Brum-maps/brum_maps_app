import 'package:brummaps/authentication/authentication.dart';
import 'package:brummaps/googleMaps/google_maps.dart';
import 'package:brummaps/googleMaps/view/maps_page.dart';
import 'package:brummaps/home/home.dart';
import 'package:brummaps/login/login.dart';
import 'package:brummaps/tinder/view/tinder_page.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthenticationCubit>(
      create: (_) => AuthenticationCubit(),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              appBarTheme: const AppBarTheme(
            systemOverlayStyle: SystemUiOverlayStyle.dark,
            backgroundColor: Color(0xFFAE9387),
          )),
          home: const AppView()),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlowBuilder<AuthenticationState>(
      state: context.select((AuthenticationCubit bloc) => bloc.state),
      onGeneratePages: (AuthenticationState state, List<Page<dynamic>> pages) {
        switch (state.status) {
          case AuthenticationStatus.authenticated:
            return [
              // MapsPage.page()
              TinderPage.page()
              // HomePage.page()
            ];
          case AuthenticationStatus.unauthenticated:
            return [LoginPage.page()];
        }
      },
    );
  }
}
