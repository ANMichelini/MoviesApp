import 'dart:convert';

import '../../user_collection/models/movie_firebase_model.dart';

class SearchFirebaseModel {
  SearchFirebaseModel({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  int page;
  List<MovieFirebaseModel> results;
  int totalPages;
  int totalResults;

  factory SearchFirebaseModel.fromJson(String str) =>
      SearchFirebaseModel.fromMap(json.decode(str));

  factory SearchFirebaseModel.fromMap(Map<String, dynamic> json) =>
      SearchFirebaseModel(
        page: json["page"],
        results: List<MovieFirebaseModel>.from(
            json["results"].map((x) => MovieFirebaseModel.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );
}
