import 'package:jogos/models/jogo_model.dart';

abstract class IJogoRepository{
  Future<List<JogoModel>> getJogos();
}

class JogoRepository implements IJogoRepository{
  @override
  Future<List<JogoModel>> getJogos() {
    
    throw UnimplementedError();
  }

}