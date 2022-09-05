import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/provider.dart';

class TabsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _NavegacionModel(),
      child: Scaffold(
        body: _Paginas(),
        bottomNavigationBar: _Navegacion(),
      ),
    );
  }
}

class _Navegacion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //obtener la instancia del provider
    final navegacionModel = Provider.of<_NavegacionModel>(context);
    return BottomNavigationBar(
      //escucha el valor de la pagina actual
      currentIndex: navegacionModel.paginaActual,
      //aca se cambia el valor de la pagina actual
      onTap: (i) => navegacionModel.paginaActual = i,
      items: const [
        BottomNavigationBarItem(
            icon: Icon(Icons.person_outline), label: 'persona'),
        BottomNavigationBarItem(icon: Icon(Icons.public), label: 'Encabezado')
      ],
    );
  }
}

class _Paginas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navegacionModel = Provider.of<_NavegacionModel>(context);
    return PageView(
      controller: navegacionModel.pageController,
      scrollDirection: Axis.horizontal,
      //prohibe que se deslice de una pagina a otra
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Container(
          color: Colors.red,
        ),
        Container(
          color: Colors.green,
        ),
      ],
    );
  }
}

//Cunado se le de click a alguno de los botones se redibuje el widget
class _NavegacionModel with ChangeNotifier {
  int _paginaActual = 0;
  PageController _pageController = new PageController(initialPage: 0);

  int get paginaActual => this._paginaActual;

  set paginaActual(int valor) {
    this._paginaActual = valor;
    _pageController.animateToPage(valor,
        duration: Duration(microseconds: 250), curve: Curves.easeInCirc);
    notifyListeners();
  }

  PageController get pageController => this._pageController;
}
