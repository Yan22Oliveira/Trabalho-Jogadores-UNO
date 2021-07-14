import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:dio/dio.dart';

import '../../helpers/helpers.dart';
import '../../models/models.dart';

class DeletarJogos extends ChangeNotifier{

  Dio dio = Dio();

  bool _loading = false;
  bool get loading => _loading;
  set loading(bool value){
    _loading = value;
    notifyListeners();
  }

  Future<void> deleteDeletarJogos({
    required Jogador jogador,
    required Jogos jogos,
  }) async {

    loading = true;

    try{

      final response = await dio.delete(
        api_jogos+jogador.id+"/jogos/"+jogos.id+".json",
      );

      if(response.statusCode == 200){

      }

    }catch(e){

    }

    loading = false;

  }

}