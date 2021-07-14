import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:dio/dio.dart';

import '../../helpers/helpers.dart';
import '../../models/models.dart';

class ListaJogadores extends ChangeNotifier{

  ListaJogadores(){
    getListaJogadores();
  }

  Dio dio = Dio();

  List<Jogador> listaJogadores = [];

  bool _loading = false;
  bool get loading => _loading;
  set loading(bool value){
    _loading = value;
    notifyListeners();
  }

  Future<void> getListaJogadores() async {

    loading = true;
    listaJogadores.clear();

    try{

      final response = await dio.get(
        api_jogadores,
      );

      if(response.statusCode == 200){

        Map<String, dynamic> data = new Map<String, dynamic>.from(response.data);

        data.forEach((key, value) {
          Jogador jogador = Jogador.fromJson(value,key);
          listaJogadores.add(jogador);
        });

      }else{
        listaJogadores.clear();
      }

    }catch(e){
      listaJogadores.clear();
    }

    loading = false;

  }

}