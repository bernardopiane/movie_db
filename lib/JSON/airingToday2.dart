import 'package:flutter/foundation.dart';

import '../data.dart';

class AiringToday2 with ChangeNotifier {
  int page;
  int totalResults;
  int totalPages;
  List<ResultsListBean> results;

  AiringToday2({this.page, this.totalResults, this.totalPages, this.results});

  AiringToday2.fromJson(Map<String, dynamic> json) {    
    this.page = json['page'];
    this.totalResults = json['total_results'];
    this.totalPages = json['total_pages'];
    this.results = (json['results'] as List)!=null?(json['results'] as List).map((i) => ResultsListBean.fromJson(i)).toList():null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['total_results'] = this.totalResults;
    data['total_pages'] = this.totalPages;
    data['results'] = this.results != null?this.results.map((i) => i.toJson()).toList():null;
    return data;
  }


  void changePage(int page){
    this.page = page;
    notifyListeners();
  }

  Future getMoreResults(page) async {

    if(this.results == null)
      this.results = new List<ResultsListBean>();

    var newData = await getAiringToday(page);
    newData.results.forEach((item){
      this.results.add(item);
    });
    notifyListeners();
  }

}

class ResultsListBean {
  String posterPath;
  String backdropPath;
  String overview;
  String firstAirDate;
  String originalLanguage;
  String name;
  String originalName;
  double popularity;
  double voteAverage;
  int id;
  int voteCount;
  List<int> genreIds;
  List<String> originCountry;

  ResultsListBean({this.posterPath, this.backdropPath, this.overview, this.firstAirDate, this.originalLanguage, this.name, this.originalName, this.popularity, this.voteAverage, this.id, this.voteCount, this.genreIds, this.originCountry});

  ResultsListBean.fromJson(Map<String, dynamic> json) {    
    this.posterPath = json['poster_path'];
    this.backdropPath = json['backdrop_path'];
    this.overview = json['overview'];
    this.firstAirDate = json['first_air_date'];
    this.originalLanguage = json['original_language'];
    this.name = json['name'];
    this.originalName = json['original_name'];
    this.popularity = json['popularity'].toDouble();
    this.voteAverage = json['vote_average'].toDouble();
    this.id = json['id'];
    this.voteCount = json['vote_count'];

    List<dynamic> genreIdsList = json['genre_ids'];
    this.genreIds = new List();
    this.genreIds.addAll(genreIdsList.map((o) => int.parse(o.toString())));

    List<dynamic> originCountryList = json['origin_country'];
    this.originCountry = new List();
    this.originCountry.addAll(originCountryList.map((o) => o.toString()));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['poster_path'] = this.posterPath;
    data['backdrop_path'] = this.backdropPath;
    data['overview'] = this.overview;
    data['first_air_date'] = this.firstAirDate;
    data['original_language'] = this.originalLanguage;
    data['name'] = this.name;
    data['original_name'] = this.originalName;
    data['popularity'] = this.popularity;
    data['vote_average'] = this.voteAverage;
    data['id'] = this.id;
    data['vote_count'] = this.voteCount;
    data['genre_ids'] = this.genreIds;
    data['origin_country'] = this.originCountry;
    return data;
  }
}
