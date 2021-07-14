import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:dio/dio.dart';

import '../../helpers/helpers.dart';
import '../../models/models.dart';

class EditarJogos extends ChangeNotifier{

  Dio dio = Dio();

  bool _loading = false;
  bool get loading => _loading;
  set loading(bool value){
    _loading = value;
    notifyListeners();
  }

  Future<void> patchEditarJogos({
    required Jogador jogador,
    required Jogos jogos,
    required Function(String) onSuccess,
    required Function(String) onFail,
  }) async {

    loading = true;

    var corpo = json.encode({
      "dataJogo":jogos.dataJogo,
      "posicao":jogos.posicao,
      "jogadores":jogos.jogadores,
    });

    try{

      final response = await dio.patch(
        api_jogos+jogador.id+"/jogos/"+jogos.id+".json",
        data: corpo,
      );

      if(response.statusCode == 200){
        Map<String, dynamic> data = new Map<String, dynamic>.from(response.data);
        if(data.containsKey('dataJogo')){
          onSuccess("Jogo atualizado com sucesso!");
        }else{
          onFail("Erro ao atualizar Jogo!");
        }
      }else{
        onFail("Erro ao atualizar Jogo!");
      }

    }catch(e){
      onFail("Erro ao atualizar Jogo!");
    }

    loading = false;

  }

}