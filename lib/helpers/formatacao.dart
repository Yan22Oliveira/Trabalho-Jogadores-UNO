import 'package:intl/intl.dart';

String formatarData(String data){
  return DateFormat("dd/MM/yyyy").format(DateTime.parse(data));
}

String refatorarTelefone(String telefone){
  return telefone.replaceAll("(", "").replaceAll(")", "").replaceAll("-", "").replaceAll(" ", "");
}

