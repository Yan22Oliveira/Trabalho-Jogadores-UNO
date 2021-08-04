import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import './api/api.dart';
import './helpers/helpers.dart';

import 'screens/home/home_screen.dart';
import './screens/login/login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ListaJogadores(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => CadastrarJogador(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => DeletarJogador(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => EditarJogador(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => EditarJogador(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => ListaJogos(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => CadastrarJogos(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => EditarJogos(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => DeletarJogos(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => Login(),
          lazy: false,
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'UNO',
        theme: ThemeData(
          primaryColor: colorRedSalsa,
        ),
        home: LoginScreen(),
      ),
    );
  }
}
