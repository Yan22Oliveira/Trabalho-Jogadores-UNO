import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:dio/dio.dart';

import '../../helpers/helpers.dart';
import '../../models/models.dart';

class ListaJogos extends ChangeNotifier{

  Dio dio = Dio();

  List<Jogos> listaJogs = [];

  bool _loading = false;
  bool get loading => _loading;
  set loading(bool value){
    _loading = value;
    notifyListeners();
  }

  Future<void> getListaJogos({required String idJogador}) async {

    loading = true;
    listaJogs.clear();

    try{

      final response = await dio.get(
        api_jogos+idJogador+"/jogos/.json",
      );

      if(response.statusCode == 200){

        Map<String, dynamic> data = new Map<String, dynamic>.from(response.data);

        data.forEach((key, value) {
          Jogos jogos = Jogos.fromJson(value,key);
          listaJogs.add(jogos);
        });

      }else{
        listaJogs.clear();
      }

    }catch(e){
      listaJogs.clear();
    }

    loading = false;

  }

}