// To parse this JSON data, do
//
//     final searchResponse = searchResponseFromMap(jsonString);

import 'dart:convert';

import 'package:peliculasdos/features/home/models/movie_model.dart';

class SearchModel {
  SearchModel({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  int page;
  List<Movie> results;
  int totalPages;
  int totalResults;

  factory SearchModel.fromJson(String str) =>
      SearchModel.fromMap(json.decode(str));

  factory SearchModel.fromMap(Map<String, dynamic> json) => SearchModel(
        page: json["page"],
        results: List<Movie>.from(json["results"].map((x) => Movie.fromMap(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );
}
