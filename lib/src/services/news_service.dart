import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:noticias/src/models/category_model.dart';
import 'package:noticias/src/models/news_models.dart';
import 'package:http/http.dart' as http;

final _URL_NEWS = 'https://newsapi.org/v2';
final _APIKEY = '930d495fd765413f9ef195e94d1324a8';

class NewsService with ChangeNotifier {
  List<Article> headlines = [];
  String _selectedCategory = 'business';
  bool _isLoading = true;
  List<Category> categories = [
    Category(FontAwesomeIcons.building, 'business'),
    Category(FontAwesomeIcons.tv, 'entertainment'),
    Category(FontAwesomeIcons.addressCard, 'general'),
    Category(FontAwesomeIcons.headSideVirus, 'health'),
    Category(FontAwesomeIcons.vials, 'science'),
    Category(FontAwesomeIcons.volleyball, 'sports'),
    Category(FontAwesomeIcons.memory, 'technology'),
  ];

  Map<String, List<Article>> categoryArticles = {};

  NewsService() {
    this.getTopHaedLines();
    categories.forEach((item) {
      this.categoryArticles[item.name] = [];
    });
    this.getArticulesByCategory(this._selectedCategory);
  }

  bool get isLoading => this._isLoading;

  get selectedcategory => this._selectedCategory;

  set selectedCategory(String valor) {
    this._selectedCategory = valor;

    this._isLoading = true;
    this.getArticulesByCategory(valor);
    notifyListeners();
  }

  List<Article>? get getArticulosCategriaSeleccionada =>
      this.categoryArticles[this.selectedcategory];

  getTopHaedLines() async {
    final url =
        Uri.parse('$_URL_NEWS/top-headlines?apiKey=$_APIKEY&country=co');
    final resp = await http.get(url);

    final newsResponse = newsResponseFromJson(resp.body);

    this.headlines.addAll(newsResponse.articles!);

    notifyListeners();
  }

  getArticulesByCategory(String category) async {
    if (this.categoryArticles[category]!.length > 0) {
      this._isLoading = false;
      notifyListeners();
      return this.categoryArticles[category];
    }
    final url = Uri.parse(
        '$_URL_NEWS/top-headlines?apiKey=$_APIKEY&country=co&category=$category');
    final resp = await http.get(url);

    final newsResponse = newsResponseFromJson(resp.body);

    this.categoryArticles[category]!.addAll(newsResponse.articles!);
    this._isLoading = false;
    notifyListeners();
  }
}
