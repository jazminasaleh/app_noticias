import 'package:flutter/material.dart';
import 'package:noticias/src/services/news_service.dart';
import 'package:noticias/src/widgets/lista_noticias.dart';
import 'package:provider/provider.dart';
//Pagina uno de noticias generlaes
class Tab1Page extends StatefulWidget {
  @override
  State<Tab1Page> createState() => _Tab1PageState();
}

class _Tab1PageState extends State<Tab1Page> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    final headlines = Provider.of<NewsService>(context).headlines;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('       Noticias Generales de Colombia ', style: TextStyle(color: Color.fromARGB(255, 12, 2, 56) , fontWeight: FontWeight.bold),),
      ),
      body: (headlines.length == 0)
          ? Center(child: CircularProgressIndicator(),)
          : ListaNoticias(headlines)
    );
  }
  
  @override
  bool get wantKeepAlive => true;
}
