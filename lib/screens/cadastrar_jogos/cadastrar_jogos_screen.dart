import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';

import '../../api/api.dart';
import '../../helpers/helpers.dart';
import '../../models/models.dart';

class CadastrarJogosScreen extends StatefulWidget {

  final Jogador jogador;
  CadastrarJogosScreen({required this.jogador});

  @override
  _CadastrarJogosScreenState createState() => _CadastrarJogosScreenState();
}

class _CadastrarJogosScreenState extends State<CadastrarJogosScreen> {

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final _dataController = TextEditingController();
  final _jogadoresController = TextEditingController();
  final _posicaoController = TextEditingController();

  void limparCampos(){
    _dataController.clear();
    _jogadoresController.clear();
    _posicaoController.clear();
  }

  @override
  Widget build(BuildContext context) {

    return Consumer2<CadastrarJogos,ListaJogos>(

      builder: (_,cadastrarJogos,listaJogos,__){

        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            title: Text("Cadastrar Jogos"),
            centerTitle: true,
            elevation: 0,
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: cadastrarJogos.loading?null:()async{

              if(formKey.currentState!.validate()){

                await cadastrarJogos.postCadastrarJogos(
                    jogador: widget.jogador,
                    jogos: Jogos(
                      id: "",
                      dataJogo: _dataController.text,
                      jogadores: int.parse(_jogadoresController.text),
                      posicao: (_posicaoController.text),
                    ),
                    onSuccess: (text)async{

                      listaJogos.getListaJogos(idJogador: widget.jogador.id);

                      scaffoldKey.currentState!.showSnackBar(
                          SnackBar(
                            content: Text(
                              text,
                              textAlign: TextAlign.center,
                            ),
                            backgroundColor: Colors.green,
                            duration: Duration(seconds: 2),
                          )
                      );

                      Future.delayed(Duration(seconds: 2)).then((_){
                        Navigator.pop(context);
                      });

                    },
                    onFail: (text){
                      scaffoldKey.currentState!.showSnackBar(
                          SnackBar(
                            content: Text(
                              text,
                              textAlign: TextAlign.center,
                            ),
                            backgroundColor: Colors.redAccent,
                            duration: Duration(seconds: 3),
                          )
                      );
                    }
                );

              }

            },
            tooltip: 'Salvar Jogador',
            backgroundColor: cadastrarJogos.loading?Colors.grey:colorRedSalsa,
            elevation: cadastrarJogos.loading?0:3,
            child: Icon(
              Icons.save,
              color: Colors.white,
            ),
          ),
          body: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if(cadastrarJogos.loading)
                    LinearProgressIndicator(
                      color: colorBlueJeans,
                      backgroundColor: Colors.white,
                      minHeight: 5,
                    ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 36,),
                        TextFormField(
                          controller: _dataController,
                          keyboardType: TextInputType.datetime,
                          validator: (text){
                            if(text!.trim().isEmpty)
                              return 'Campo obrigatório';
                            return null;
                          },
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w300,
                          ),
                          decoration: InputDecoration(
                            isDense: true,
                            counterText: '',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                                width: 0.5,
                              ),
                            ),
                            labelText: "Data do Jogo",
                            labelStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                        const SizedBox(height: 24,),
                        TextFormField(
                          controller: _posicaoController,
                          keyboardType: TextInputType.number,
                          validator: (text){
                            if(text!.trim().isEmpty)
                              return 'Campo obrigatório';
                            return null;
                          },
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w300,
                          ),
                          decoration: InputDecoration(
                            isDense: true,
                            counterText: '',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                                width: 0.5,
                              ),
                            ),
                            labelText: "Posição",
                            labelStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                        const SizedBox(height: 24,),
                        TextFormField(
                          controller: _jogadoresController,
                          keyboardType: TextInputType.number,
                          validator: (text){
                            if(text!.trim().isEmpty)
                              return 'Campo obrigatório';
                            return null;
                          },
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w300,
                          ),
                          decoration: InputDecoration(
                            isDense: true,
                            counterText: '',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                                width: 0.5,
                              ),
                            ),
                            labelText: "Jogadores",
                            labelStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                        const SizedBox(height: 24,),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

        );

      },

    );

  }
}
