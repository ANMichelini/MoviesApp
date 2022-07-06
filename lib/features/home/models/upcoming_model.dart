// To parse this JSON data, do
//
//     final upcomingResponse = upcomingResponseFromMap(jsonString);

import 'dart:convert';

import 'package:peliculasdos/features/home/models/movie_model.dart';

import 'now_playing_model.dart';

class UpcomingModel {
  UpcomingModel({
    required this.dates,
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  Dates dates;
  int page;
  List<Movie> results;
  int totalPages;
  int totalResults;

  factory UpcomingModel.fromJson(String str) =>
      UpcomingModel.fromMap(json.decode(str));

  factory UpcomingModel.fromMap(Map<String, dynamic> json) => UpcomingModel(
        dates: Dates.fromMap(json["dates"]),
        page: json["page"],
        results: List<Movie>.from(json["results"].map((x) => Movie.fromMap(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );
}
