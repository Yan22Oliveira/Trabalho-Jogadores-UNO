import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../api/api.dart';

import '../../../screens/home/home_screen.dart';
import '../../../screens/login/login_screen.dart';

class ValidarTela extends StatefulWidget {

  @override
  _ValidarTelaState createState() => _ValidarTelaState();
}

class _ValidarTelaState extends State<ValidarTela> {

  @override
  Widget build(BuildContext context) {

    return Consumer<Login>(
      builder: (_,login,__){
        if(login.autenticado){
          return HomeScreen();
        }else{
          return LoginScreen();
        }
      },
    );

  }
}