import 'dart:convert';

import 'package:jogos/http/exceptions.dart';
import 'package:jogos/http/http_client.dart';
import 'package:jogos/models/jogo_model.dart';

abstract class IJogoRepository{
  Future<List<JogoModel>> getJogos();
}

class JogoRepository implements IJogoRepository{

  final IHttpClient client;

  JogoRepository({required this.client});

  @override
  Future<List<JogoModel>> getJogos() async{
   final response = await client.get(
      url:'http://10.0.2.2/api/Jogos',
    );
  
  if (response.statusCode == 200){
    final List<JogoModel> jogos = [];

    final body = jsonDecode(response.body);     

    body['data'].map((item){
      final JogoModel jogo = JogoModel.fromMap(item, map: {});
      jogos.add(jogo);
    }).toList();

    return jogos;
  } else if(response.statusCode == 404){
    throw NotFoundException('A url informada não é valida');
  }
  else{
    throw Exception('Não foi possível carregar os jogos');
  }
 }
}