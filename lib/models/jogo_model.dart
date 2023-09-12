class JogoModel{
  final String nome;
  final String ano_lancamento;
  final String quantidade_avaliacoes;
  final List<String> images;

  JogoModel({required this.nome, 
  required this.ano_lancamento, 
  required this.quantidade_avaliacoes,
  required this.images,
  });

  factory JogoModel.fromMap({required Map<String, dynamic> map}){
    return JogoModel(
      nome: map['nome'],
      ano_lancamento: map['ano_lancamento'], 
      quantidade_avaliacoes: map['quantidade_avaliacoes'],
      images: List<String>.from((map['images'] as List)),
      );
  }
}