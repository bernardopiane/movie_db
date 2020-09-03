import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_db/JSON/airingToday.dart';
import 'package:movie_db/JSON/movieCredits.dart';
import 'package:movie_db/JSON/movieDetails.dart';
import 'package:movie_db/JSON/movieRecommendations.dart';
import 'package:movie_db/JSON/moviesReviews.dart';
import 'package:movie_db/JSON/peopleDetails.dart';
import 'package:movie_db/JSON/searchQuery.dart';
import 'package:movie_db/JSON/tvCredits.dart';
import 'package:movie_db/JSON/tvDetails.dart';
import 'package:movie_db/JSON/tvRecommendations.dart';
import 'package:movie_db/JSON/tvReviews.dart';
import 'package:movie_db/TopMovie.dart';
import './JSON/moviesTopRatedResults.dart';
import './JSON/moviesPopularResults.dart';
import './JSON/tvPopularResults.dart';
import './JSON/tvTopRatedResults.dart';
import './JSON/playingNowResults.dart';
import 'JSON/airingToday2.dart';

var BASE_URL = "https://api.themoviedb.org/3/";
var API_KEY = "?api_key=e9e768ec8d32ed01c191155118ac2a28";

getPopularMovies(page) async {
  var url = BASE_URL +
      "movie/popular" +
      API_KEY +
      "&language=en-US&page=" +
      page.toString();

  var response = await http.get(url);
  if (response.statusCode == 200) {
    final MoviesPopularResults results =
        MoviesPopularResults.fromJson(json.decode(response.body));
    return results;
  }
}

getTopRatedMovies(page) async {
  var url = BASE_URL +
      "movie/top_rated" +
      API_KEY +
      "&language=en-US&page=" +
      page.toString();

  var response = await http.get(url);
  if (response.statusCode == 200) {
    final MoviesTopRatedResults results =
    MoviesTopRatedResults.fromJson(json.decode(response.body));
    return results;
  }
}

getNewTopRatedMovies(page) async {
  var url = BASE_URL +
      "movie/top_rated" +
      API_KEY +
      "&language=en-US&page=" +
      page.toString();

  var response = await http.get(url);
  if (response.statusCode == 200) {
    final TopMovie results =
    TopMovie.fromJson(json.decode(response.body));
    return results;
  }
}

getPopularTv(page) async {
  var url = BASE_URL +
      "tv/popular" +
      API_KEY +
      "&language=en-US&page=" +
      page.toString();

  var response = await http.get(url);
  if (response.statusCode == 200) {
    final TvPopularResults results =
        TvPopularResults.fromJson(json.decode(response.body));
    return results;
  }
}

getTopRatedTv(page) async {
  var url = BASE_URL +
      "tv/top_rated" +
      API_KEY +
      "&language=en-US&page=" +
      page.toString();

  var response = await http.get(url);
  if (response.statusCode == 200) {
    final TvTopRatedResults results =
        TvTopRatedResults.fromJson(json.decode(response.body));
    return results;
  }
}

getPlayingNow(page) async {
  var url = BASE_URL +
      "movie/now_playing" +
      API_KEY +
      "&language=en-US&page=" +
      page.toString();

  var response = await http.get(url);
  if (response.statusCode == 200) {
    final PlayingNowResults results =
        PlayingNowResults.fromJson(json.decode(response.body));
    return results;
  }
}

getMoviesDetails(String id) async {
  //https://api.themoviedb.org/3/movie/{movie_id}?api_key=e9e768ec8d32ed01c191155118ac2a28&language=en-US
  var url = BASE_URL + "movie/" + id + API_KEY + "&language=en-US";
  var response = await http.get(url);
  if (response.statusCode == 200) {
    final MovieDetails results =
        MovieDetails.fromJson(json.decode(response.body));
    return results;
  }
}

