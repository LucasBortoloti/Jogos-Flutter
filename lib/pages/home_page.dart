import 'package:flutter/material.dart';
import 'package:jogos/http/http_client.dart';
import 'package:jogos/pages/stores/jogo_store.dart';
import 'package:jogos/repositories/jogo_repository.dart';

class HomePage extends StatefulWidget{
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

  class _HomePageState extends State<HomePage>{
    
    final JogoStore store = JogoStore(
      repository: JogoRepository(
        client: HttpClient(),
      ),
    );
    
    @override
    void initState(){
      super.initState();
      store.getJogos();
    }

    @override
    Widget build(BuildContext context){
      return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 26, 25, 27),
          title: const Text(
            'Steam',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: AnimatedBuilder(
          animation: Listenable.merge([
            store.isLoading,
            store.erro,
            store.state
          ]),
          builder: (context, child){
            if(store.isLoading.value){
              return const CircularProgressIndicator();
            }

          if (store.erro.value.isNotEmpty){
            return Center(
              child: Text(
                store.erro.value,
                style: const TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w600,
                  fontSize: 20, 
              ),
              textAlign: TextAlign.center,   
              ),
            );
          }

          if (store.state.value.isEmpty){
            return const Center(
            child: Text(
              'Nenhum item na lista',
              style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
           );
          } else{
            return ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(
                height: 32,
              ),
              padding: const EdgeInsets.all(16),
              itemCount: store.state.value.length,
              itemBuilder: (_, index){
                final item = store.state.value[index];
                return Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        item.images as String,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      item.nome,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 24,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.ano_lancamento,
                          style: const TextStyle(
                            color: Color.fromARGB(255, 0, 60, 255),
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                          ),
                        ),
                          const SizedBox(height: 4),
                          Text(
                            item.quantidade_avaliacoes,
                            style: const TextStyle(
                              color: Color.fromARGB(137, 0, 0, 0),
                              fontWeight: FontWeight.w400,
                              fontSize: 19,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ],
                      ),
                    ),
                  ],
                );
               },
             );
            }
          }
        ),
      );
    }
  }