import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:rfid77workflow/features/app/bloc/app_bloc.dart';
import 'package:rfid77workflow/features/app/router.dart';

final appBloc = AppBloc();

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final router = AppRouter().router;
    appBloc.router = router;
    appBloc.add(AppOnStartEvent());

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        textTheme: GoogleFonts.montserratTextTheme(),
        colorSchemeSeed: const Color(0xFF007bff),
        scaffoldBackgroundColor: Colors.white,
      ),
      routerConfig: router,
    );
  }
}
