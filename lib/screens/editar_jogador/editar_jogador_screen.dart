import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:provider/provider.dart';

import '../../api/api.dart';
import '../../helpers/helpers.dart';
import '../../models/models.dart';

class EditarJogadorScreen extends StatefulWidget {

  final Jogador jogador;
  EditarJogadorScreen({required this.jogador});

  @override
  _EditarJogadorScreenState createState() => _EditarJogadorScreenState();
}

class _EditarJogadorScreenState extends State<EditarJogadorScreen> {

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final _nomeController = TextEditingController();
  final _contatoController = TextEditingController();
  final _emailController = TextEditingController();

  void limparCampos(){
    _nomeController.clear();
    _contatoController.clear();
    _emailController.clear();
  }

  @override
  Widget build(BuildContext context) {

    return Consumer2<EditarJogador,ListaJogadores>(

      builder: (_,editarJogador,listaJogadores,__){

        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            title: Text("Editar Jogador"),
            centerTitle: true,
            elevation: 0,
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: editarJogador.loading?null:()async{

              if(formKey.currentState!.validate()){

                await editarJogador.patchEditarJogador(
                    jogador: Jogador(
                      nome: _nomeController.text.isNotEmpty?_nomeController.text:widget.jogador.nome,
                      contato: _contatoController.text.isNotEmpty?refatorarTelefone(_contatoController.text):widget.jogador.contato,
                      email: _emailController.text.isNotEmpty?_emailController.text:widget.jogador.email,
                      senha: "",
                      id: widget.jogador.id,
                    ),
                    onSuccess: (text)async{

                      listaJogadores.getListaJogadores();

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
            tooltip: 'Editar Jogador',
            backgroundColor: editarJogador.loading?Colors.grey:colorRedSalsa,
            elevation: editarJogador.loading?0:3,
            child: Icon(
              Icons.edit,
              color: Colors.white,
            ),
          ),
          body: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if(editarJogador.loading)
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
                          initialValue: widget.jogador.senha,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                          enabled: false,
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
                            labelText: "Senha",
                            labelStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                        const SizedBox(height: 24,),
                        TextFormField(
                          initialValue: widget.jogador.nome,
                          keyboardType: TextInputType.text,
                          onChanged: (text){
                            _nomeController.text = text;
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
                            labelText: "Nome do Jogador",
                            labelStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                        const SizedBox(height: 24,),
                        TextFormField(
                          initialValue: UtilBrasilFields.obterTelefone(widget.jogador.contato),
                          keyboardType: TextInputType.number,
                          onChanged: (text){
                            _contatoController.text = text;
                          },
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            TelefoneInputFormatter(),
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
                            labelText: "Telefone",
                            labelStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                        const SizedBox(height: 24,),
                        TextFormField(
                          initialValue: widget.jogador.email,
                          keyboardType: TextInputType.text,
                          onChanged: (text){
                            _emailController.text = text;
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
                            labelText: "E-mail",
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
