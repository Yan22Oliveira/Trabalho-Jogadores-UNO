import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helpers/helpers.dart';
import '../../models/models.dart';

class Login extends ChangeNotifier{

  Login(){
    _carregarUserAtual(usuario: User.clear());
  }

  User user = User.clear();
  bool get autenticado => getToken.isEmpty;

  String get getToken {
    if (user.idToken.isNotEmpty && user.expiresIn.isAfter(DateTime.now())) {
      return user.idToken;
    } else {
      return "";
    }
  }

  GlobalKey<ScaffoldState> scaffoldKeyLogin = GlobalKey<ScaffoldState>(debugLabel: '_scaffoldKeyLogin');

  bool _loading = false;
  bool get loading => _loading;
  set loading(bool value){
    _loading = value;
    notifyListeners();
  }

  Future<void> postLogin({
    required String email,
    required String senha,
    required Function(String) onFail,
    required Function(String) onSuccess,
  }) async {

    loading = true;

    var corpo = json.encode({
      "email": email,
      "password": senha,
      "returnSecureToken": true
    });

    try{

      final response = await Dio().post(
        login+key,
        data: corpo,
      );

      if(response.statusCode == 200){

        _carregarUserAtual(
          usuario: User.fromJson(response.data),
        );

        await salvarDadosUser(
          usuario: User.fromJson(response.data),
        );

        onSuccess("Login confirmado!");


      }else{
        onFail("Erro code");
      }

    }catch(e){
      onFail("Erro ao realizar o login, tente novamente mais tarde!");
    }

    notifyListeners();
    loading = false;

  }

  Future<void> postCadastrarUser({
    required String email,
    required String senha,
    required Function(String) onFail,
    required Function(String) onSuccess,
  }) async {

    loading = true;

    var corpo = json.encode({
      "email": email,
      "password": senha,
      "returnSecureToken": true
    });

    try{

      final response = await Dio().post(
        signUp+key,
        data: corpo,
      );

      if(response.statusCode == 200){

        _carregarUserAtual(
          usuario: User.fromJson(response.data),
        );

        await salvarDadosUser(
          usuario: User.fromJson(response.data),
        );

        onSuccess("Cadastro realizado com sucesso!");

      }else{
        onFail("Erro code");
      }

    }catch(e){
      onFail("Erro ao realizar o cadastro, tente novamente mais tarde!");
    }

    notifyListeners();
    loading = false;

  }

  void retornarMensagem({
    required BuildContext context,
    required String mensagem,
    required Color color,
    required bool voltarTela,
  }){

    scaffoldKeyLogin.currentState!.showSnackBar(
        SnackBar(
          content: Text(
            mensagem,
            textAlign: TextAlign.center,
          ),
          backgroundColor: color,
          duration: Duration(seconds: 2),
        )
    );

    if(voltarTela){
      Future.delayed(Duration(seconds: 2)).then((_){
        Navigator.pop(context);
      });
    }

  }

  salvarDadosUser({required User usuario}) async {

    SharedPreferences prefs = await  SharedPreferences.getInstance();

    prefs.setString('expiresIn', usuario.expiresIn.toString());
    prefs.setString('email', usuario.email);
    prefs.setString('idToken', usuario.idToken);
    prefs.setString('localId', usuario.localId);

    notifyListeners();

  }

  Future<void> _carregarUserAtual({ required User usuario}) async {

    SharedPreferences prefs = await  SharedPreferences.getInstance();

    if(usuario.idToken.isNotEmpty){
      user = usuario;
    }

    if(prefs.getString('idToken') != null){

      user = User(
        expiresIn: DateFormat("yyyy-MM-dd").parse(prefs.getString('expiresIn')??""),
        email: prefs.getString('email')??"",
        idToken: prefs.getString('idToken')??"",
        localId: prefs.getString('localId')??"",
      );

    }

    notifyListeners();
  }

  Future<void> sair() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove("expiresIn");
    prefs.remove("email");
    prefs.remove("idToken");
    prefs.remove("localId");

    user = User.clear();
    notifyListeners();

  }

}