import 'dart:convert';
import 'package:movies_app2/models/models.dart';





class PopularResponseModel {

    int page;
    List<Movie> results;
    int totalPages;
    int totalResults;

    PopularResponseModel({
      required  this.page,
      required  this.results,
      required  this.totalPages,
      required  this.totalResults,
    });


    factory PopularResponseModel.fromJson(String str) => PopularResponseModel.fromMap(json.decode(str));

    factory PopularResponseModel.fromMap(Map<String, dynamic> json) => PopularResponseModel(
        page: json["page"],
        results: List<Movie>.from(json["results"].map((x) => Movie.fromMap(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
    );


}
