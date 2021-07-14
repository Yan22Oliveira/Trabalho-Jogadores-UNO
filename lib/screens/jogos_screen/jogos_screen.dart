import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../api/api.dart';
import '../../helpers/helpers.dart';
import '../../models/models.dart';

import './componenes/card_jogos.dart';
import '../cadastrar_jogos/cadastrar_jogos_screen.dart';

class JogosScreen extends StatelessWidget {

  final Jogador jogador;
  JogosScreen({required this.jogador});

  @override
  Widget build(BuildContext context) {
    return Consumer<ListaJogos>(

      builder: (_,listaJogos,__){

        return Scaffold(
          backgroundColor: colorFundo,
          appBar: AppBar(
            title: Text(
              "Lista dos Jogos - "+jogador.nome,
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 22,
              ),
            ),
            centerTitle: true,
            elevation: 0,
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: colorRedSalsa,
            tooltip: "Adicionar Jogos",
            onPressed: (){
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => CadastrarJogosScreen(jogador: jogador,),
                ),
              );
            },
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),

          body: ListView.builder(

            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.all(16),
            itemCount: listaJogos.listaJogs.length,
            itemBuilder: (context,index){

              return CardJogos(
                jogos: listaJogos.listaJogs[index],
                jogador: jogador,
              );

            },

          ),

        );

      },

    );
  }
}
