import 'package:brummaps/user_profile/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            DrawerHeader(
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 35,
                    backgroundImage: NetworkImage(
                      "https://images.unsplash.com/photo-1589156191108-c762ff4b96ab?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=986&q=80",
                    ),
                  ),
                  Text(
                    "Bonjour, Salayna",
                    style: GoogleFonts.montserrat(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  Text(
                    "salaynadoukoure@gmail.com",
                    style: GoogleFonts.montserrat(
                        color: Colors.grey[800],
                        fontSize: 18,
                        fontWeight: FontWeight.w600
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                physics: const NeverScrollableScrollPhysics(),
                children:  [
                  ListTile(
                    title: const Text("Mes derniers trajets"),
                    leading: const Icon(
                      Icons.route_outlined
                    ),
                    onTap: (){
                      print('Navigate to My last reservations');
                    },
                  ),
                  ListTile(
                    title: const Text("Déconnexion"),
                    leading: const Icon(
                        Icons.logout
                    ),
                    onTap: (){
                      print('Navigate to My last reservations');
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
