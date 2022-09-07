import 'package:flutter/material.dart';
import 'package:noticias/src/pages/tab1_page.dart';
import 'package:noticias/src/pages/tab2_page.dart';
import 'package:noticias/src/services/news_service.dart';
import 'package:noticias/src/theme/tema.dart';
import 'package:provider/provider.dart';
import 'package:provider/provider.dart';

//Parte de la navegacion 
//Los botones de la parte inferiuor
//el cambio de pagina 1 a 2 y de 2 a 1
class TabsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => new _NavegacionModel(),
      child: Scaffold(
        body: _Paginas(),
        bottomNavigationBar: _Navegacion(),
      ),
    );
  }
}

//La parte inferior de los botones de la navegacion
class _Navegacion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //obtener la instancia del provider
    final navegacionModel = Provider.of<_NavegacionModel>(context);
    return BottomNavigationBar(
      //escucha el valor de la pagina actual
      currentIndex: navegacionModel.paginaActual,
      //aca se cambia el valor de la pagina actual
      onTap: (i) {
        navegacionModel.paginaActual = i;
        final newsServices = Provider.of<NewsService>(context, listen: false);
        newsServices.selectedCategory = newsServices.selectedcategory;
      },
      items: const [
        BottomNavigationBarItem(
            icon: Icon(Icons.newspaper, ), 
            label: 'Noticias',),
        BottomNavigationBarItem(icon: Icon(Icons.public), label: 'Categorías')
      ],
    );
  }
}

//lo que va a aparecer en el body de la app
class _Paginas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navegacionModel = Provider.of<_NavegacionModel>(context);
    return PageView(
      controller: navegacionModel.pageController,
      scrollDirection: Axis.horizontal,
      //prohibe que se deslice de una pagina a otra
      physics: NeverScrollableScrollPhysics(),
      //la pagina 1 y dos de la app
      children: <Widget>[
        Tab1Page(),
        Tab2Page()
      ],
    );
  }
}

//Cunado se le de click a alguno de los botones se redibuje el widget
class _NavegacionModel with ChangeNotifier {
  int _paginaActual = 0;
  PageController _pageController = new PageController(initialPage: 0);

  int get paginaActual => this._paginaActual;
  //se cambia la pagina actual
  set paginaActual(int valor) {
    this._paginaActual = valor;
    _pageController.animateToPage(valor,
        duration: Duration(microseconds: 250), curve: Curves.easeInCirc);
    notifyListeners();
  }

  PageController get pageController => this._pageController;
}
