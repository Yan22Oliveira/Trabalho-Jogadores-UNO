import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../api/api.dart';
import '../../helpers/helpers.dart';

import './componenes/card_jogador.dart';
import '../cadastrar_jogador/cadastrar_jogador_screen.dart';
import '../login/login_screen.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Consumer2<ListaJogadores,Login>(

      builder: (_,listaJogadores,login,__){

        return Scaffold(
          backgroundColor: colorFundo,
          appBar: AppBar(
            title: Text(
              "Uno",
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 22,
              ),
            ),
            centerTitle: true,
            elevation: 0,
            actions: [
              IconButton(
                onPressed: (){
                  login.sair();
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => LoginScreen(),
                    ),
                  );
                },
                tooltip: 'Sair',
                icon: Icon(
                  Icons.exit_to_app,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 8,),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: colorRedSalsa,
            tooltip: "Adicionar Jogador",
            onPressed: (){
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => CadastrarJogadorScreen(),
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
            itemCount: listaJogadores.listaJogadores.length,
            itemBuilder: (context,index){

              return CardJogador(jogador: listaJogadores.listaJogadores[index],);

            },

          ),

        );

      },

    );
  }
}
