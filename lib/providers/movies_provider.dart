import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movies_app2/helpers/debouncer.dart';
import 'package:movies_app2/models/models.dart';

class MoviesProvider extends ChangeNotifier{

  final String _baseUrl = "api.themoviedb.org";
  final String _appiKey = "a27fc2203f51a1bb39546fb877cdac6a";
  final String _lengauge = "es-ES";
  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];
  int _popularPage = 0;
  Map<int,List<Cast>> moviesCast = {};

  //debouncer
  final debouncer = Debouncer(duration: Duration(milliseconds: 500));

  //implementar stream
  final StreamController<List<Movie>> _streamController = new StreamController.broadcast();
  Stream<List<Movie>> get suggestionStream => this._streamController.stream;


  MoviesProvider(){
    print("Movies provider inicializado");
    getOnDisplayMovies();
    getPopularMovies();
  }


  getOnDisplayMovies() async{
    
    var url = Uri.https(_baseUrl, "3/movie/now_playing",{
      "api_key":_appiKey,
      "language":_lengauge,
      "page":"1"

    });

    //String
    final response = await http.get(url);
    //Mapa
    //final Map<String,dynamic> decodedData = json.decode(response.body);
    final nowPlayingResponse = NowPlayingResponseModel.fromJson(response.body);

    onDisplayMovies = nowPlayingResponse.results;
    notifyListeners();

  }

  getPopularMovies() async{

    _popularPage++;
    
    var url = Uri.https(_baseUrl, "3/movie/popular",{
      "api_key":_appiKey,
      "language":_lengauge,
      "page":"$_popularPage"

    });

    //String
    final response = await http.get(url);
    final popularResponse = PopularResponseModel.fromJson(response.body);

    popularMovies = [...popularMovies,...popularResponse.results];
    print(popularMovies[0]);
    notifyListeners();

  }


  Future<List<Cast>> getMovieCast(int movieId)async{
    
    //validar primero que los actores no estén guardados en el mapa anterioremente
    //para no volver a llamar la petición en caso de que si
    if(moviesCast.containsKey(movieId)){
      return moviesCast[movieId]!;
    }

//    print("Pidiendo información de los actores");

        var url = Uri.https(_baseUrl, "3/movie/$movieId/credits",{
      "api_key":_appiKey,
      "language":_lengauge,
      "page":"$_popularPage"

    });

    final response = await http.get(url);
    final creditResponse = CreditResponse.fromJson(response.body);

    moviesCast[movieId] = creditResponse.cast;

    return creditResponse.cast;

  }

  Future<List<Movie>> searchMovies(String query) async{

    final url = Uri.https(_baseUrl, "3/search/movie",{
    "api_key":_appiKey,
    "language":_lengauge,
    "query":query
    });

    final response = await http.get(url);
    final searchResponse = SearchMovieResponse.fromJson(response.body);

    return searchResponse.results;

  }

  void getSuggestionsByQuery(String query){

    debouncer.value = "";
    debouncer.onValue = (value)async{
      final results = await this.searchMovies(value);
      this._streamController.add(results);

    };
    final timer = Timer.periodic(Duration(milliseconds: 300), (_) { 
      debouncer.value = query;
    });

    Future.delayed(Duration(milliseconds: 301)).then((_) => timer.cancel());

  }


}
