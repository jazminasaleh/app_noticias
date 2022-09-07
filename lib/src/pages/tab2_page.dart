import 'package:flutter/material.dart';
import 'package:noticias/src/models/category_model.dart';
import 'package:noticias/src/services/news_service.dart';
import 'package:noticias/src/theme/tema.dart';
import 'package:noticias/src/widgets/lista_noticias.dart';
import 'package:provider/provider.dart';

class Tab2Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final newService = Provider.of<NewsService>(context);
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
             _ListCategorias(),
             Expanded(
              child: ListaNoticias(newService.getArticulosCategriaSeleccionada!),
             )],
        ),
      ),
    );
  }
}

class _ListCategorias extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<NewsService>(context).categories;
    return Container(
      width: double.infinity,
      height: 80,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (BuildContext context, int index) {
          final cName = categories[index].name;
          return Container(
            //width: 113,
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                children: [
                  _CategoryButtom(categories[index]),
                  SizedBox(
                    height: 5,
                  ),
                  Text( (cName == 'business')
                        ? 'Economía'
                        : (cName == 'entertainment')
                          ? 'Pasatiempo'
                          :(cName == 'health')
                            ? 'Salud'
                            :(cName == 'science')
                              ? 'Ciencia'
                              :(cName == 'sports')
                                ? 'Deportes'
                                :(cName == 'technology')
                                  ? 'Tecnología'
                                  : '${cName[0].toUpperCase()}${cName.substring(1)}')
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _CategoryButtom extends StatelessWidget {
  final Category categoria;

  const _CategoryButtom(this.categoria);

  @override
  Widget build(BuildContext context) {
    final newService = Provider.of<NewsService>(context, listen: false);
    return GestureDetector(
      onTap: () {
        final newService = Provider.of<NewsService>(context, listen: false);
        newService.selectedCategory = categoria.name;
      },
      child: Container(
        width: 40,
        height: 40,
        margin: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
        child: Icon(categoria.icon,
            color: (newService.selectedcategory == this.categoria.name)
                ? Colors.blue
                : Colors.black54),
      ),
    );
  }
}
