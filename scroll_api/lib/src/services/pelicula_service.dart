import 'package:flutter/widgets.dart';

import 'package:flutter/material.dart';
import 'package:scroll_api/src/model/pelicula_model.dart';
import 'package:http/http.dart' as http;

class PeliculaService with ChangeNotifier {
  String _apikey = 'a1fc912350683ec562080e542a554ec1';
  String _url = 'https://api.themoviedb.org';
  String _language = 'en-US';
  
  List<Pelicula> peli = List();
  int currentPopularPage = 1;
  bool isloading = false;
  int totalPages = 0;
  bool _isfetcheng = false;

  PeliculaService(){
    this.getPelicula();
  }
  getPelicula() async {

    final url =
        '$_url/3/movie/popular?api_key=$_apikey&language=$_language&page=${currentPopularPage.toString()}';
    final respt = await http.get(url);
    
    final decodedResult = popularesFromJson(respt.body);
    
    this.totalPages = decodedResult.totalPages.toInt();
    print(this.totalPages);
    this.peli.addAll(decodedResult.results);
    this.isloading = this.currentPopularPage < this.totalPages;
    notifyListeners();
  }
  getPeliculaNextPage() async {
    if(_isfetcheng){
      return;
    }
    if(currentPopularPage >= totalPages){
      return;
    }
    _isfetcheng = true;
    currentPopularPage++;

    if(currentPopularPage < totalPages){
      final url =
        '$_url/3/movie/popular?api_key=$_apikey&language=$_language&page=${currentPopularPage.toString()}';
    final respt = await http.get(url);
    
    final decodedResult = popularesFromJson(respt.body);
    
    this.peli.addAll(decodedResult.results);
    this.isloading = this.currentPopularPage < this.totalPages;
    }
    _isfetcheng = false;
    notifyListeners();
  }

}
