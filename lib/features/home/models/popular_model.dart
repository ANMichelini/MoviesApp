// To parse this JSON data, do
//
//     final popularResponse = popularResponseFromMap(jsonString);

import 'dart:convert';

import 'movie_model.dart';

class PopularModel {
  PopularModel({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  int page;
  List<Movie> results;
  int totalPages;
  int totalResults;

  factory PopularModel.fromJson(String str) =>
      PopularModel.fromMap(json.decode(str));

  factory PopularModel.fromMap(Map<String, dynamic> json) => PopularModel(
        page: json["page"],
        results: List<Movie>.from(json["results"].map((x) => Movie.fromMap(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );
}
