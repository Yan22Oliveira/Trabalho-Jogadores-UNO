import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:dio/dio.dart';

import '../../helpers/helpers.dart';
import '../../models/models.dart';

class CadastrarJogos extends ChangeNotifier{

  Dio dio = Dio();

  bool _loading = false;
  bool get loading => _loading;
  set loading(bool value){
    _loading = value;
    notifyListeners();
  }

  Future<void> postCadastrarJogos({
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

      final response = await dio.post(
        api_jogos+jogador.id+"/jogos/.json",
        data: corpo,
      );

      if(response.statusCode == 200){
        Map<String, dynamic> data = new Map<String, dynamic>.from(response.data);
        if(data.containsKey('name')){
          onSuccess("Jogo cadastrado com sucesso!");
        }else{
          onFail("Erro ao cadastrar Jogo!");
        }
      }else{
        onFail("Erro ao cadastrar Jogo!");
      }

    }catch(e){
      onFail("Erro ao cadastrar Jogo!");
    }

    loading = false;

  }

}