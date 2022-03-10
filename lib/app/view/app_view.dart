import 'package:brummaps/authentication/authentication.dart';
import 'package:brummaps/home/home.dart';
import 'package:brummaps/login/login.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider<AuthenticationCubit>(
          create: (_) => AuthenticationCubit(),
          child: const AppView(),
        ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlowBuilder<AuthenticationState>(
        state: context.select((AuthenticationCubit bloc) => bloc.state),
        onGeneratePages: (
            AuthenticationState state,
            List<Page<dynamic>> pages) {
          switch (state.status) {
            case AuthenticationStatus.authenticated:
              return [
                HomePage.page()
              ];
            case AuthenticationStatus.unauthenticated:
              return [
                LoginPage.page()
              ];
          }
        },
    );
  }
}