getTvDetails(String id) async {
  //https://api.themoviedb.org/3/movie/{movie_id}?api_key=e9e768ec8d32ed01c191155118ac2a28&language=en-US
  var url = BASE_URL + "tv/" + id + API_KEY + "&language=en-US";
  var response = await http.get(url);
  if (response.statusCode == 200) {
    final TvDetails results = TvDetails.fromJson(json.decode(response.body));
    return results;
  }
}

getTvRecommendation(String id) async {
  var url =
      BASE_URL + "tv/" + id + "/recommendations" + API_KEY + "&language=en-US";
  var response = await http.get(url);
  if (response.statusCode == 200) {
    final TvRecommendations results =
        TvRecommendations.fromJson(json.decode(response.body));
    return results;
  }
}

getMoviesRecommendation(String id) async {
  var url = BASE_URL +
      "movie/" +
      id +
      "/recommendations" +
      API_KEY +
      "&language=en-US";
  var response = await http.get(url);
  if (response.statusCode == 200) {
    final MovieRecommendations results =
        MovieRecommendations.fromJson(json.decode(response.body));
    return results;
  }
}

getMovieReview(String id) async {
  //https://api.themoviedb.org/3/movie/{movie_id}/reviews?api_key=e9e768ec8d32ed01c191155118ac2a28&language=en-US&page=1
  var url = BASE_URL + "movie/" + id + "/reviews" + API_KEY + "&language=en-US";
  var response = await http.get(url);
  if (response.statusCode == 200) {
    final MovieReview results =
        MovieReview.fromJson(json.decode(response.body));
    return results;
  }
}

getTvReview(String id) async {
  //https://api.themoviedb.org/3/tv/{tv_id}/reviews?api_key=e9e768ec8d32ed01c191155118ac2a28&language=en-US&page=1
  var url = BASE_URL + "tv/" + id + "/reviews" + API_KEY + "&language=en-US";
  var response = await http.get(url);
  if (response.statusCode == 200) {
    final TvReview results = TvReview.fromJson(json.decode(response.body));
    return results;
  }
}

searchQuery(String query, String page) async {
  var url = BASE_URL + "search/multi" + API_KEY + "&query=" + query + "&page=" + page;
  var response = await http.get(url);
  if (response.statusCode == 200) {
    final SearchQuery results = SearchQuery.fromJson(json.decode(response.body));
    return results;
  }
}


getPeopleDetails(String id) async {
//  https://api.themoviedb.org/3/person/{person_id}?api_key=<<api_key>>&language=en-US
  var url = BASE_URL + "person/" + id + API_KEY + "&language=en-US";
  var response = await http.get(url);
  if (response.statusCode == 200) {
//    print("Resposta do getdetails: ${response.body}");
    final PeopleDetails results = PeopleDetails.fromJson(json.decode(response.body));
    return results;
  }
}

getMovieCredits(String id) async {
//  https://api.themoviedb.org/3/movie/{person_id}?api_key=<<api_key>>&language=en-US
  var url = BASE_URL + "movie/" + id + "/credits" + API_KEY + "&language=en-US";
  var response = await http.get(url);
  if (response.statusCode == 200) {
//    print("Resposta do getdetails: ${response.body}");
    final MovieCredits results = MovieCredits.fromJson(json.decode(response.body));
    return results;
  }
}


getTvCredits(String id) async {
//  https://api.themoviedb.org/3/movie/{person_id}?api_key=<<api_key>>&language=en-US
  var url = BASE_URL + "tv/" + id + "/credits" + API_KEY + "&language=en-US";
  var response = await http.get(url);
  if (response.statusCode == 200) {
//    print("Resposta do getdetails: ${response.body}");
    final TvCredits results = TvCredits.fromJson(json.decode(response.body));
    return results;
  }
}

getAiringToday(int page) async {
  var url = BASE_URL + "tv/airing_today" + API_KEY + "&language=en-US" + "&page=" + page.toString();
  var response = await http.get(url);
  if (response.statusCode == 200) {
//    print("Resposta do getdetails: ${response.body}");
    final AiringToday2 results = AiringToday2.fromJson(json.decode(response.body));
    return results;
  }
}