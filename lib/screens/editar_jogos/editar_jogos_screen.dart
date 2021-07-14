import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';

import '../../api/api.dart';
import '../../helpers/helpers.dart';
import '../../models/models.dart';

class EditarJogosScreen extends StatefulWidget {

  final Jogador jogador;
  final Jogos jogos;
  EditarJogosScreen({required this.jogador,required this.jogos});

  @override
  _EditarJogosScreenState createState() => _EditarJogosScreenState();
}

class _EditarJogosScreenState extends State<EditarJogosScreen> {

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

    return Consumer2<EditarJogos,ListaJogos>(

      builder: (_,editarJogos,listaJogos,__){

        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            title: Text("Editar Jogos"),
            centerTitle: true,
            elevation: 0,
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: editarJogos.loading?null:()async{

              if(formKey.currentState!.validate()){

                await editarJogos.patchEditarJogos(
                    jogador: widget.jogador,
                    jogos: Jogos(
                      id: widget.jogos.id,
                      dataJogo: _dataController.text.isNotEmpty?_dataController.text:widget.jogos.dataJogo,
                      jogadores: _jogadoresController.text.isNotEmpty?int.parse(_jogadoresController.text):widget.jogos.jogadores,
                      posicao: _posicaoController.text.isNotEmpty?(_posicaoController.text):widget.jogos.posicao,
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
            backgroundColor: editarJogos.loading?Colors.grey:colorRedSalsa,
            elevation: editarJogos.loading?0:3,
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
                  if(editarJogos.loading)
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
                          initialValue: widget.jogos.dataJogo,
                          keyboardType: TextInputType.datetime,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w300,
                          ),
                          onChanged: (text){
                            _dataController.text = text;
                          },
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
                          initialValue: widget.jogos.posicao,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w300,
                          ),
                          onChanged: (text){
                            _posicaoController.text = text;
                          },
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
                          initialValue: widget.jogos.jogadores.toString(),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w300,
                          ),
                          onChanged: (text){
                            _jogadoresController.text=text;
                          },
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
