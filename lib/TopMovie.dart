import 'package:flutter/foundation.dart';

import 'data.dart';

class TopMovie extends ChangeNotifier{
  int page = 0;
  int totalResults = 0;
  int totalPages = 0;
  List<ResultsListBean> results = new List<ResultsListBean>();

  TopMovie({this.page, this.totalResults, this.totalPages, this.results});

  TopMovie.fromJson(Map<String, dynamic> json) {    
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

    var newData = await getNewTopRatedMovies(page);
    print(newData.results);
    newData.results.forEach((item){
      this.results.add(item);
    });
    notifyListeners();
  }

}

class ResultsListBean {
  String posterPath;
  String overview;
  String releaseDate;
  String originalTitle;
  String originalLanguage;
  String title;
  String backdropPath;
  bool adult;
  bool video;
  double popularity;
  double voteAverage;
  int id;
  int voteCount;
  List<int> genreIds;

  ResultsListBean({this.posterPath, this.overview, this.releaseDate, this.originalTitle, this.originalLanguage, this.title, this.backdropPath, this.adult, this.video, this.popularity, this.voteAverage, this.id, this.voteCount, this.genreIds});

  ResultsListBean.fromJson(Map<String, dynamic> json) {    
    this.posterPath = json['poster_path'];
    this.overview = json['overview'];
    this.releaseDate = json['release_date'];
    this.originalTitle = json['original_title'];
    this.originalLanguage = json['original_language'];
    this.title = json['title'];
    this.backdropPath = json['backdrop_path'];
    this.adult = json['adult'];
    this.video = json['video'];
    this.popularity = json['popularity'].toDouble();
    this.voteAverage = json['vote_average'].toDouble();
    this.id = json['id'];
    this.voteCount = json['vote_count'];

    List<dynamic> genreIdsList = json['genre_ids'];
    this.genreIds = new List();
    this.genreIds.addAll(genreIdsList.map((o) => int.parse(o.toString())));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['poster_path'] = this.posterPath;
    data['overview'] = this.overview;
    data['release_date'] = this.releaseDate;
    data['original_title'] = this.originalTitle;
    data['original_language'] = this.originalLanguage;
    data['title'] = this.title;
    data['backdrop_path'] = this.backdropPath;
    data['adult'] = this.adult;
    data['video'] = this.video;
    data['popularity'] = this.popularity.toDouble();
    data['vote_average'] = this.voteAverage.toDouble();
    data['id'] = this.id;
    data['vote_count'] = this.voteCount;
    data['genre_ids'] = this.genreIds;
    return data;
  }
}
