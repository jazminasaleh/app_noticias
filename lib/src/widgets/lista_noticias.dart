import 'package:flutter/material.dart';
import 'package:noticias/src/models/news_models.dart';
import 'package:noticias/src/theme/tema.dart';
import 'package:url_launcher/url_launcher.dart';

//la lista de las noticias con todos sus datos
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
        _TarjetaAutor(
          noticia: this.noticia,
        ),
        _TarjetaFecha(
          noticia: noticia,
        ),
        _TarjetaBotones(noticia: noticia),
        SizedBox(
          height: 5,
        ),
        Divider(),
      ],
    );
  }
}
//Los botones de estrella y que manda al enlace de la noticia
class _TarjetaBotones extends StatefulWidget {
  final Article noticia;

  _TarjetaBotones({required this.noticia});

  @override
  State<_TarjetaBotones> createState() => _TarjetaBotonesState();
}

class _TarjetaBotonesState extends State<_TarjetaBotones> {
  bool _color = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RawMaterialButton(
            onPressed: () {
              setState(() {
                _color = !_color;
              });
            },
            fillColor: Colors.red,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(
              Icons.star,
              color: _color 
                ? Colors.black 
                : Colors.yellow,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          RawMaterialButton(
            onPressed: () {
              launch(widget.noticia.url);
            },
            fillColor: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(
              Icons.link,
              size: 30,
               
            ),
          ),
        ],
      ),
    );
  }
}

//Una breve descripcion de la notica
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

//Iamgen de la noticia
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
                    ))),
    );
  }
}
//Titulo de la noticia
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
//Qu periodico publico la noticia
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

//Autor de la noticia
class _TarjetaAutor extends StatelessWidget {
  final Article noticia;

  const _TarjetaAutor({
    required this.noticia,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10, bottom: 10),
      child: Row(
        children: [
          Text('Autor: '),
          (noticia.author != '')
              ? Text(
                  '${noticia.author}.',
                )
              : Text('No se conoce al autor.')
        ],
      ),
    );
  }
}
//Feacha y hora en la que fue publicada la noticia
class _TarjetaFecha extends StatelessWidget {
  final Article noticia;

  const _TarjetaFecha({
    required this.noticia,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10, bottom: 10),
      child: Row(
        children: [
          Text('Fecha y hora: '),
          (noticia.publishedAt != '')
              ? Text(
                  '${noticia.publishedAt}.',
                )
              : Text('No tiene URL.')
        ],
      ),
    );
  }
}


