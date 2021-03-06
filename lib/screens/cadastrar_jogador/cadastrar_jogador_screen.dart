import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:provider/provider.dart';

import '../../api/api.dart';
import '../../helpers/helpers.dart';
import '../../models/models.dart';

class CadastrarJogadorScreen extends StatefulWidget {

  @override
  _CadastrarJogadorScreenState createState() => _CadastrarJogadorScreenState();
}

class _CadastrarJogadorScreenState extends State<CadastrarJogadorScreen> {

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final _nomeController = TextEditingController();
  final _contatoController = TextEditingController();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  final _senhaSegundaController = TextEditingController();

  void limparCampos(){
    _nomeController.clear();
    _contatoController.clear();
    _emailController.clear();
    _senhaController.clear();
    _senhaSegundaController.clear();
  }

  @override
  Widget build(BuildContext context) {

    return Consumer2<CadastrarJogador,ListaJogadores>(

      builder: (_,cadastrarJogador,listaJogadores,__){

        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            title: Text("Cadastrar Jogador"),
            centerTitle: true,
            elevation: 0,
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: cadastrarJogador.loading?null:()async{

              if(formKey.currentState!.validate()){

                if(compararSenhas(
                    senha: _senhaController.text,
                    segundaSenha: _senhaSegundaController.text,
                  )
                ){

                  await cadastrarJogador.postCadastrarJogador(
                      jogador: Jogador(
                        nome: _nomeController.text,
                        contato: refatorarTelefone(_contatoController.text),
                        email: _emailController.text,
                        senha: _senhaController.text,
                        id: "",
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

                }else{
                  scaffoldKey.currentState!.showSnackBar(
                      SnackBar(
                        content: Text(
                          "Senhas n??o coferem",
                          textAlign: TextAlign.center,
                        ),
                        backgroundColor: Colors.redAccent,
                        duration: Duration(seconds: 3),
                      )
                  );
                }

              }

            },
            tooltip: 'Salvar Jogador',
            backgroundColor: cadastrarJogador.loading?Colors.grey:colorRedSalsa,
            elevation: cadastrarJogador.loading?0:3,
            child: Icon(
              Icons.save,
              color: Colors.white,
            ),
          ),
          body: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if(cadastrarJogador.loading)
                    LinearProgressIndicator(
                      color: colorBlueJeans,
                      backgroundColor: Colors.white,
                      minHeight: 5,
                    ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        const SizedBox(height: 40,),

                        FormField(
                          validator: (oferta){
                            if(cadastrarJogador.imagem.path.isEmpty)
                              return '?? necess??rio adicionar uma imagem';
                            return null;
                          },
                          builder: (state){
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(height: 4,),
                                ClipOval(
                                  child: Container(
                                    color: colorRedSalsa,
                                    padding: EdgeInsets.all(1.6),
                                    child: ClipOval(
                                      child: Container(
                                        height: 140,
                                        width: 140,
                                        color: Colors.white,
                                        alignment: Alignment.center,
                                        child: Stack(
                                          children: [
                                            if(cadastrarJogador.imagem.path.isNotEmpty)
                                              Center(
                                                child: Image.file(
                                                  cadastrarJogador.imagem,
                                                  height: 140,
                                                ),
                                              ),
                                            Align(
                                              alignment: cadastrarJogador.imagem.path.isNotEmpty?
                                              Alignment.topRight:
                                              Alignment.center,
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: IconButton(
                                                  onPressed: ()async{
                                                    await cadastrarJogador.pegarImagemGaleria(context);
                                                  },
                                                  tooltip: "Adicionar imagem",
                                                  icon: Icon(
                                                    Icons.camera_alt_rounded,
                                                    color: colorRedSalsa,
                                                    size: 35,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                if(state.hasError)
                                  const SizedBox(height: 4,),
                                if(state.hasError)
                                  Text(
                                    state.errorText as String,
                                    style: const TextStyle(
                                        color: Colors.red,
                                        fontSize: 12
                                    ),
                                  ),
                              ],
                            );
                          },

                        ),
                        const SizedBox(height: 40,),
                        TextFormField(
                          controller: _nomeController,
                          keyboardType: TextInputType.text,
                          validator: (text){
                            if(text!.trim().isEmpty)
                              return 'Campo obrigat??rio';
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
                            labelText: "Nome do Jogador",
                            labelStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                        const SizedBox(height: 24,),
                        TextFormField(
                          controller: _contatoController,
                          keyboardType: TextInputType.number,
                          validator: (text){
                            if(text!.trim().isEmpty)
                              return 'Campo obrigat??rio';
                            return null;
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
                          controller: _emailController,
                          keyboardType: TextInputType.text,
                          validator: (email){
                            if(email!.isEmpty)
                              return 'Campo obrigat??rio';
                            else if(!emailValid(email))
                              return 'E-mail inv??lido';
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
                            labelText: "E-mail",
                            labelStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                        const SizedBox(height: 24,),
                        TextFormField(
                          controller: _senhaController,
                          keyboardType: TextInputType.visiblePassword,
                          validator: (text){
                            if(text!.trim().isEmpty)
                              return 'Campo obrigat??rio';
                            return null;
                          },
                          obscureText: true,
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
                          controller: _senhaSegundaController,
                          keyboardType: TextInputType.visiblePassword,
                          validator: (text){
                            if(text!.trim().isEmpty)
                              return 'Campo obrigat??rio';
                            return null;
                          },
                          obscureText: true,
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
                            labelText: "Confirmar Senha",
                            labelStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
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
