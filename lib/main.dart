import 'package:avaliacaoii/screens/login/login_screen.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import './api/api.dart';
import './helpers/helpers.dart';

import 'api/login/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ListaArtistas(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => CadastrarArtista(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => DeletarArtista(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => EditarArtista(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => ListaMusicas(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => CadastrarMusica(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => EditarMusica(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => DeletarMusica(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => Login(),
          lazy: false,
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Avaliação PDM II',
        theme: ThemeData(
          primaryColor: corPrincipal,
        ),
        home: LoginScreen(),
      ),
    );
  }
}
