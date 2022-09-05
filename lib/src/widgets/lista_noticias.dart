import 'package:flutter/material.dart';
import 'package:noticias/src/models/news_models.dart';
//la lista de las noticias
class ListaNoticias extends StatelessWidget {
  final List<Article> noticias;

  const ListaNoticias(this.noticias);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: this.noticias.length,
      itemBuilder: (BuildContext context, int index) {
        return Text(this.noticias[index].title!);
      },
    );
  }
}
