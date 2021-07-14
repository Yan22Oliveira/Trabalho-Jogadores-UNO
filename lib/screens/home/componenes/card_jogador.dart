import 'package:flutter/material.dart';

import 'package:brasil_fields/brasil_fields.dart';

import 'package:provider/provider.dart';

import '../../../api/api.dart';
import '../../../helpers/helpers.dart';
import '../../../models/models.dart';

import '../../editar_jogador/editar_jogador_screen.dart';
import '../../jogos_screen/jogos_screen.dart';

class CardJogador extends StatelessWidget {

  final Jogador jogador;
  CardJogador({required this.jogador});

  @override
  Widget build(BuildContext context) {
    return Consumer3<DeletarJogador,ListaJogadores,ListaJogos>(

      builder: (_,deletarJogador,listaJogadores,listaJogos,__){

        return GestureDetector(

          onTap: (){

            listaJogos.getListaJogos(idJogador: jogador.id);

            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => JogosScreen(jogador: jogador,),
              ),
            );
          },

          child: Card(
            elevation: 3,
            color: Colors.white,
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Text(
                          jogador.nome,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: colorMalachite,
                          ),
                        ),

                        const SizedBox(height: 8,),

                        Text(
                          UtilBrasilFields.obterTelefone(jogador.contato),
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),

                        const SizedBox(height: 4,),

                        Text(
                          jogador.email,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),

                        const SizedBox(height: 4,),

                        Text(
                          jogador.senha,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),

                      ],
                    ),
                  ),

                  Column(

                    children: [

                      IconButton(
                        onPressed: deletarJogador.loading?null:()async{

                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => EditarJogadorScreen(jogador: jogador),
                            ),
                          );

                        },
                        tooltip: "Editar",
                        icon: Icon(
                          Icons.edit,
                          color: colorBlueJeans,
                        ),
                      ),

                      IconButton(
                        onPressed: deletarJogador.loading?null:()async{

                          await deletarJogador.deleteDeletarJogador(
                            jogador: jogador,
                          );

                          listaJogadores.getListaJogadores();

                        },
                        tooltip: "Deletar",
                        icon: Icon(
                          Icons.delete,
                          color: Colors.redAccent,
                        ),
                      ),

                    ],

                  )
                ],
              ),
            ),
          ),
        );

      },

    );
  }

}
