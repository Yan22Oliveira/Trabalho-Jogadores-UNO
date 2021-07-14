import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:dio/dio.dart';

import '../../helpers/helpers.dart';
import '../../models/models.dart';

class EditarJogador extends ChangeNotifier{

  Dio dio = Dio();

  bool _loading = false;
  bool get loading => _loading;
  set loading(bool value){
    _loading = value;
    notifyListeners();
  }

  Future<void> patchEditarJogador({
    required Jogador jogador,
    required Function(String) onSuccess,
    required Function(String) onFail,
  }) async {

    loading = true;

    var corpo = json.encode({
      "nome":jogador.nome,
      "contato":jogador.contato,
      "email":jogador.email,
    });

    try{

      final response = await dio.patch(
        api_jogadores_editar+jogador.id+".json",
        data: corpo,
      );

      if(response.statusCode == 200){
        Map<String, dynamic> data = new Map<String, dynamic>.from(response.data);
        if(data.containsKey('nome')){
          onSuccess("Jogador atualizado com sucesso!");
        }else{
          onFail("Erro ao atualizar Jogador!");
        }
      }else{
        onFail("Erro ao atualizar Jogador!");
      }

    }catch(e){
      onFail("Erro ao atualizar Jogador!");
    }

    loading = false;

  }

}