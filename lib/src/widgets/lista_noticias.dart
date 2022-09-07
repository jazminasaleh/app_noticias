import 'package:flutter/material.dart';
import 'package:noticias/src/models/news_models.dart';
import 'package:noticias/src/theme/tema.dart';

//la lista de las noticias
class ListaNoticias extends StatelessWidget {
  final List<Article> noticias;

  const ListaNoticias(this.noticias);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: this.noticias.length,
      itemBuilder: (BuildContext context, int index) {
        return _Noticia(this.noticias[index], index);
      },
    );
  }
}

class _Noticia extends StatelessWidget {
  final Article noticia;
  final int index;

  const _Noticia(this.noticia, this.index);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        _TarjetaTitulo(noticia: noticia),
        _TarjetaImagen(noticia: noticia),
        _TarjetaBody(noticia: noticia),
        SizedBox(
          height: 4,
        ),
        _TarjetaTopBar(
          noticia: this.noticia,
          index: this.index,
        ),
        _TarjetaBotones(),
        SizedBox(
          height: 5,
        ),
        Divider(),
      ],
    );
  }
}

class _TarjetaBotones extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RawMaterialButton(
            onPressed: () {},
            fillColor: miTema.accentColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(Icons.star_border),
          ),
          SizedBox(
            width: 10,
          ),
          RawMaterialButton(
            onPressed: () {},
            fillColor: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(Icons.more),
          ),
        ],
      ),
    );
  }
}

class _TarjetaBody extends StatelessWidget {
  final Article noticia;
  const _TarjetaBody({required this.noticia});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Text(noticia.description ?? ''),
    );
  }
}

class _TarjetaImagen extends StatelessWidget {
  final Article noticia;
  const _TarjetaImagen({required this.noticia});

  @override
  Widget build(BuildContext context) {
    print(noticia.urlToImage);
    return Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50), bottomRight: Radius.circular(50)),
          child: Container(
              child: (noticia.urlToImage != null)
                  ? Image(image: NetworkImage(noticia.urlToImage!))
                  : Image(
                      image: AssetImage('assets/no-image.png'),
                    )
                )
              ),
        );
  }
}

class _TarjetaTitulo extends StatelessWidget {
  final Article noticia;

  const _TarjetaTitulo({required this.noticia});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Text(
        noticia.title!,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
      ),
    );
  }
}

class _TarjetaTopBar extends StatelessWidget {
  final Article noticia;
  final int index;

  const _TarjetaTopBar({
    required this.noticia,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
     
      child: Row(
        children: [
          Text('Fuente: '),
          Text(
            '${noticia.source.name}.',
          )
        ],
      ),
    );
  }
}
