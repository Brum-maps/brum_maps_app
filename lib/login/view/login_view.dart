import 'package:brummaps/authentication/authentication.dart';
import 'package:brummaps/login/widget/custom_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatelessWidget {
  static Page page() => const MaterialPage<Widget>(child: LoginPage());
  const LoginPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey();
    //print(context.select((AuthenticationCubit bloc) => bloc.state),);
    return Center(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Form(
            key: _formKey,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    child: Image.asset("assets/images/MAPS.png"),
                  ),
                  CustomeFormField(
                    controller: TextEditingController(),
                    label: 'username',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomeFormField(
                    controller: TextEditingController(),
                    label: 'password',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                      onTap: () {
                        context
                            .read<AuthenticationCubit>()
                            .login(username: 'salayna', password: 'password');
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color(0xFFAE9387)
                        ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10,
                              horizontal: 15
                            ),
                            child: Text(
                              'LOGIN',
                              style: GoogleFonts.montserrat(
                                color: Colors.white,
                                fontSize: 20
                              ),
                            ),
                          ),),)
                ]),
          ),
        ),
      ),
    ));
  }
}

class LoginForm extends StatelessWidget {
  LoginForm({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
