import 'package:flutter/material.dart';

class TextoTituloForm extends StatelessWidget {

  final String texto;
  TextoTituloForm({required this.texto});

  @override
  Widget build(BuildContext context) {
    return Text(
      texto,
      style: TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }

}