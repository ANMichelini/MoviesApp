// To parse this JSON data, do
//
//     final topRatedResponse = topRatedResponseFromMap(jsonString);

import 'dart:convert';

import 'movie_model.dart';

class TopRatedModel {
  TopRatedModel({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  int page;
  List<Movie> results;
  int totalPages;
  int totalResults;

  factory TopRatedModel.fromJson(String str) =>
      TopRatedModel.fromMap(json.decode(str));

  factory TopRatedModel.fromMap(Map<String, dynamic> json) => TopRatedModel(
        page: json["page"],
        results: List<Movie>.from(json["results"].map((x) => Movie.fromMap(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );
}
