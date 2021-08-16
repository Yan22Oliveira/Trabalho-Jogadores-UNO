import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

import '../../helpers/helpers.dart';
import '../../models/models.dart';

class CadastrarJogador extends ChangeNotifier{

  Dio dio = Dio();

  bool _loading = false;
  bool get loading => _loading;
  set loading(bool value){
    _loading = value;
    notifyListeners();
  }

  //Pegar Imagem
  final imagemTemporaria = PickedFile;
  final _picker = ImagePicker();

  File _imagem = File("");
  File get imagem => _imagem;
  set imagem(File value){
    _imagem = value;
    notifyListeners();
  }

  Future<void> pegarImagemGaleria(BuildContext context) async {
    PickedFile? imagemTemporaria = await _picker.getImage(source: ImageSource.gallery);
    if(imagemTemporaria!=null){
      imagem = File(imagemTemporaria.path);
    }
  }

  Future<void> postCadastrarJogador({
    required Jogador jogador,
    required Function(String) onSuccess,
    required Function(String) onFail,
  }) async {

    loading = true;

    var corpo = json.encode({
      "nome":jogador.nome,
      "contato":jogador.contato,
      "email":jogador.email,
      "senha":jogador.senha,
    });

    try{

      final response = await dio.post(
        api_jogadores,
        data: corpo,
      );

      if(response.statusCode == 200){
        Map<String, dynamic> data = new Map<String, dynamic>.from(response.data);
        if(data.containsKey('name')){
          onSuccess("Jogador cadastrado com sucesso!");
        }else{
          onFail("Erro ao cadastrar Jogador!");
        }
      }else{
        onFail("Erro ao cadastrar Jogador!");
      }

    }catch(e){
      onFail("Erro ao cadastrar Jogador!");
    }

    loading = false;

  }

}