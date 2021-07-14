import 'package:flutter/material.dart';
import 'package:partidas_uno/screens/editar_jogos/editar_jogos_screen.dart';

import 'package:provider/provider.dart';

import '../../../api/api.dart';
import '../../../helpers/helpers.dart';
import '../../../models/models.dart';

class CardJogos extends StatelessWidget {

  final Jogador jogador;
  final Jogos jogos;
  CardJogos({required this.jogos, required this.jogador});

  @override
  Widget build(BuildContext context) {
    return Consumer2<DeletarJogos,ListaJogos>(

      builder: (_,deletarJogos,listaJogos,__){

        return GestureDetector(

          onTap: (){


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
                          (jogos.dataJogo),
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: colorMalachite,
                          ),
                        ),

                        const SizedBox(height: 8,),

                        Text(
                          "Posição: "+jogos.posicao.toString(),
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),

                        const SizedBox(height: 4,),

                        Text(
                          "Jogadores: "+jogos.jogadores.toString(),
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
                        onPressed: ()async{


                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => EditarJogosScreen(
                                jogador: jogador,
                                jogos: jogos,
                              ),
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
                        onPressed: deletarJogos.loading?null:()async{

                          await deletarJogos.deleteDeletarJogos(
                            jogador: jogador,
                            jogos: jogos,
                          );
                          listaJogos.getListaJogos(idJogador: jogador.id);

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
