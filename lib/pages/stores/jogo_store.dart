import 'package:flutter/material.dart';
import 'package:jogos/http/exceptions.dart';
import 'package:jogos/models/jogo_model.dart';
import 'package:jogos/repositories/jogo_repository.dart';

class JogoStore{

  final IJogoRepository repository;

  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  final ValueNotifier<List<JogoModel>> state = 
    ValueNotifier<List<JogoModel>>([]);

  final ValueNotifier<String> erro = ValueNotifier<String>('');

  JogoStore({required this.repository});

  Future getJogos() async{
    isLoading.value = true;

    try{
    final result = await repository.getJogos();
    state.value = result;
    } on NotFoundException catch (e){
      erro.value = e.message;
    } catch (e){
      erro.value = e.toString();
    }

    isLoading.value = false;
  }
}