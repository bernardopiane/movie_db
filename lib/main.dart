import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_db/JSON/moviesPopularResults.dart';
import 'package:movie_db/JSON/searchQuery.dart';
import 'package:movie_db/JSON/tvPopularResults.dart';
import 'package:movie_db/JSON/tvTopRatedResults.dart';
import 'package:provider/provider.dart';

import './JSON/moviesTopRatedResults.dart';
import 'JSON/airingToday.dart';
import 'JSON/airingToday2.dart';
import 'JSON/playingNowResults.dart';
import 'TopMovie.dart';
import 'data.dart';

void main() => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => TopMovie(),
          ),
          ChangeNotifierProvider(
            create: (_) => AiringToday2(),
          ),
          ChangeNotifierProvider(
            create: (_) => MoviesPopularResults(),
          ),
          ChangeNotifierProvider(
            create: (_) => MoviesTopRatedResults(),
          ),
          ChangeNotifierProvider(
            create: (_) => PlayingNowResults(),
          ),
          ChangeNotifierProvider(
            create: (_) => TvPopularResults(),
          ),
          ChangeNotifierProvider(
            create: (_) => TvTopRatedResults(),
          ),
        ],
        child: MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      title: 'Flutter Demo',
      theme: ThemeData(
//        scaffoldBackgroundColor: Color(0xffeeeeee),
//        primarySwatch: Colors.grey,
//          primarySwatch: Color(0xff01d277),
          accentColor: Color(0xff01d277),
          indicatorColor: Color(0xff01d277),
          primaryColor: Color(0xff01d277),
          primaryTextTheme: TextTheme(title: TextStyle(color: Colors.black))),
//      home: MyHomePage(title: 'Flutter Demo Home Page'),
      color: Color(0xff01d277),
      home: MainMenu(),
    );
  }
}

class MainMenu extends StatefulWidget {
  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  var _nowPlaying;
  var _airingToday;
  var _mostPopularTv;
  var _mostPopularMovie;

  var _queryController = TextEditingController();

  @override
  void initState() {
    setState(() {
      _nowPlaying = _getNowPlaying();
      _airingToday = _getAiringToday();
      _mostPopularTv = _getMostPopularTv();
      _mostPopularMovie = _getMostPopularMovie();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
//          gradient: LinearGradient(
//            // Where the linear gradient begins and ends
//            end: Alignment.topLeft,
//            begin: Alignment.bottomRight,
//            // Add one stop for each color. Stops should increase from 0 to 1
////            stops: [0.1, 0.5, 0.7, 0.9],
//            colors: [
//              // Colors are easy thanks to Flutter's Colors class.
//              Color(0xfffff5ff),
//              Color(0xfff6f6f8),
//              Color(0xffedeef0),
//              Color(0xffe4e5e9),
//              Color(0xffdadde2),
////              Colors.indigo[800],
////              Colors.indigo[700],
////              Colors.indigo[600],
////              Colors.indigo[400],
//            ],
//          ),
            ),
        child: SafeArea(
          child: CustomScrollView(
            slivers: <Widget>[
              new MyAppBar(),
              SliverList(
                delegate: SliverChildListDelegate(<Widget>[
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => (AiringTodayPage())),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Airing Today",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          Icon(
                            Icons.arrow_forward,
                            size: 28,
                          ),
                        ],
                      ),
                    ),
                  ), //Airing today
                  new AiringTodayWidget(),
                  SizedBox(
                    height: 8,
                  ),
                  new BigCard(mostPopular: _mostPopularTv, isTv: true),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => (NowPlaying())),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "On Theathers Now",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          Icon(
                            Icons.arrow_forward,
                            size: 28,
                          ),
                        ],
                      ),
                    ),
                  ),
                  new OnTheatherNowWidget(),
                  new BigCard(
                    mostPopular: _mostPopularMovie,
                    isTv: false,
                  ),
                  SizedBox(
                    height: 300,
                  ),
                  RaisedButton(
                    child: Text("Top Rated Movies"),
                    onPressed: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => (NewTopMovie())),
                      );
                    },
                  ),
                  RaisedButton(
                    child: Text("Top Rated Movies"),
                    onPressed: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => (MoviesTopRated())),
                      );
                    },
                  ),
                  RaisedButton(
                    child: Text("Popular Tv"),
                    onPressed: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(builder: (context) => (TvPopular())),
                      );
                    },
                  ),
                  RaisedButton(
                    child: Text("Popular Movies"),
                    onPressed: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => (MoviesPopular())),
                      );
                    },
                  ),
                  RaisedButton(
                    child: Text("Playing Now"),
                    onPressed: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => (NowPlaying())),
                      );
                    },
                  ),
                ]),
              ),
            ],
          ),
//          child: ListView(
//            children: <Widget>[
//              Column(
//                children: <Widget>[
//                  Container(
////                  color: Colors.white,
//                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
//                    child: Container(
//                      decoration: BoxDecoration(
//                        color: Colors.white,
//                        boxShadow: [
//                          BoxShadow(
//                            color: Colors.black12,
//                            blurRadius:
//                                10.0, // has the effect of softening the shadow
//                            spreadRadius:
//                                2.0, // has the effect of extending the shadow
//                          )
//                        ],
//                      ),
//                      child: TextField(
//                        controller: _queryController,
//                        decoration: InputDecoration(
//                          suffixIcon: InkWell(
//                            borderRadius: BorderRadius.circular(100),
//                            child: Icon(Icons.search),
//                            onTap: () {
//                              if (_queryController.text.isNotEmpty) {
//                                Navigator.push(
//                                  context,
//                                  CupertinoPageRoute(
//                                    builder: (context) => (QueryScreen(
//                                        query: _queryController.text)),
//                                  ),
//                                );
//                              }
//                            },
//                          ),
//                          alignLabelWithHint: true,
//                          border: InputBorder.none,
//                          hintText: 'Enter a search term',
//                          contentPadding: EdgeInsets.all(16.0),
//                        ),
//                        onSubmitted: (value) {
//                          Navigator.push(
//                            context,
//                            CupertinoPageRoute(
//                                builder: (context) =>
//                                    (QueryScreen(query: value))),
//                          );
//                        },
//                      ),
//                    ),
//                  ),
//                  InkWell(
//                    onTap: () {
//                      Navigator.push(
//                        context,
//                        CupertinoPageRoute(
//                            builder: (context) => (AiringTodayPage())),
//                      );
//                    },
//                    child: Padding(
//                      padding: const EdgeInsets.all(16.0),
//                      child: Row(
//                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                        children: <Widget>[
//                          Text(
//                            "Airing Today",
//                            style: TextStyle(
//                                fontWeight: FontWeight.bold, fontSize: 18),
//                          ),
//                          Icon(
//                            Icons.arrow_forward,
//                            size: 28,
//                          ),
//                        ],
//                      ),
//                    ),
//                  ),//Airing today
//                  Container(
//                    height: 200,
//                    child: FutureBuilder(
//                      future: _airingToday,
//                      builder: (context, snapshot) {
//                        if (snapshot.connectionState ==
//                                ConnectionState.waiting ||
//                            snapshot.connectionState ==
//                                ConnectionState.active) {
//                          return Center(child: CircularProgressIndicator());
//                        }
//
//                        if (snapshot.hasData) {
//                          List<Widget> lista = new List<Widget>();
//                          lista.add(
//                            SizedBox(
//                              width: 12,
//                            ),
//                          );
//                          for (int i = 0; i < 10; i++) {
//                            lista.add(
//                              GestureDetector(
//                                onTap: () {
//                                  Navigator.push(
//                                    context,
//                                    CupertinoPageRoute(
//                                      builder: (context) => (TvDetails(
//                                          name: snapshot.data.results
//                                              .elementAt(i)
//                                              .name,
//                                          id: snapshot.data.results
//                                              .elementAt(i)
//                                              .id)),
//                                    ),
//                                  );
//                                },
//                                child: Poster(
//                                  height: 200.0,
//                                  path: snapshot.data.results
//                                      .elementAt(i)
//                                      .posterPath,
//                                  imageUrl: "https://image.tmdb.org/t/p/w500/" +
//                                      snapshot.data.results
//                                          .elementAt(i)
//                                          .posterPath,
//                                ),
//                              ),
//                            );
//                            lista.add(SizedBox(
//                              width: 12,
//                            ));
//                          }
//                          return new ListView(
//                            scrollDirection: Axis.horizontal,
//                            children: lista,
//                          );
//                        } else {
//                          return Center(
//                            child: new Text(
//                              snapshot.toString(),
//                            ),
//                          );
//                        }
//                      },
//                    ),
//                  ),
//                  SizedBox(
//                    height: 32,
//                  ),
//                  InkWell(
//                    onTap: () {
//                      Navigator.push(
//                        context,
//                        CupertinoPageRoute(
//                            builder: (context) => (NowPlaying())),
//                      );
//                    },
//                    child: Padding(
//                      padding: const EdgeInsets.all(16.0),
//                      child: Row(
//                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                        children: <Widget>[
//                          Text(
//                            "On Theathers Now",
//                            style: TextStyle(
//                                fontWeight: FontWeight.bold, fontSize: 18),
//                          ),
//                          Icon(
//                            Icons.arrow_forward,
//                            size: 28,
//                          ),
//                        ],
//                      ),
//                    ),
//                  ),
//                  Container(
//                    height: 200,
//                    child: FutureBuilder(
//                      future: _nowPlaying,
//                      builder: (context, snapshot) {
//                        if (snapshot.connectionState ==
//                                ConnectionState.waiting ||
//                            snapshot.connectionState ==
//                                ConnectionState.active) {
//                          return Center(child: CircularProgressIndicator());
//                        }
//
//                        if (snapshot.hasData) {
//                          List<Widget> lista = new List<Widget>();
//                          lista.add(
//                            SizedBox(
//                              width: 12,
//                            ),
//                          );
//                          for (int i = 0; i < 10; i++) {
//                            lista.add(
//                              GestureDetector(
//                                onTap: () {
//                                  Navigator.push(
//                                    context,
//                                    CupertinoPageRoute(
//                                      builder: (context) => (MovieDetails(
//                                          name: snapshot.data.results
//                                              .elementAt(i)
//                                              .title,
//                                          id: snapshot.data.results
//                                              .elementAt(i)
//                                              .id)),
//                                    ),
//                                  );
//                                },
//                                child: Poster(
//                                  height: 200.0,
//                                  path: snapshot.data.results
//                                      .elementAt(i)
//                                      .posterPath,
//                                  imageUrl: "https://image.tmdb.org/t/p/w500/" +
//                                      snapshot.data.results
//                                          .elementAt(i)
//                                          .posterPath,
//                                ),
//                              ),
//                            );
//                            lista.add(SizedBox(
//                              width: 12,
//                            ));
//                          }
//                          return new ListView(
//                            scrollDirection: Axis.horizontal,
//                            children: lista,
//                          );
//                        } else {
//                          return Center(
//                            child: new Text(
//                              snapshot.toString(),
//                            ),
//                          );
//                        }
//                      },
//                    ),
//                  ),
//                  RaisedButton(
//                    child: Text("Top Rated Movies"),
//                    onPressed: () {
//                      Navigator.push(
//                        context,
//                        CupertinoPageRoute(
//                            builder: (context) => (MoviesTopRated())),
//                      );
//                    },
//                  ),
//                  RaisedButton(
//                    child: Text("Popular Tv"),
//                    onPressed: () {
//                      Navigator.push(
//                        context,
//                        CupertinoPageRoute(builder: (context) => (TvPopular())),
//                      );
//                    },
//                  ),
//                  RaisedButton(
//                    child: Text("Popular Movies"),
//                    onPressed: () {
//                      Navigator.push(
//                        context,
//                        CupertinoPageRoute(
//                            builder: (context) => (MoviesPopular())),
//                      );
//                    },
//                  ),
//                  RaisedButton(
//                    child: Text("Playing Now"),
//                    onPressed: () {
//                      Navigator.push(
//                        context,
//                        CupertinoPageRoute(
//                            builder: (context) => (NowPlaying())),
//                      );
//                    },
//                  ),
//                ],
//              ),
//            ],
//          ),
        ),
      ),
    );
  }

  _getNowPlaying() {
//    setState(() {
//      _nowPlaying = getPlayingNow(1);
//    });
    return getPlayingNow(1);
  }

  _getAiringToday() {
//    setState(() {
//      _airingToday = getAiringToday(1);
//    });
    return getAiringToday(1);
  }

  _getMostPopularTv() {
//    setState(() {
//      _mostPopularTv = getPopularTv(2);
//    });
    return getPopularTv(2);
  }

  _getMostPopularMovie() {
//    setState(() {
//      _mostPopularMovie = getPopularMovies(2);
//    });
    return getPopularMovies(2);
  }
}

class OnTheatherNowWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: Consumer<PlayingNowResults>(
        builder: (ctx, nowPlaying, child) {
          if (nowPlaying == null || nowPlaying.results == null) {
            nowPlaying.getMoreResults(1);
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          List<Widget> lista = new List<Widget>();
          lista.add(
            SizedBox(
              width: 12,
            ),
          );
          for (int i = 0; i < 10; i++) {
            lista.add(
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => (MovieDetails(
                          name: nowPlaying.results.elementAt(i).title,
                          id: nowPlaying.results.elementAt(i).id)),
                    ),
                  );
                },
                child: Poster(
                  height: 200.0,
                  path: nowPlaying.results.elementAt(i).posterPath,
                  imageUrl: "https://image.tmdb.org/t/p/w500/" +
                      nowPlaying.results.elementAt(i).posterPath,
                ),
              ),
            );
            lista.add(SizedBox(
              width: 12,
            ));
          }
          return nowPlaying.results == null
              ? Center(child: CircularProgressIndicator())
              : ListView(
            children: lista,
            scrollDirection: Axis.horizontal,
          );
        },
//                      child: FutureBuilder(
//                        future: _airingToday,
//                        builder: (context, snapshot) {
//                          if (snapshot.connectionState ==
//                                  ConnectionState.waiting ||
//                              snapshot.connectionState ==
//                                  ConnectionState.active) {
//                            return Center(child: CircularProgressIndicator());
//                          }
//
//                          if (snapshot.hasData) {
//                            List<Widget> lista = new List<Widget>();
//                            lista.add(
//                              SizedBox(
//                                width: 12,
//                              ),
//                            );
//                            for (int i = 0; i < 10; i++) {
//                              lista.add(
//                                GestureDetector(
//                                  onTap: () {
//                                    Navigator.push(
//                                      context,
//                                      CupertinoPageRoute(
//                                        builder: (context) => (TvDetails(
//                                            name: snapshot.data.results
//                                                .elementAt(i)
//                                                .name,
//                                            id: snapshot.data.results
//                                                .elementAt(i)
//                                                .id)),
//                                      ),
//                                    );
//                                  },
//                                  child: Poster(
//                                    height: 200.0,
//                                    path: snapshot.data.results
//                                        .elementAt(i)
//                                        .posterPath,
//                                    imageUrl: "https://image.tmdb.org/t/p/w500/" +
//                                        snapshot.data.results
//                                            .elementAt(i)
//                                            .posterPath,
//                                  ),
//                                ),
//                              );
//                              lista.add(SizedBox(
//                                width: 12,
//                              ));
//                            }
//                            return new ListView(
//                              scrollDirection: Axis.horizontal,
//                              children: lista,
//                            );
//                          } else {
//                            return Center(
//                              child: new Text(
//                                snapshot.toString(),
//                              ),
//                            );
//                          }
//                        },
//                      ),
      ),

//        child: FutureBuilder(
//          future: _nowPlaying,
//          builder: (context, snapshot) {
//            if (snapshot.connectionState == ConnectionState.waiting ||
//                snapshot.connectionState == ConnectionState.active) {
//              return Center(child: CircularProgressIndicator());
//            }
//
//            if (snapshot.hasData) {
//              List<Widget> lista = new List<Widget>();
//              lista.add(
//                SizedBox(
//                  width: 12,
//                ),
//              );
//              for (int i = 0; i < 10; i++) {
//                lista.add(
//                  GestureDetector(
//                    onTap: () {
//                      Navigator.push(
//                        context,
//                        CupertinoPageRoute(
//                          builder: (context) => (MovieDetails(
//                              name: snapshot.data.results.elementAt(i).title,
//                              id: snapshot.data.results.elementAt(i).id)),
//                        ),
//                      );
//                    },
//                    child: Poster(
//                      height: 200.0,
//                      path: snapshot.data.results.elementAt(i).posterPath,
//                      imageUrl: "https://image.tmdb.org/t/p/w500/" +
//                          snapshot.data.results.elementAt(i).posterPath,
//                    ),
//                  ),
//                );
//                lista.add(SizedBox(
//                  width: 12,
//                ));
//              }
//              return new ListView(
//                scrollDirection: Axis.horizontal,
//                children: lista,
//              );
//            } else {
//              return Center(
//                child: new Text(
//                  snapshot.toString(),
//                ),
//              );
//            }
//          },
//        ),
      );
  }
}

class AiringTodayWidget extends StatelessWidget {
  const AiringTodayWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: Consumer<AiringToday2>(
        builder: (ctx, airingToday, child) {
          if (airingToday == null || airingToday.results == null) {
            airingToday.getMoreResults(1);
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          List<Widget> lista = new List<Widget>();
          lista.add(
            SizedBox(
              width: 12,
            ),
          );
          for (int i = 0; i < 10; i++) {
            lista.add(
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => (TvDetails(
                          name: airingToday.results.elementAt(i).name,
                          id: airingToday.results.elementAt(i).id)),
                    ),
                  );
                },
                child: Poster(
                  height: 200.0,
                  path: airingToday.results.elementAt(i).posterPath,
                  imageUrl: "https://image.tmdb.org/t/p/w500/" +
                      airingToday.results.elementAt(i).posterPath,
                ),
              ),
            );
            lista.add(SizedBox(
              width: 12,
            ));
          }
          return airingToday.results == null
              ? Center(child: CircularProgressIndicator())
              : ListView(
                  children: lista,
                  scrollDirection: Axis.horizontal,
                );
//                          return Container();
        },
//                      child: FutureBuilder(
//                        future: _airingToday,
//                        builder: (context, snapshot) {
//                          if (snapshot.connectionState ==
//                                  ConnectionState.waiting ||
//                              snapshot.connectionState ==
//                                  ConnectionState.active) {
//                            return Center(child: CircularProgressIndicator());
//                          }
//
//                          if (snapshot.hasData) {
//                            List<Widget> lista = new List<Widget>();
//                            lista.add(
//                              SizedBox(
//                                width: 12,
//                              ),
//                            );
//                            for (int i = 0; i < 10; i++) {
//                              lista.add(
//                                GestureDetector(
//                                  onTap: () {
//                                    Navigator.push(
//                                      context,
//                                      CupertinoPageRoute(
//                                        builder: (context) => (TvDetails(
//                                            name: snapshot.data.results
//                                                .elementAt(i)
//                                                .name,
//                                            id: snapshot.data.results
//                                                .elementAt(i)
//                                                .id)),
//                                      ),
//                                    );
//                                  },
//                                  child: Poster(
//                                    height: 200.0,
//                                    path: snapshot.data.results
//                                        .elementAt(i)
//                                        .posterPath,
//                                    imageUrl: "https://image.tmdb.org/t/p/w500/" +
//                                        snapshot.data.results
//                                            .elementAt(i)
//                                            .posterPath,
//                                  ),
//                                ),
//                              );
//                              lista.add(SizedBox(
//                                width: 12,
//                              ));
//                            }
//                            return new ListView(
//                              scrollDirection: Axis.horizontal,
//                              children: lista,
//                            );
//                          } else {
//                            return Center(
//                              child: new Text(
//                                snapshot.toString(),
//                              ),
//                            );
//                          }
//                        },
//                      ),
      ),
    );
  }
}

class BigCard extends StatelessWidget {
  const BigCard({
    Key key,
    @required mostPopular,
    this.isTv,
  })  : _mostPopular = mostPopular,
        super(key: key);

  final _mostPopular;
  final isTv;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _mostPopular,
      builder: (BuildContext context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.active:
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator());
          case ConnectionState.done:
            if (snapshot.hasError) return Text('Error: ${snapshot.error}');
            var rng = new Random();
            var randomItem = rng.nextInt(snapshot.data.results.length);

            if (isTv) {
              return Container(
                padding: const EdgeInsets.all(16.0),
                height: 256,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => (TvDetails(
                            name: snapshot.data.results
                                .elementAt(randomItem)
                                .name,
                            id: snapshot.data.results
                                .elementAt(randomItem)
                                .id)),
                      ),
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Stack(
                      overflow: Overflow.visible,
                      fit: StackFit.expand,
                      children: <Widget>[
                        Image.network(
                          "https://image.tmdb.org/t/p/w500/" +
                              snapshot.data.results
                                  .elementAt(randomItem)
                                  .posterPath,
                          fit: BoxFit.cover,
                          alignment: Alignment.center,
                        ),
                        Container(
                          height: 256.0,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            gradient: LinearGradient(
                              begin: FractionalOffset.topLeft,
                              end: FractionalOffset.bottomRight,
                              colors: [
                                Colors.transparent,
                                Colors.black,
                              ],
                              stops: [0.0, 1.0],
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              snapshot.data.results.elementAt(randomItem).name,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return Container(
                padding: const EdgeInsets.all(16.0),
                height: 256,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => (MovieDetails(
                            name: snapshot.data.results
                                .elementAt(randomItem)
                                .title,
                            id: snapshot.data.results
                                .elementAt(randomItem)
                                .id)),
                      ),
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Stack(
                      overflow: Overflow.visible,
                      fit: StackFit.expand,
                      children: <Widget>[
                        Image.network(
                          "https://image.tmdb.org/t/p/w500/" +
                              snapshot.data.results
                                  .elementAt(randomItem)
                                  .posterPath,
                          fit: BoxFit.cover,
                          alignment: Alignment.center,
                        ),
                        Container(
                          height: 256.0,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            gradient: LinearGradient(
                              begin: FractionalOffset.topLeft,
                              end: FractionalOffset.bottomRight,
                              colors: [
                                Colors.transparent,
                                Colors.black,
                              ],
                              stops: [0.0, 1.0],
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              snapshot.data.results.elementAt(randomItem).title,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }
        }
        return null; // unreachable
      },
    );
  }
}

class MyAppBar extends StatefulWidget {
  @override
  _MyAppBarState createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {
  var _queryController;

  @override
  void initState() {
    // TODO: implement initState
    _queryController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _queryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      elevation: 5,
      forceElevated: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//      backgroundColor: Color(0xff01d277),
      snap: true,
      floating: true,
      primary: true,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text("Movies Database"),
          Expanded(
            child: TextField(
              controller: _queryController,
              decoration: InputDecoration(
                suffixIcon: InkWell(
                  borderRadius: BorderRadius.circular(100),
                  child: Icon(Icons.search),
                  onTap: () {
                    if (_queryController.text.isNotEmpty) {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) =>
                              (QueryScreen(query: _queryController.text)),
                        ),
                      );
                    }
                  },
                ),
                alignLabelWithHint: true,
                border: InputBorder.none,
                hintText: 'Enter a search term',
                contentPadding: EdgeInsets.all(16.0),
              ),
              onSubmitted: (value) {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (context) => (QueryScreen(query: value))),
                );
              },
            ),
          ),
        ],
      ),
//                title: Padding(
//                  padding: const EdgeInsets.all(8.0),
//                  child: Container(
//                    decoration: BoxDecoration(
////                      color: Colors.white,
////                      boxShadow: [
////                        BoxShadow(
////                          color: Colors.black12,
////                          blurRadius:
////                              10.0, // has the effect of softening the shadow
////                          spreadRadius:
////                              2.0, // has the effect of extending the shadow
////                        )
////                      ],
//                    ),
//                    child: TextField(
//                      controller: _queryController,
//                      decoration: InputDecoration(
//                        suffixIcon: InkWell(
//                          borderRadius: BorderRadius.circular(100),
//                          child: Icon(Icons.search),
//                          onTap: () {
//                            if (_queryController.text.isNotEmpty) {
//                              Navigator.push(
//                                context,
//                                CupertinoPageRoute(
//                                  builder: (context) => (QueryScreen(
//                                      query: _queryController.text)),
//                                ),
//                              );
//                            }
//                          },
//                        ),
//                        alignLabelWithHint: true,
//                        border: InputBorder.none,
//                        hintText: 'Enter a search term',
//                        contentPadding: EdgeInsets.all(16.0),
//                      ),
//                      onSubmitted: (value) {
//                        Navigator.push(
//                          context,
//                          CupertinoPageRoute(
//                              builder: (context) =>
//                                  (QueryScreen(query: value))),
//                        );
//                      },
//                    ),
//                  ),
//                ),
    );
  }
}

class AiringTodayPage extends StatefulWidget {
  @override
  _AiringTodayPageState createState() => _AiringTodayPageState();
}

class _AiringTodayPageState extends State<AiringTodayPage> {
  var data;
  var _opacity = 0.0;
  bool isLoading = true;

  ScrollController _controller;

  var lastPage;

  int page;

  @override
  void initState() {
    _controller = new ScrollController()..addListener(_scrollListener);
//    data = new AiringToday();
//    setInitialData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AiringToday2>(builder: (ctx, airingToday, child) {
        if (airingToday == null || airingToday.results == null) {
          airingToday.getMoreResults(1);
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return airingToday.results == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : GridView.builder(
                gridDelegate: new SliverGridDelegateWithMaxCrossAxisExtent(
                    childAspectRatio: 2 / 3.5,
                    maxCrossAxisExtent: 250,
                    mainAxisSpacing: 8.0,
                    crossAxisSpacing: 8.0),
                itemCount: airingToday.results.length,
                padding: EdgeInsets.all(8.0),
                controller: _controller,
                itemBuilder: (context, index) {
                  return GridTile(
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Stack(
                              fit: StackFit.expand,
                              children: <Widget>[
                                Poster(
                                  height: 200.0,
                                  path: airingToday.results
                                      .elementAt(index)
                                      .posterPath,
                                  imageUrl: "https://image.tmdb.org/t/p/w500/" +
                                      airingToday.results
                                          .elementAt(index)
                                          .posterPath,
                                ),
                                Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                          builder: (context) => (TvDetails(
                                              name: airingToday.results
                                                  .elementAt(index)
                                                  .name,
                                              id: airingToday.results
                                                  .elementAt(index)
                                                  .id)),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              airingToday.results.elementAt(index).name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
      }),
    );
    return OrientationBuilder(
      builder: (context, orientation) {
        return Scaffold(
          body: SafeArea(
            child: Stack(
              children: <Widget>[
                FutureBuilder(
                  future: _getData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting ||
                        snapshot.connectionState == ConnectionState.active) {
                      return Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasData) {
                      return GridView.builder(
                        gridDelegate:
                            new SliverGridDelegateWithMaxCrossAxisExtent(
                                childAspectRatio: 2 / 3.5,
                                maxCrossAxisExtent: 250,
                                mainAxisSpacing: 8.0,
                                crossAxisSpacing: 8.0),
                        itemCount: snapshot.data.results.length,
                        padding: EdgeInsets.all(8.0),
                        controller: _controller,
                        itemBuilder: (context, index) {
                          return GridTile(
                            child: Column(
                              children: <Widget>[
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Stack(
                                      fit: StackFit.expand,
                                      children: <Widget>[
                                        Poster(
                                          height: 200.0,
                                          path: snapshot.data.results
                                              .elementAt(index)
                                              .posterPath,
                                          imageUrl:
                                              "https://image.tmdb.org/t/p/w500/" +
                                                  snapshot.data.results
                                                      .elementAt(index)
                                                      .posterPath,
                                        ),
                                        Material(
                                          color: Colors.transparent,
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                CupertinoPageRoute(
                                                  builder: (context) =>
                                                      (TvDetails(
                                                          name: snapshot
                                                              .data.results
                                                              .elementAt(index)
                                                              .name,
                                                          id: snapshot
                                                              .data.results
                                                              .elementAt(index)
                                                              .id)),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      snapshot.data.results
                                          .elementAt(index)
                                          .name,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    } else {
                      return Center(
                        child: Text("Empty"),
                      );
                    }
                  },
                ),
                isLoading
                    ? AnimatedOpacity(
                        opacity: _opacity,
                        duration: Duration(milliseconds: 225),
                        child: Container(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: new Color.fromRGBO(255, 255, 255, 0.8),
                          ),
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      )
                    : AnimatedOpacity(
                        duration: Duration(milliseconds: 225),
                        opacity: _opacity,
                        child: Container()),
              ],
            ),
          ),
        );
      },
    );
  }

  Future _getMoreResults() async {
    setState(() {
      isLoading = true;
      _opacity = 1.0;
      page = Provider.of<AiringToday2>(context).page + 1;
//      page = page + 1;
    });
//    AiringToday rs = await getAiringToday(page);
//    var temp = data;
//    temp.then((item) {
//      setState(() {
//        lastPage = rs.totalPages;
//      });
//      rs.results.forEach((f) {
//        item.results.add(f);
//      });
//    });
    await Provider.of<AiringToday2>(context).getMoreResults(page);
    setState(() {
      _opacity = 0.0;
      isLoading = false;
    });
  }

  _getData() {
    return data;
  }

  void setInitialData() {
    setState(() {
      data = getAiringToday(page);
      isLoading = false;
    });
  }

  void _scrollListener() {
    if (page != lastPage) {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        _getMoreResults();
      }
    }
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5.0,
        title: Text(widget.title),
      ),
      body: SafeArea(
        child: Center(
          child: TvTopRated(),
        ),
      ),
    );
  }
}

class MoviesTopRated extends StatefulWidget {
  @override
  _MoviesTopRatedState createState() => _MoviesTopRatedState();
}

class _MoviesTopRatedState extends State<MoviesTopRated> {
  var data;
  var page = 1;
  var _opacity = 0.0;
  bool isLoading = true;

  ScrollController _controller;

  @override
  void initState() {
    _controller = new ScrollController()..addListener(_scrollListener);
    data = new MoviesTopRatedResults();
    setInitialData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            FutureBuilder(
              future: _getData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting ||
                    snapshot.connectionState == ConnectionState.active) {
                  return Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasData) {
                  return GridView.builder(
//                    gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
//                        childAspectRatio: 2 / 3.5,
//                        crossAxisCount: 2,
//                        mainAxisSpacing: 8.0,
//                        crossAxisSpacing: 8.0),
                    gridDelegate: new SliverGridDelegateWithMaxCrossAxisExtent(
                        childAspectRatio: 2 / 3.5,
                        maxCrossAxisExtent: 250,
                        mainAxisSpacing: 8.0,
                        crossAxisSpacing: 8.0),
                    itemCount: snapshot.data.results.length,
                    padding: EdgeInsets.all(8.0),
                    controller: _controller,
                    itemBuilder: (context, index) {
                      return GridTile(
                        child: Column(
                          children: <Widget>[
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Stack(
                                  fit: StackFit.expand,
                                  children: <Widget>[
                                    Poster(
                                      height: 200.0,
                                      path: snapshot.data.results
                                          .elementAt(index)
                                          .posterPath,
                                      imageUrl:
                                          "https://image.tmdb.org/t/p/w500/" +
                                              snapshot.data.results
                                                  .elementAt(index)
                                                  .posterPath,
                                    ),
                                    Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            CupertinoPageRoute(
                                              builder: (context) =>
                                                  (MovieDetails(
                                                      name: snapshot
                                                          .data.results
                                                          .elementAt(index)
                                                          .title,
                                                      id: snapshot.data.results
                                                          .elementAt(index)
                                                          .id)),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  snapshot.data.results.elementAt(index).title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                } else {
                  return Center(
                    child: Text("Empty"),
                  );
                }
              },
            ),
            AnimatedOpacity(
              opacity: _opacity,
              duration: Duration(milliseconds: 225),
              child: isLoading
                  ? Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: new Color.fromRGBO(255, 255, 255, 0.8),
                      ),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : Container(),
            ),
          ],
        ),
      ),
    );
  }

  Future _getMoreResults() async {
    setState(() {
      isLoading = true;
      _opacity = 1.0;
    });
    MoviesTopRatedResults rs = await getTopRatedMovies(page + 1);
    var temp = data;
    temp.then((item) {
      rs.results.forEach((f) {
        item.results.add(f);
      });
    });
    setState(() {
      _opacity = 0.0;
      data = temp;
      page = page + 1;
      isLoading = false;
    });
  }

  _getData() {
    return data;
  }

  void setInitialData() {
    setState(() {
      data = getTopRatedMovies(page);
      isLoading = false;
    });
  }

  void _scrollListener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      _getMoreResults();
    }
  }
}

class TvTopRated extends StatefulWidget {
  @override
  _TvTopRatedState createState() => _TvTopRatedState();
}

class _TvTopRatedState extends State<TvTopRated> {
  var data;
  var page = 1;
  var _opacity = 0.0;
  bool isLoading = true;

  ScrollController _controller;

  @override
  void initState() {
    _controller = new ScrollController()..addListener(_scrollListener);
    data = new TvTopRatedResults();
    setInitialData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            FutureBuilder(
              future: _getData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting ||
                    snapshot.connectionState == ConnectionState.active) {
                  return Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasData) {
                  return GridView.builder(
                    gridDelegate: new SliverGridDelegateWithMaxCrossAxisExtent(
                        childAspectRatio: 2 / 3.5,
                        maxCrossAxisExtent: 250,
                        mainAxisSpacing: 8.0,
                        crossAxisSpacing: 8.0),
                    itemCount: snapshot.data.results.length,
                    padding: EdgeInsets.all(8.0),
                    controller: _controller,
                    itemBuilder: (context, index) {
                      return GridTile(
                        child: Column(
                          children: <Widget>[
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Stack(
                                  fit: StackFit.expand,
                                  children: <Widget>[
                                    Poster(
                                      height: 200.0,
                                      path: snapshot.data.results
                                          .elementAt(index)
                                          .posterPath,
                                      imageUrl:
                                          "https://image.tmdb.org/t/p/w500/" +
                                              snapshot.data.results
                                                  .elementAt(index)
                                                  .posterPath,
                                    ),
                                    Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            CupertinoPageRoute(
                                              builder: (context) => (TvDetails(
                                                  name: snapshot.data.results
                                                      .elementAt(index)
                                                      .name,
                                                  id: snapshot.data.results
                                                      .elementAt(index)
                                                      .id)),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  snapshot.data.results.elementAt(index).name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                } else {
                  return Center(
                    child: Text("Empty"),
                  );
                }
              },
            ),
            isLoading
                ? AnimatedOpacity(
                    opacity: _opacity,
                    duration: Duration(milliseconds: 225),
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: new Color.fromRGBO(255, 255, 255, 0.8),
                      ),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  )
                : AnimatedOpacity(
                    duration: Duration(milliseconds: 225),
                    opacity: _opacity,
                    child: Container()),
          ],
        ),
      ),
    );
  }

  Future _getMoreResults() async {
    setState(() {
      isLoading = true;
      _opacity = 1.0;
    });
    TvTopRatedResults rs = await getTopRatedTv(page + 1);
    var temp = data;
    temp.then((item) {
      rs.results.forEach((f) {
        item.results.add(f);
      });
    });
    setState(() {
      _opacity = 0.0;
      data = temp;
      page = page + 1;
      isLoading = false;
    });
  }

  _getData() {
    return data;
  }

  void setInitialData() {
    setState(() {
      data = getTopRatedTv(page);
      isLoading = false;
    });
  }

  void _scrollListener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      _getMoreResults();
    }
  }
}

class TvPopular extends StatefulWidget {
  @override
  _TvPopularState createState() => _TvPopularState();
}

class _TvPopularState extends State<TvPopular> {
  var data;
  var page = 1;
  var _opacity = 0.0;
  bool isLoading = true;

  ScrollController _controller;

  @override
  void initState() {
    _controller = new ScrollController()..addListener(_scrollListener);
    data = new TvPopularResults();
    setInitialData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            FutureBuilder(
              future: _getData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting ||
                    snapshot.connectionState == ConnectionState.active) {
                  return Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasData) {
                  return GridView.builder(
                    gridDelegate: new SliverGridDelegateWithMaxCrossAxisExtent(
                        childAspectRatio: 2 / 3.5,
                        maxCrossAxisExtent: 250,
                        mainAxisSpacing: 8.0,
                        crossAxisSpacing: 8.0),
                    itemCount: snapshot.data.results.length,
                    padding: EdgeInsets.all(8.0),
                    controller: _controller,
                    itemBuilder: (context, index) {
                      return GridTile(
                        child: Column(
                          children: <Widget>[
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Stack(
                                  fit: StackFit.expand,
                                  children: <Widget>[
                                    Poster(
                                      height: 200.0,
                                      path: snapshot.data.results
                                          .elementAt(index)
                                          .posterPath,
                                      imageUrl:
                                          "https://image.tmdb.org/t/p/w500/" +
                                              snapshot.data.results
                                                  .elementAt(index)
                                                  .posterPath,
                                    ),
                                    Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            CupertinoPageRoute(
                                              builder: (context) => (TvDetails(
                                                  name: snapshot.data.results
                                                      .elementAt(index)
                                                      .name,
                                                  id: snapshot.data.results
                                                      .elementAt(index)
                                                      .id)),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  snapshot.data.results.elementAt(index).name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                } else {
                  return Center(
                    child: Text("Empty"),
                  );
                }
              },
            ),
            isLoading
                ? AnimatedOpacity(
                    opacity: _opacity,
                    duration: Duration(milliseconds: 225),
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: new Color.fromRGBO(255, 255, 255, 0.8),
                      ),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  )
                : AnimatedOpacity(
                    duration: Duration(milliseconds: 225),
                    opacity: _opacity,
                    child: Container()),
          ],
        ),
      ),
    );
  }

  Future _getMoreResults() async {
    setState(() {
      isLoading = true;
      _opacity = 1.0;
    });
    TvPopularResults rs = await getPopularTv(page + 1);
    var temp = data;
    temp.then((item) {
      rs.results.forEach((f) {
        item.results.add(f);
      });
    });
    setState(() {
      _opacity = 0.0;
      data = temp;
      page = page + 1;
      isLoading = false;
    });
  }

  _getData() {
    return data;
  }

  void setInitialData() {
    setState(() {
      data = getPopularTv(page);
      isLoading = false;
    });
  }

  void _scrollListener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      _getMoreResults();
    }
  }
}

class MoviesPopular extends StatefulWidget {
  @override
  _MoviesPopularState createState() => _MoviesPopularState();
}

class _MoviesPopularState extends State<MoviesPopular> {
  var data;
  var page = 1;
  var _opacity = 0.0;
  bool isLoading = true;

  ScrollController _controller;

  @override
  void initState() {
    _controller = new ScrollController()..addListener(_scrollListener);
    data = new MoviesPopularResults();
    setInitialData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            FutureBuilder(
              future: _getData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting ||
                    snapshot.connectionState == ConnectionState.active) {
                  return Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasData) {
                  return GridView.builder(
                    gridDelegate: new SliverGridDelegateWithMaxCrossAxisExtent(
                        childAspectRatio: 2 / 3.5,
                        maxCrossAxisExtent: 250,
                        mainAxisSpacing: 8.0,
                        crossAxisSpacing: 8.0),
                    itemCount: snapshot.data.results.length,
                    padding: EdgeInsets.all(8.0),
                    controller: _controller,
                    itemBuilder: (context, index) {
                      return GridTile(
                        child: Column(
                          children: <Widget>[
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Stack(
                                  fit: StackFit.expand,
                                  children: <Widget>[
                                    Poster(
                                      height: 200.0,
                                      path: snapshot.data.results
                                          .elementAt(index)
                                          .posterPath,
                                      imageUrl:
                                          "https://image.tmdb.org/t/p/w500/" +
                                              snapshot.data.results
                                                  .elementAt(index)
                                                  .posterPath,
                                    ),
                                    Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            CupertinoPageRoute(
                                              builder: (context) =>
                                                  (MovieDetails(
                                                      name: snapshot
                                                          .data.results
                                                          .elementAt(index)
                                                          .title,
                                                      id: snapshot.data.results
                                                          .elementAt(index)
                                                          .id)),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  snapshot.data.results.elementAt(index).title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                } else {
                  return Center(
                    child: Text("Empty"),
                  );
                }
              },
            ),
            isLoading
                ? AnimatedOpacity(
                    opacity: _opacity,
                    duration: Duration(milliseconds: 225),
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: new Color.fromRGBO(255, 255, 255, 0.8),
                      ),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  )
                : AnimatedOpacity(
                    duration: Duration(milliseconds: 225),
                    opacity: _opacity,
                    child: Container()),
          ],
        ),
      ),
    );
  }

  Future _getMoreResults() async {
    setState(() {
      isLoading = true;
      _opacity = 1.0;
    });
    MoviesPopularResults rs = await getPopularMovies(page + 1);
    var temp = data;
    temp.then((item) {
      rs.results.forEach((f) {
        item.results.add(f);
      });
    });
    setState(() {
      _opacity = 0.0;
      data = temp;
      page = page + 1;
      isLoading = false;
    });
  }

  _getData() {
    return data;
  }

  void setInitialData() {
    setState(() {
      data = getPopularMovies(page);
      isLoading = false;
    });
  }

  void _scrollListener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      _getMoreResults();
    }
  }
}

class NowPlaying extends StatefulWidget {
  @override
  _NowPlayingState createState() => _NowPlayingState();
}

class _NowPlayingState extends State<NowPlaying> {
  var data;
  var page = 1;
  var _opacity = 0.0;
  bool isLoading = true;

  ScrollController _controller;

  var lastPage;

  @override
  void initState() {
    _controller = new ScrollController()..addListener(_scrollListener);
    data = new PlayingNowResults();
    setInitialData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        return Scaffold(
          body: SafeArea(
            child: Stack(
              children: <Widget>[
                FutureBuilder(
                  future: _getData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting ||
                        snapshot.connectionState == ConnectionState.active) {
                      return Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasData) {
                      return GridView.builder(
                        gridDelegate:
                            new SliverGridDelegateWithMaxCrossAxisExtent(
                                childAspectRatio: 2 / 3.5,
                                maxCrossAxisExtent: 250,
                                mainAxisSpacing: 8.0,
                                crossAxisSpacing: 8.0),
                        itemCount: snapshot.data.results.length,
                        padding: EdgeInsets.all(8.0),
                        controller: _controller,
                        itemBuilder: (context, index) {
                          return GridTile(
                            child: Column(
                              children: <Widget>[
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Stack(
                                      fit: StackFit.expand,
                                      children: <Widget>[
                                        Poster(
                                          height: 200.0,
                                          path: snapshot.data.results
                                              .elementAt(index)
                                              .posterPath,
                                          imageUrl:
                                              "https://image.tmdb.org/t/p/w500/" +
                                                  snapshot.data.results
                                                      .elementAt(index)
                                                      .posterPath,
                                        ),
                                        Material(
                                          color: Colors.transparent,
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                CupertinoPageRoute(
                                                  builder: (context) =>
                                                      (MovieDetails(
                                                          name: snapshot
                                                              .data.results
                                                              .elementAt(index)
                                                              .title,
                                                          id: snapshot
                                                              .data.results
                                                              .elementAt(index)
                                                              .id)),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      snapshot.data.results
                                          .elementAt(index)
                                          .title,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    } else {
                      return Center(
                        child: Text("Empty"),
                      );
                    }
                  },
                ),
                isLoading
                    ? AnimatedOpacity(
                        opacity: _opacity,
                        duration: Duration(milliseconds: 225),
                        child: Container(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: new Color.fromRGBO(255, 255, 255, 0.8),
                          ),
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      )
                    : AnimatedOpacity(
                        duration: Duration(milliseconds: 225),
                        opacity: _opacity,
                        child: Container()),
              ],
            ),
          ),
        );
      },
    );
  }

  Future _getMoreResults() async {
    setState(() {
      isLoading = true;
      _opacity = 1.0;
    });
    PlayingNowResults rs = await getPlayingNow(page + 1);
    var temp = data;
    temp.then((item) {
      setState(() {
        lastPage = rs.totalPages;
      });
      rs.results.forEach((f) {
        item.results.add(f);
      });
    });
    setState(() {
      _opacity = 0.0;
      data = temp;
      page = page + 1;
      isLoading = false;
    });
  }

  _getData() {
    return data;
  }

  void setInitialData() {
    setState(() {
      data = getPlayingNow(page);
      isLoading = false;
    });
  }

  void _scrollListener() {
    if (page != lastPage) {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        _getMoreResults();
      }
    }
  }
}

class MovieDetails extends StatefulWidget {
  final int id;
  final String name;

  const MovieDetails({Key key, this.id, this.name}) : super(key: key);

  @override
  _MovieDetailsState createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  var data;
  var page = 1;
  var _opacity = 0.0;
  bool isLoading = true;

  var _rec;

  var _reviews;

  var _staff;

  @override
  void initState() {
    data = new MovieDetails();
    setInitialData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      backgroundColor: Colors.white,
//      appBar: AppBar(
//        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//        title: Text(widget.name.toString()),
//      ),
      body: FutureBuilder(
        future: _getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting ||
              snapshot.connectionState == ConnectionState.active) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasData) {
            return CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  elevation: 5,
                  forceElevated: true,
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  snap: true,
                  floating: true,
                  primary: true,
                  title: Text(widget.name.toString()),
                ),
                SliverList(
                    delegate: SliverChildListDelegate(<Widget>[
                  Stack(
                    fit: StackFit.loose,
                    children: <Widget>[
                      SizedBox(
                        height: 270,
                      ),
                      Positioned(
                        top: 0,
                        height: 200.0,
                        right: 0.0,
                        width: MediaQuery.of(context).size.width,
                        child: snapshot.data.backdropPath != null
                            ? Image.network(
                                "https://image.tmdb.org/t/p/w500" +
                                    snapshot.data.backdropPath,
                                fit: BoxFit.cover,
                              )
                            : Container(
                                color: Colors.grey,
                                child: Center(
                                  child: Text("No Image"),
                                ),
                              ),
                      ),
                      Positioned(
                        top: 0,
                        height: 200.0,
                        right: 0.0,
                        width: MediaQuery.of(context).size.width,
                        child: Container(
                          height: 200.0,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            gradient: LinearGradient(
                              begin: FractionalOffset.topCenter,
                              end: FractionalOffset.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.transparent,
                                Colors.black,
                              ],
                              stops: [0.0, 0.5, 1.0],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        height: 100,
                        width: MediaQuery.of(context).size.width,
                        child: ClipRRect(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(16.0),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 60.0,
                        left: 16.0,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Container(
                              height: 210,
                              width: MediaQuery.of(context).size.width,
                              child: Stack(
                                fit: StackFit.expand,
                                children: <Widget>[
                                  Positioned(
                                    top: 0.0,
                                    left: 0.0,
                                    child: ClipRRect(
                                      child: snapshot.data.posterPath == null
                                          ? Container()
                                          : Poster(
                                              height: 200.0,
                                              path: snapshot.data.posterPath,
                                              imageUrl:
                                                  "https://image.tmdb.org/t/p/w500/" +
                                                      snapshot.data.posterPath,
                                            ),
                                      borderRadius: BorderRadius.circular(16.0),
                                    ),
                                  ),
                                  Positioned(
                                    width:
                                        MediaQuery.of(context).size.width - 210,
                                    top: 125.0,
                                    left: 135.0,
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        snapshot.data.title,
                                        style: TextStyle(fontSize: 32.0),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 118.0,
                                    right: 30,
                                    child: Stack(
                                      alignment: Alignment.center,
                                      overflow: Overflow.clip,
                                      children: <Widget>[
                                        Icon(
                                          Icons.star,
                                          size: 75,
                                          color: Colors.amber,
                                        ),
                                        Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            snapshot.data.voteAverage
                                                .toString(),
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                          crossAxisAlignment: CrossAxisAlignment.end,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: <Widget>[
                            Text(snapshot.data.overview),
//                          Text(snapshot.data.popularity.toString()),
//                          Text(snapshot.data.homepage.toString()),
//                          Text(snapshot.data.releaseDate.toString()),
//                          Text(snapshot.data.status.toString()),
                            SizedBox(
                              height: 16,
                            ),
                            FutureBuilder(
                              future: _reviews,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                        ConnectionState.waiting ||
                                    snapshot.connectionState ==
                                        ConnectionState.active) {
                                  return Container(
                                    height: 120,
                                    child: Center(
                                        child: CircularProgressIndicator()),
                                  );
                                }

                                if (snapshot.hasData &&
                                    snapshot.data.results.length > 0) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Reviews",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Container(
                                        height: snapshot.data.results.length > 0
                                            ? 120
                                            : 0,
                                        child: ListView.builder(
                                          itemCount:
                                              snapshot.data.results.length,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, index) {
                                            return Container(
                                              width: 200,
                                              child: Card(
                                                elevation: 3,
                                                child: InkWell(
                                                  onTap: () {
                                                    showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return AlertDialog(
                                                            content:
                                                                SingleChildScrollView(
                                                              child: new Text(
                                                                  snapshot.data
                                                                      .results
                                                                      .elementAt(
                                                                          index)
                                                                      .content),
                                                            ),
                                                            actions: <Widget>[
                                                              // define os botões na base do dialogo
                                                              new FlatButton(
                                                                child: new Text(
                                                                    "Fechar"),
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                },
                                                              ),
                                                            ],
                                                          );
                                                        });
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      snapshot.data.results
                                                          .elementAt(index)
                                                          .content
                                                          .toString(),
                                                      maxLines: 5,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  );
                                }
                                return Container();
                              },
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Staff",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            FutureBuilder(
                              future: _staff,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                        ConnectionState.waiting ||
                                    snapshot.connectionState ==
                                        ConnectionState.active) {
                                  return Center(
                                      child: CircularProgressIndicator());
                                }

                                if (snapshot.hasData) {
                                  List<Widget> list = new List<Widget>();
                                  int qnt = snapshot.data.cast.length;
                                  if (qnt > 10) qnt = 10;
                                  for (var i = 0; i < qnt; i++) {
                                    list.add(
                                      Container(
                                        width: 140,
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              CupertinoPageRoute(
                                                builder: (context) =>
                                                    (PeopleDetails(
                                                        id: snapshot
                                                            .data.cast[i].id)),
                                              ),
                                            );
                                          },
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              snapshot.data?.cast[i]
                                                          ?.profilePath ==
                                                      null
                                                  ? Container()
                                                  : Poster(
                                                      height: 200.0,
                                                      path: snapshot.data
                                                          .cast[i].profilePath,
                                                      imageUrl:
                                                          "https://image.tmdb.org/t/p/w500/" +
                                                              snapshot
                                                                  .data
                                                                  .cast[i]
                                                                  .profilePath,
                                                    ),
                                              new Text(
                                                snapshot.data.cast[i].name,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.center,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                  if (qnt < snapshot.data.cast.length) {
                                    list.add(Container(
                                        width: 50,
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              CupertinoPageRoute(
                                                builder: (context) =>
                                                    (StaffScreen(
                                                        cast: snapshot
                                                            .data.cast)),
                                              ),
                                            );
                                          },
                                          child: Icon(Icons.add),
                                        )));
                                  }
                                  return Container(
                                    height: 220,
                                    width: MediaQuery.of(context).size.width,
                                    child: new ListView(
                                      scrollDirection: Axis.horizontal,
                                      children: list,
                                    ),
                                  );
                                } else {
                                  return Text("No data");
                                }
                              },
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Recommended Movies",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            FutureBuilder(
                              future: _rec,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                        ConnectionState.waiting ||
                                    snapshot.connectionState ==
                                        ConnectionState.active) {
                                  return Center(
                                      child: CircularProgressIndicator());
                                }

                                if (snapshot.hasData) {
                                  List<Widget> list = new List<Widget>();
                                  var qnt = snapshot.data.results.length;
                                  if (qnt > 10) qnt = 10;
                                  for (var i = 0; i < qnt; i++) {
                                    list.add(
                                      Container(
                                        width: 140,
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              CupertinoPageRoute(
                                                builder: (context) =>
                                                    (MovieDetails(
                                                        name:
                                                            snapshot
                                                                .data
                                                                .results[i]
                                                                .title,
                                                        id: snapshot.data
                                                            .results[i].id)),
                                              ),
                                            );
                                          },
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              new Poster(
                                                height: 200.0,
                                                path: snapshot
                                                    .data.results[i].posterPath,
                                                imageUrl:
                                                    "https://image.tmdb.org/t/p/w500/" +
                                                        snapshot.data.results[i]
                                                            .posterPath,
                                              ),
                                              new Text(
                                                snapshot.data.results[i].title,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.center,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                  return Container(
                                    height: 220,
                                    width: MediaQuery.of(context).size.width,
                                    child: new ListView(
                                      scrollDirection: Axis.horizontal,
                                      children: list,
                                    ),
                                  );
                                } else {
                                  return Text("No data");
                                }
                              },
                            ),
                          ],
                          crossAxisAlignment: CrossAxisAlignment.start,
                        ),
                      ),
                    ],
                  ),
                ])),
              ],
            );
//            return ListView(
//              scrollDirection: Axis.vertical,
//              children: <Widget>[
//                Stack(
//                  fit: StackFit.loose,
//                  children: <Widget>[
//                    SizedBox(
//                      height: 270,
//                    ),
//                    Positioned(
//                      top: 0,
//                      height: 200.0,
//                      right: 0.0,
//                      width: MediaQuery.of(context).size.width,
//                      child: snapshot.data.backdropPath != null
//                          ? Image.network(
//                              "https://image.tmdb.org/t/p/w500" +
//                                  snapshot.data.backdropPath,
//                              fit: BoxFit.cover,
//                            )
//                          : Container(
//                              color: Colors.grey,
//                              child: Center(
//                                child: Text("No Image"),
//                              ),
//                            ),
//                    ),
//                    Positioned(
//                      top: 0,
//                      height: 200.0,
//                      right: 0.0,
//                      width: MediaQuery.of(context).size.width,
//                      child: Container(
//                        height: 200.0,
//                        decoration: BoxDecoration(
//                          color: Colors.white,
//                          gradient: LinearGradient(
//                            begin: FractionalOffset.topCenter,
//                            end: FractionalOffset.bottomCenter,
//                            colors: [
//                              Colors.transparent,
//                              Colors.transparent,
//                              Colors.black,
//                            ],
//                            stops: [0.0, 0.5, 1.0],
//                          ),
//                        ),
//                      ),
//                    ),
//                    Positioned(
//                      bottom: 0,
//                      left: 0,
//                      height: 100,
//                      width: MediaQuery.of(context).size.width,
//                      child: ClipRRect(
//                        borderRadius: BorderRadius.vertical(
//                          top: Radius.circular(16.0),
//                        ),
//                        child: Container(
//                          decoration: BoxDecoration(
//                            color: Theme.of(context).scaffoldBackgroundColor,
//                          ),
//                        ),
//                      ),
//                    ),
//                    Positioned(
//                      top: 60.0,
//                      left: 16.0,
//                      child: Row(
//                        mainAxisSize: MainAxisSize.max,
//                        children: <Widget>[
//                          Container(
//                            height: 210,
//                            width: MediaQuery.of(context).size.width,
//                            child: Stack(
//                              fit: StackFit.expand,
//                              children: <Widget>[
//                                Positioned(
//                                  top: 0.0,
//                                  left: 0.0,
//                                  child: ClipRRect(
//                                    child: snapshot.data.posterPath == null
//                                        ? Container()
//                                        : Poster(
//                                            height: 200.0,
//                                            path: snapshot.data.posterPath,
//                                            imageUrl:
//                                                "https://image.tmdb.org/t/p/w500/" +
//                                                    snapshot.data.posterPath,
//                                          ),
//                                    borderRadius: BorderRadius.circular(16.0),
//                                  ),
//                                ),
//                                Positioned(
//                                  width:
//                                      MediaQuery.of(context).size.width - 210,
//                                  top: 125.0,
//                                  left: 135.0,
//                                  child: Align(
//                                    alignment: Alignment.center,
//                                    child: Text(
//                                      snapshot.data.title,
//                                      style: TextStyle(fontSize: 32.0),
//                                      maxLines: 2,
//                                      overflow: TextOverflow.ellipsis,
//                                    ),
//                                  ),
//                                ),
//                                Positioned(
//                                  top: 118.0,
//                                  right: 30,
//                                  child: Stack(
//                                    alignment: Alignment.center,
//                                    overflow: Overflow.clip,
//                                    children: <Widget>[
//                                      Icon(
//                                        Icons.star,
//                                        size: 60,
//                                        color: Colors.amber,
//                                      ),
//                                      Align(
//                                        alignment: Alignment.center,
//                                        child: Text(
//                                          snapshot.data.voteAverage.toString(),
//                                          style: TextStyle(color: Colors.black),
//                                        ),
//                                      ),
//                                    ],
//                                  ),
//                                )
//                              ],
//                            ),
//                          ),
//                        ],
//                        crossAxisAlignment: CrossAxisAlignment.end,
//                      ),
//                    ),
//                  ],
//                ),
//                Column(
//                  children: <Widget>[
//                    Padding(
//                      padding: const EdgeInsets.all(8.0),
//                      child: Column(
//                        children: <Widget>[
//                          Text(snapshot.data.overview),
////                          Text(snapshot.data.popularity.toString()),
////                          Text(snapshot.data.homepage.toString()),
////                          Text(snapshot.data.releaseDate.toString()),
////                          Text(snapshot.data.status.toString()),
//                          SizedBox(
//                            height: 16,
//                          ),
//                          FutureBuilder(
//                            future: _reviews,
//                            builder: (context, snapshot) {
//                              if (snapshot.connectionState ==
//                                      ConnectionState.waiting ||
//                                  snapshot.connectionState ==
//                                      ConnectionState.active) {
//                                return Container(
//                                  height: 120,
//                                  child: Center(
//                                      child: CircularProgressIndicator()),
//                                );
//                              }
//
//                              if (snapshot.hasData &&
//                                  snapshot.data.results.length > 0) {
//                                return Column(
//                                  crossAxisAlignment: CrossAxisAlignment.start,
//                                  children: <Widget>[
//                                    Padding(
//                                      padding: const EdgeInsets.all(8.0),
//                                      child: Text(
//                                        "Reviews",
//                                        style: TextStyle(
//                                            fontWeight: FontWeight.bold),
//                                      ),
//                                    ),
//                                    Container(
//                                      height: snapshot.data.results.length > 0
//                                          ? 120
//                                          : 0,
//                                      child: ListView.builder(
//                                        itemCount: snapshot.data.results.length,
//                                        scrollDirection: Axis.horizontal,
//                                        itemBuilder: (context, index) {
//                                          return Container(
//                                            width: 200,
//                                            child: Card(
//                                              elevation: 3,
//                                              child: InkWell(
//                                                onTap: () {
//                                                  showDialog(
//                                                      context: context,
//                                                      builder: (BuildContext
//                                                          context) {
//                                                        return AlertDialog(
//                                                          content:
//                                                              SingleChildScrollView(
//                                                            child: new Text(
//                                                                snapshot.data
//                                                                    .results
//                                                                    .elementAt(
//                                                                        index)
//                                                                    .content),
//                                                          ),
//                                                          actions: <Widget>[
//                                                            // define os botões na base do dialogo
//                                                            new FlatButton(
//                                                              child: new Text(
//                                                                  "Fechar"),
//                                                              onPressed: () {
//                                                                Navigator.of(
//                                                                        context)
//                                                                    .pop();
//                                                              },
//                                                            ),
//                                                          ],
//                                                        );
//                                                      });
//                                                },
//                                                child: Padding(
//                                                  padding:
//                                                      const EdgeInsets.all(8.0),
//                                                  child: Text(
//                                                    snapshot.data.results
//                                                        .elementAt(index)
//                                                        .content
//                                                        .toString(),
//                                                    maxLines: 5,
//                                                    overflow:
//                                                        TextOverflow.ellipsis,
//                                                  ),
//                                                ),
//                                              ),
//                                            ),
//                                          );
//                                        },
//                                      ),
//                                    ),
//                                  ],
//                                );
//                              }
//                              return Container();
//                            },
//                          ),
//                          SizedBox(
//                            height: 16,
//                          ),
//                          Padding(
//                            padding: const EdgeInsets.all(8.0),
//                            child: Text(
//                              "Staff",
//                              style: TextStyle(fontWeight: FontWeight.bold),
//                            ),
//                          ),
//                          FutureBuilder(
//                            future: _staff,
//                            builder: (context, snapshot) {
//                              if (snapshot.connectionState ==
//                                      ConnectionState.waiting ||
//                                  snapshot.connectionState ==
//                                      ConnectionState.active) {
//                                return Center(
//                                    child: CircularProgressIndicator());
//                              }
//
//                              if (snapshot.hasData) {
//                                List<Widget> list = new List<Widget>();
//                                int qnt = snapshot.data.cast.length;
//                                if (qnt > 10) qnt = 10;
//                                for (var i = 0; i < qnt; i++) {
//                                  list.add(
//                                    Container(
//                                      width: 140,
//                                      child: InkWell(
//                                        onTap: () {
//                                          Navigator.push(
//                                            context,
//                                            CupertinoPageRoute(
//                                              builder: (context) =>
//                                                  (PeopleDetails(
//                                                      id: snapshot
//                                                          .data.cast[i].id)),
//                                            ),
//                                          );
//                                        },
//                                        child: Column(
//                                          crossAxisAlignment:
//                                              CrossAxisAlignment.center,
//                                          mainAxisAlignment:
//                                              MainAxisAlignment.center,
//                                          children: <Widget>[
//                                            snapshot.data?.cast[i]
//                                                        ?.profilePath ==
//                                                    null
//                                                ? Container()
//                                                : Poster(
//                                                    height: 200.0,
//                                                    path: snapshot.data.cast[i]
//                                                        .profilePath,
//                                                    imageUrl:
//                                                        "https://image.tmdb.org/t/p/w500/" +
//                                                            snapshot
//                                                                .data
//                                                                .cast[i]
//                                                                .profilePath,
//                                                  ),
//                                            new Text(
//                                              snapshot.data.cast[i].name,
//                                              overflow: TextOverflow.ellipsis,
//                                              textAlign: TextAlign.center,
//                                            ),
//                                          ],
//                                        ),
//                                      ),
//                                    ),
//                                  );
//                                }
//                                if (qnt < snapshot.data.cast.length) {
//                                  list.add(Container(
//                                      width: 50,
//                                      child: InkWell(
//                                        onTap: () {
//                                          Navigator.push(
//                                            context,
//                                            CupertinoPageRoute(
//                                              builder: (context) =>
//                                                  (StaffScreen(
//                                                      cast:
//                                                          snapshot.data.cast)),
//                                            ),
//                                          );
//                                        },
//                                        child: Icon(Icons.add),
//                                      )));
//                                }
//                                return Container(
//                                  height: 220,
//                                  width: MediaQuery.of(context).size.width,
//                                  child: new ListView(
//                                    scrollDirection: Axis.horizontal,
//                                    children: list,
//                                  ),
//                                );
//                              } else {
//                                return Text("No data");
//                              }
//                            },
//                          ),
//                          SizedBox(
//                            height: 16,
//                          ),
//                          Padding(
//                            padding: const EdgeInsets.all(8.0),
//                            child: Text(
//                              "Recommended Movies",
//                              style: TextStyle(fontWeight: FontWeight.bold),
//                            ),
//                          ),
//                          FutureBuilder(
//                            future: _rec,
//                            builder: (context, snapshot) {
//                              if (snapshot.connectionState ==
//                                      ConnectionState.waiting ||
//                                  snapshot.connectionState ==
//                                      ConnectionState.active) {
//                                return Center(
//                                    child: CircularProgressIndicator());
//                              }
//
//                              if (snapshot.hasData) {
//                                List<Widget> list = new List<Widget>();
//                                var qnt = snapshot.data.results.length;
//                                if (qnt > 10) qnt = 10;
//                                for (var i = 0; i < qnt; i++) {
//                                  list.add(
//                                    Container(
//                                      width: 140,
//                                      child: InkWell(
//                                        onTap: () {
//                                          Navigator.push(
//                                            context,
//                                            CupertinoPageRoute(
//                                              builder: (context) =>
//                                                  (MovieDetails(
//                                                      name: snapshot.data
//                                                          .results[i].title,
//                                                      id: snapshot
//                                                          .data.results[i].id)),
//                                            ),
//                                          );
//                                        },
//                                        child: Column(
//                                          crossAxisAlignment:
//                                              CrossAxisAlignment.center,
//                                          mainAxisAlignment:
//                                              MainAxisAlignment.center,
//                                          children: <Widget>[
//                                            new Poster(
//                                              height: 200.0,
//                                              path: snapshot
//                                                  .data.results[i].posterPath,
//                                              imageUrl:
//                                                  "https://image.tmdb.org/t/p/w500/" +
//                                                      snapshot.data.results[i]
//                                                          .posterPath,
//                                            ),
//                                            new Text(
//                                              snapshot.data.results[i].title,
//                                              overflow: TextOverflow.ellipsis,
//                                              textAlign: TextAlign.center,
//                                            ),
//                                          ],
//                                        ),
//                                      ),
//                                    ),
//                                  );
//                                }
//                                return Container(
//                                  height: 220,
//                                  width: MediaQuery.of(context).size.width,
//                                  child: new ListView(
//                                    scrollDirection: Axis.horizontal,
//                                    children: list,
//                                  ),
//                                );
//                              } else {
//                                return Text("No data");
//                              }
//                            },
//                          ),
//                        ],
//                        crossAxisAlignment: CrossAxisAlignment.start,
//                      ),
//                    ),
//                  ],
//                ),
//              ],
//            );
          } else {
            return Center(
              child: Text("No data"),
            );
          }
        },
      ),
    );
  }

  _getData() {
    return data;
  }

  void setInitialData() {
    setState(() {
      data = getMoviesDetails(widget.id.toString());
      _rec = getMoviesRecommendation(widget.id.toString());
      _reviews = getMovieReview(widget.id.toString());
      _staff = getMovieCredits(widget.id.toString());
      isLoading = false;
    });
  }
}

class TvDetails extends StatefulWidget {
  final int id;

  final String name;

  const TvDetails({Key key, this.id, this.name}) : super(key: key);

  @override
  _TvDetailsState createState() => _TvDetailsState();
}

class _TvDetailsState extends State<TvDetails> {
  var data;
  var page = 1;
  var _opacity = 0.0;
  bool isLoading = true;

  var _rec;

  var _reviews;

  var _staff;

  @override
  void initState() {
    setInitialData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(
//        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//        title: Text(widget.name.toString()),
//      ),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            FutureBuilder(
              future: getTvDetails(widget.id.toString()),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting ||
                    snapshot.connectionState == ConnectionState.active) {
                  return Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasData) {
                  return CustomScrollView(
                    slivers: <Widget>[
                      SliverAppBar(
                        elevation: 5,
                        forceElevated: true,
                        backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        snap: true,
                        floating: true,
                        primary: true,
                        title: Text(widget.name.toString()),
                      ),
                      SliverList(
                        delegate: SliverChildListDelegate(
                          <Widget>[
                            Stack(
                              fit: StackFit.loose,
                              children: <Widget>[
                                SizedBox(
                                  height: 270,
                                ),
                                Positioned(
                                  top: 0,
                                  height: 200.0,
                                  right: 0.0,
                                  width: MediaQuery.of(context).size.width,
                                  child: snapshot.data.backdropPath != null
                                      ? FadeInImage.assetNetwork(
                                          fadeInDuration:
                                              Duration(milliseconds: 225),
                                          fadeOutDuration:
                                              Duration(milliseconds: 225),
                                          placeholder:
                                              "assets/images/spinner.gif",
                                          placeholderScale: 0.2,
                                          image:
                                              "https://image.tmdb.org/t/p/w500" +
                                                  snapshot.data.backdropPath,
                                          fit: BoxFit.cover,
                                        )
                                      : Container(
                                          color: Colors.grey,
                                          child: Center(
                                            child: Text("No Image"),
                                          ),
                                        ),
                                ),
                                Positioned(
                                  top: 0,
                                  height: 200.0,
                                  right: 0.0,
                                  width: MediaQuery.of(context).size.width,
                                  child: Container(
                                    height: 200.0,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      gradient: LinearGradient(
                                        begin: FractionalOffset.topCenter,
                                        end: FractionalOffset.bottomCenter,
                                        colors: [
                                          Colors.transparent,
                                          Colors.transparent,
                                          Colors.black,
                                        ],
                                        stops: [0.0, 0.5, 1.0],
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  left: 0,
                                  height: 100,
                                  width: MediaQuery.of(context).size.width,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(16.0),
                                    ),
                                    child: Container(
                                      height: 300,
                                      decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 60.0,
                                  left: 16.0,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      Container(
                                        height: 210,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Stack(
                                          fit: StackFit.expand,
                                          children: <Widget>[
                                            Positioned(
                                              top: 0.0,
                                              left: 0.0,
                                              child: ClipRRect(
                                                child: Container(
                                                  height: 200.0,
                                                  child: snapshot.data
                                                              .posterPath ==
                                                          null
                                                      ? Container()
                                                      : AspectRatio(
                                                          aspectRatio: 2 / 3,
                                                          child: Poster(
                                                            height: 200.0,
                                                            path: snapshot.data
                                                                .posterPath,
                                                            imageUrl:
                                                                "https://image.tmdb.org/t/p/w500/" +
                                                                    snapshot
                                                                        .data
                                                                        .posterPath,
                                                          ),
                                                        ),
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(16.0),
                                              ),
                                            ),
                                            Positioned(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  180,
                                              top: 125.0,
                                              left: 135.0,
                                              child: Align(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  snapshot.data.name,
                                                  style:
                                                      TextStyle(fontSize: 32.0),
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: <Widget>[
                                  Text(snapshot.data.overview),
//                            Text(snapshot.data.popularity.toString()),
//                              Text(snapshot.data.homepage.toString()),
//                              Text(snapshot.data.status.toString()),
//                              Text(snapshot.data.voteAverage.toString()),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  FutureBuilder(
                                    future: _reviews,
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                              ConnectionState.waiting ||
                                          snapshot.connectionState ==
                                              ConnectionState.active) {
                                        return Center(
                                            child: CircularProgressIndicator());
                                      }

                                      if (snapshot.hasData &&
                                          snapshot.data.results.length > 0) {
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                "Reviews",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            Container(
                                              height:
                                                  snapshot.data.results.length >
                                                          0
                                                      ? 120
                                                      : 0,
                                              child: ListView.builder(
                                                itemCount: snapshot
                                                    .data.results.length,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemBuilder: (context, index) {
                                                  return Container(
                                                    width: 200,
                                                    child: Card(
                                                      elevation: 3,
                                                      child: InkWell(
                                                        onTap: () {
                                                          showDialog(
                                                              context: context,
                                                              builder:
                                                                  (BuildContext
                                                                      context) {
                                                                return AlertDialog(
                                                                  content:
                                                                      SingleChildScrollView(
                                                                    child: new Text(snapshot
                                                                        .data
                                                                        .results
                                                                        .elementAt(
                                                                            index)
                                                                        .content),
                                                                  ),
                                                                  actions: <
                                                                      Widget>[
                                                                    // define os botões na base do dialogo
                                                                    new FlatButton(
                                                                      child: new Text(
                                                                          "Fechar"),
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.of(context)
                                                                            .pop();
                                                                      },
                                                                    ),
                                                                  ],
                                                                );
                                                              });
                                                        },
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Text(
                                                            snapshot
                                                                .data.results
                                                                .elementAt(
                                                                    index)
                                                                .content
                                                                .toString(),
                                                            maxLines: 5,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ],
                                        );
                                      }
                                      return Container();
                                    },
                                  ),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "Staff",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  FutureBuilder(
                                    future: _staff,
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                              ConnectionState.waiting ||
                                          snapshot.connectionState ==
                                              ConnectionState.active) {
                                        return Center(
                                            child: CircularProgressIndicator());
                                      }

                                      if (snapshot.hasData) {
                                        int qnt = snapshot.data.cast.length;
                                        if (qnt > 10) qnt = 10;
                                        List<Widget> list = new List<Widget>();
                                        for (var i = 0; i < qnt; i++) {
                                          list.add(
                                            Container(
                                              width: 140,
                                              child: InkWell(
                                                onTap: () {
                                                  print(
                                                      snapshot.data.cast[i].id);
                                                  Navigator.push(
                                                    context,
                                                    CupertinoPageRoute(
                                                      builder: (context) =>
                                                          (PeopleDetails(
                                                              id: snapshot.data
                                                                  .cast[i].id)),
                                                    ),
                                                  );
                                                },
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    snapshot.data.cast[i]
                                                                .profilePath ==
                                                            null
                                                        ? Container()
                                                        : Poster(
                                                            height: 200.0,
                                                            path: snapshot
                                                                .data
                                                                .cast[i]
                                                                .profilePath,
                                                            imageUrl:
                                                                "https://image.tmdb.org/t/p/w500/" +
                                                                    snapshot
                                                                        .data
                                                                        .cast[i]
                                                                        .profilePath,
                                                          ),
                                                    new Text(
                                                      snapshot
                                                          .data.cast[i].name,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        }
                                        if (qnt < snapshot.data.cast.length) {
                                          list.add(Container(
                                              width: 50,
                                              child: InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    CupertinoPageRoute(
                                                      builder: (context) =>
                                                          (StaffScreen(
                                                              cast: snapshot
                                                                  .data.cast)),
                                                    ),
                                                  );
                                                },
                                                child: Icon(Icons.add),
                                              )));
                                        }
                                        return Container(
                                          height: 220,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: new ListView(
                                            scrollDirection: Axis.horizontal,
                                            children: list,
                                          ),
                                        );
                                      } else {
                                        return Text("No data");
                                      }
                                    },
                                  ),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  InkWell(
                                    onTap: () {},
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            "Related Series",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Icon(
                                            Icons.arrow_forward,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  FutureBuilder(
                                    future: _rec,
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                              ConnectionState.waiting ||
                                          snapshot.connectionState ==
                                              ConnectionState.active) {
                                        return Center(
                                            child: CircularProgressIndicator());
                                      }

                                      if (snapshot.hasData) {
                                        List<Widget> list = new List<Widget>();
                                        var qnt = snapshot.data.results.length;
                                        if (qnt > 10) qnt = 10;
                                        for (var i = 0; i < qnt; i++) {
                                          list.add(
                                            Container(
                                              width: 140,
                                              child: GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    CupertinoPageRoute(
                                                      builder: (context) =>
                                                          (TvDetails(
                                                              name: snapshot
                                                                  .data
                                                                  .results[i]
                                                                  .name,
                                                              id: snapshot
                                                                  .data
                                                                  .results[i]
                                                                  .id)),
                                                    ),
                                                  );
                                                },
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    new Poster(
                                                      height: 200.0,
                                                      path: snapshot
                                                          .data
                                                          .results[i]
                                                          .posterPath,
                                                      imageUrl:
                                                          "https://image.tmdb.org/t/p/w500/" +
                                                              snapshot
                                                                  .data
                                                                  .results[i]
                                                                  .posterPath,
                                                    ),
                                                    new Text(
                                                      snapshot
                                                          .data.results[i].name,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        }
                                        return Container(
                                          height: 220,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: new ListView(
                                            scrollDirection: Axis.horizontal,
                                            children: list,
                                          ),
                                        );
                                      } else {
                                        return Text("No data");
                                      }
                                    },
                                  ),
                                ],
                                crossAxisAlignment: CrossAxisAlignment.start,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
//                  return ListView(
//                    scrollDirection: Axis.vertical,
//                    children: <Widget>[
//                      Stack(
//                        fit: StackFit.loose,
//                        children: <Widget>[
//                          SizedBox(
//                            height: 270,
//                          ),
//                          Positioned(
//                            top: 0,
//                            height: 200.0,
//                            right: 0.0,
//                            width: MediaQuery.of(context).size.width,
//                            child: snapshot.data.backdropPath != null
//                                ? FadeInImage.assetNetwork(
//                                    fadeInDuration: Duration(milliseconds: 225),
//                                    fadeOutDuration:
//                                        Duration(milliseconds: 225),
//                                    placeholder: "assets/images/spinner.gif",
//                                    placeholderScale: 0.2,
//                                    image: "https://image.tmdb.org/t/p/w500" +
//                                        snapshot.data.backdropPath,
//                                    fit: BoxFit.cover,
//                                  )
//                                : Container(
//                                    color: Colors.grey,
//                                    child: Center(
//                                      child: Text("No Image"),
//                                    ),
//                                  ),
//                          ),
//                          Positioned(
//                            top: 0,
//                            height: 200.0,
//                            right: 0.0,
//                            width: MediaQuery.of(context).size.width,
//                            child: Container(
//                              height: 200.0,
//                              decoration: BoxDecoration(
//                                color: Colors.white,
//                                gradient: LinearGradient(
//                                  begin: FractionalOffset.topCenter,
//                                  end: FractionalOffset.bottomCenter,
//                                  colors: [
//                                    Colors.transparent,
//                                    Colors.transparent,
//                                    Colors.black,
//                                  ],
//                                  stops: [0.0, 0.5, 1.0],
//                                ),
//                              ),
//                            ),
//                          ),
//                          Positioned(
//                            bottom: 0,
//                            left: 0,
//                            height: 100,
//                            width: MediaQuery.of(context).size.width,
//                            child: ClipRRect(
//                              borderRadius: BorderRadius.vertical(
//                                top: Radius.circular(16.0),
//                              ),
//                              child: Container(
//                                height: 300,
//                                decoration: BoxDecoration(
//                                  color:
//                                      Theme.of(context).scaffoldBackgroundColor,
//                                ),
//                              ),
//                            ),
//                          ),
//                          Positioned(
//                            top: 60.0,
//                            left: 16.0,
//                            child: Row(
//                              mainAxisSize: MainAxisSize.max,
//                              children: <Widget>[
//                                Container(
//                                  height: 210,
//                                  width: MediaQuery.of(context).size.width,
//                                  child: Stack(
//                                    fit: StackFit.expand,
//                                    children: <Widget>[
//                                      Positioned(
//                                        top: 0.0,
//                                        left: 0.0,
//                                        child: ClipRRect(
//                                          child: Container(
//                                            height: 200.0,
//                                            child:
//                                                snapshot.data.posterPath == null
//                                                    ? Container()
//                                                    : AspectRatio(
//                                                        aspectRatio: 2 / 3,
//                                                        child: Poster(
//                                                          height: 200.0,
//                                                          path: snapshot
//                                                              .data.posterPath,
//                                                          imageUrl:
//                                                              "https://image.tmdb.org/t/p/w500/" +
//                                                                  snapshot.data
//                                                                      .posterPath,
//                                                        ),
//                                                      ),
//                                          ),
//                                          borderRadius:
//                                              BorderRadius.circular(16.0),
//                                        ),
//                                      ),
//                                      Positioned(
//                                        width:
//                                            MediaQuery.of(context).size.width -
//                                                180,
//                                        top: 125.0,
//                                        left: 135.0,
//                                        child: Align(
//                                          alignment: Alignment.center,
//                                          child: Text(
//                                            snapshot.data.name,
//                                            style: TextStyle(fontSize: 32.0),
//                                            maxLines: 2,
//                                            overflow: TextOverflow.ellipsis,
//                                          ),
//                                        ),
//                                      ),
//                                    ],
//                                  ),
//                                ),
//                              ],
//                              crossAxisAlignment: CrossAxisAlignment.end,
//                            ),
//                          ),
//                        ],
//                      ),
//                      Padding(
//                        padding: const EdgeInsets.all(8.0),
//                        child: Column(
//                          children: <Widget>[
//                            Text(snapshot.data.overview),
////                            Text(snapshot.data.popularity.toString()),
////                              Text(snapshot.data.homepage.toString()),
////                              Text(snapshot.data.status.toString()),
////                              Text(snapshot.data.voteAverage.toString()),
//                            SizedBox(
//                              height: 16,
//                            ),
//                            FutureBuilder(
//                              future: _reviews,
//                              builder: (context, snapshot) {
//                                if (snapshot.connectionState ==
//                                        ConnectionState.waiting ||
//                                    snapshot.connectionState ==
//                                        ConnectionState.active) {
//                                  return Center(
//                                      child: CircularProgressIndicator());
//                                }
//
//                                if (snapshot.hasData &&
//                                    snapshot.data.results.length > 0) {
//                                  return Column(
//                                    crossAxisAlignment:
//                                        CrossAxisAlignment.start,
//                                    children: <Widget>[
//                                      Padding(
//                                        padding: const EdgeInsets.all(8.0),
//                                        child: Text(
//                                          "Reviews",
//                                          style: TextStyle(
//                                              fontWeight: FontWeight.bold),
//                                        ),
//                                      ),
//                                      Container(
//                                        height: snapshot.data.results.length > 0
//                                            ? 120
//                                            : 0,
//                                        child: ListView.builder(
//                                          itemCount:
//                                              snapshot.data.results.length,
//                                          scrollDirection: Axis.horizontal,
//                                          itemBuilder: (context, index) {
//                                            return Container(
//                                              width: 200,
//                                              child: Card(
//                                                elevation: 3,
//                                                child: InkWell(
//                                                  onTap: () {
//                                                    showDialog(
//                                                        context: context,
//                                                        builder: (BuildContext
//                                                            context) {
//                                                          return AlertDialog(
//                                                            content:
//                                                                SingleChildScrollView(
//                                                              child: new Text(
//                                                                  snapshot.data
//                                                                      .results
//                                                                      .elementAt(
//                                                                          index)
//                                                                      .content),
//                                                            ),
//                                                            actions: <Widget>[
//                                                              // define os botões na base do dialogo
//                                                              new FlatButton(
//                                                                child: new Text(
//                                                                    "Fechar"),
//                                                                onPressed: () {
//                                                                  Navigator.of(
//                                                                          context)
//                                                                      .pop();
//                                                                },
//                                                              ),
//                                                            ],
//                                                          );
//                                                        });
//                                                  },
//                                                  child: Padding(
//                                                    padding:
//                                                        const EdgeInsets.all(
//                                                            8.0),
//                                                    child: Text(
//                                                      snapshot.data.results
//                                                          .elementAt(index)
//                                                          .content
//                                                          .toString(),
//                                                      maxLines: 5,
//                                                      overflow:
//                                                          TextOverflow.ellipsis,
//                                                    ),
//                                                  ),
//                                                ),
//                                              ),
//                                            );
//                                          },
//                                        ),
//                                      ),
//                                    ],
//                                  );
//                                }
//                                return Container();
//                              },
//                            ),
//                            SizedBox(
//                              height: 16,
//                            ),
//                            Padding(
//                              padding: const EdgeInsets.all(8.0),
//                              child: Text(
//                                "Staff",
//                                style: TextStyle(fontWeight: FontWeight.bold),
//                              ),
//                            ),
//                            FutureBuilder(
//                              future: _staff,
//                              builder: (context, snapshot) {
//                                if (snapshot.connectionState ==
//                                        ConnectionState.waiting ||
//                                    snapshot.connectionState ==
//                                        ConnectionState.active) {
//                                  return Center(
//                                      child: CircularProgressIndicator());
//                                }
//
//                                if (snapshot.hasData) {
//                                  int qnt = snapshot.data.cast.length;
//                                  if (qnt > 10) qnt = 10;
//                                  List<Widget> list = new List<Widget>();
//                                  for (var i = 0; i < qnt; i++) {
//                                    list.add(
//                                      Container(
//                                        width: 140,
//                                        child: InkWell(
//                                          onTap: () {
//                                            print(snapshot.data.cast[i].id);
//                                            Navigator.push(
//                                              context,
//                                              CupertinoPageRoute(
//                                                builder: (context) =>
//                                                    (PeopleDetails(
//                                                        id: snapshot
//                                                            .data.cast[i].id)),
//                                              ),
//                                            );
//                                          },
//                                          child: Column(
//                                            crossAxisAlignment:
//                                                CrossAxisAlignment.center,
//                                            mainAxisAlignment:
//                                                MainAxisAlignment.center,
//                                            children: <Widget>[
//                                              snapshot.data.cast[i]
//                                                          .profilePath ==
//                                                      null
//                                                  ? Container()
//                                                  : Poster(
//                                                      height: 200.0,
//                                                      path: snapshot.data
//                                                          .cast[i].profilePath,
//                                                      imageUrl:
//                                                          "https://image.tmdb.org/t/p/w500/" +
//                                                              snapshot
//                                                                  .data
//                                                                  .cast[i]
//                                                                  .profilePath,
//                                                    ),
//                                              new Text(
//                                                snapshot.data.cast[i].name,
//                                                overflow: TextOverflow.ellipsis,
//                                                textAlign: TextAlign.center,
//                                              ),
//                                            ],
//                                          ),
//                                        ),
//                                      ),
//                                    );
//                                  }
//                                  if (qnt < snapshot.data.cast.length) {
//                                    list.add(Container(
//                                        width: 50,
//                                        child: InkWell(
//                                          onTap: () {
//                                            Navigator.push(
//                                              context,
//                                              CupertinoPageRoute(
//                                                builder: (context) =>
//                                                    (StaffScreen(
//                                                        cast: snapshot
//                                                            .data.cast)),
//                                              ),
//                                            );
//                                          },
//                                          child: Icon(Icons.add),
//                                        )));
//                                  }
//                                  return Container(
//                                    height: 220,
//                                    width: MediaQuery.of(context).size.width,
//                                    child: new ListView(
//                                      scrollDirection: Axis.horizontal,
//                                      children: list,
//                                    ),
//                                  );
//                                } else {
//                                  return Text("No data");
//                                }
//                              },
//                            ),
//                            SizedBox(
//                              height: 16,
//                            ),
//                            InkWell(
//                              onTap: () {},
//                              child: Padding(
//                                padding: const EdgeInsets.all(8.0),
//                                child: Row(
//                                  mainAxisAlignment:
//                                      MainAxisAlignment.spaceBetween,
//                                  children: <Widget>[
//                                    Text(
//                                      "Related Series",
//                                      style: TextStyle(
//                                          fontWeight: FontWeight.bold),
//                                    ),
//                                    Icon(
//                                      Icons.arrow_forward,
//                                    ),
//                                  ],
//                                ),
//                              ),
//                            ),
//                            FutureBuilder(
//                              future: _rec,
//                              builder: (context, snapshot) {
//                                if (snapshot.connectionState ==
//                                        ConnectionState.waiting ||
//                                    snapshot.connectionState ==
//                                        ConnectionState.active) {
//                                  return Center(
//                                      child: CircularProgressIndicator());
//                                }
//
//                                if (snapshot.hasData) {
//                                  List<Widget> list = new List<Widget>();
//                                  var qnt = snapshot.data.results.length;
//                                  if (qnt > 10) qnt = 10;
//                                  for (var i = 0; i < qnt; i++) {
//                                    list.add(
//                                      Container(
//                                        width: 140,
//                                        child: GestureDetector(
//                                          onTap: () {
//                                            Navigator.push(
//                                              context,
//                                              CupertinoPageRoute(
//                                                builder: (context) =>
//                                                    (TvDetails(
//                                                        name: snapshot.data
//                                                            .results[i].name,
//                                                        id: snapshot.data
//                                                            .results[i].id)),
//                                              ),
//                                            );
//                                          },
//                                          child: Column(
//                                            crossAxisAlignment:
//                                                CrossAxisAlignment.center,
//                                            mainAxisAlignment:
//                                                MainAxisAlignment.center,
//                                            children: <Widget>[
//                                              new Poster(
//                                                height: 200.0,
//                                                path: snapshot
//                                                    .data.results[i].posterPath,
//                                                imageUrl:
//                                                    "https://image.tmdb.org/t/p/w500/" +
//                                                        snapshot.data.results[i]
//                                                            .posterPath,
//                                              ),
//                                              new Text(
//                                                snapshot.data.results[i].name,
//                                                overflow: TextOverflow.ellipsis,
//                                                textAlign: TextAlign.center,
//                                              ),
//                                            ],
//                                          ),
//                                        ),
//                                      ),
//                                    );
//                                  }
//                                  return Container(
//                                    height: 220,
//                                    width: MediaQuery.of(context).size.width,
//                                    child: new ListView(
//                                      scrollDirection: Axis.horizontal,
//                                      children: list,
//                                    ),
//                                  );
//                                } else {
//                                  return Text("No data");
//                                }
//                              },
//                            ),
//                          ],
//                          crossAxisAlignment: CrossAxisAlignment.start,
//                        ),
//                      ),
//                    ],
//                  );
                } else {
                  print(snapshot.error.toString());
                  print(snapshot.data.toString());
                  return Center(
                    child: Text("No data"),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  _getData() {
    return data;
  }

  void setInitialData() {
    setState(() {
      data = getTvDetails(widget.id.toString());
      _rec = getTvRecommendation(widget.id.toString());
      _reviews = getTvReview(widget.id.toString());
      _staff = getTvCredits(widget.id.toString());
      isLoading = false;
    });
  }
}

class Poster extends StatelessWidget {
  const Poster({
    Key key,
    this.imageUrl,
    this.path,
    this.height,
  }) : super(key: key);

  final imageUrl;
  final path;
  final height;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: Container(
        height: height > 0 ? height : 200,
        child: AspectRatio(
          aspectRatio: 2 / 3,
          child: path != null
              ? Card(
                  child: FadeInImage.assetNetwork(
                    fadeInDuration: Duration(milliseconds: 225),
                    fadeOutDuration: Duration(milliseconds: 225),
                    placeholder: "assets/images/spinner.gif",
                    image: imageUrl,
                    fit: BoxFit.cover,
                  ),
                  elevation: 2.0,
                )
              : Container(
                  color: Colors.grey,
                  child: Center(
                    child: Text("No Image"),
                  ),
                ),
        ),
      ),
      borderRadius: BorderRadius.circular(16.0),
    );
  }
}

class QueryScreen extends StatefulWidget {
  final query;

  const QueryScreen({Key key, this.query}) : super(key: key);

  @override
  _QueryScreenState createState() => _QueryScreenState();
}

class _QueryScreenState extends State<QueryScreen> {
  var _result;
  var _page;

  @override
  void initState() {
    setState(() {
      _page = 1;
      _result = searchQuery(widget.query, _page.toString());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _height = 75.0;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: TabBar(
            tabs: <Widget>[
              Tab(
                text: "Movies",
              ),
              Tab(
                text: "TV Shows",
              ),
              Tab(
                text: "People",
              ),
            ],
            indicatorColor: Colors.grey,
          ),
        ),
        body: SafeArea(
          child: FutureBuilder(
            future: _result,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.results.length == 0) {
                  return new Center(
                    child: Text("No results"),
                  );
                }

                List<Widget> movieList = new List<Widget>();
                List<Widget> tvList = new List<Widget>();
                List<Widget> peopleList = new List<Widget>();

                for (int i = 0; i < snapshot.data.results.length; i++) {
                  switch (snapshot.data.results.elementAt(i).mediaType) {
                    case MediaType.MOVIE:
                      {
                        movieList.add(
                          ListTile(
                            onTap: () {
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => (MovieDetails(
                                      name: snapshot.data.results
                                          .elementAt(i)
                                          .title,
                                      id: snapshot.data.results
                                          .elementAt(i)
                                          .id)),
                                ),
                              );
                            },
                            title: Row(
                              children: <Widget>[
                                snapshot.data.results.elementAt(i).posterPath ==
                                        null
                                    ? Container(
                                        height: _height,
                                        child: AspectRatio(
                                          aspectRatio: 2 / 3,
                                          child: Card(
                                            child: Center(
                                              child: Icon(Icons.no_sim),
                                            ),
                                          ),
                                        ),
                                      )
                                    : Poster(
                                        height: _height,
                                        path: snapshot.data.results
                                            .elementAt(i)
                                            .posterPath,
                                        imageUrl:
                                            "https://image.tmdb.org/t/p/w500" +
                                                snapshot.data.results
                                                    .elementAt(i)
                                                    .posterPath,
                                      ),
                                Text(snapshot.data.results
                                    .elementAt(i)
                                    .title
                                    .toString()),
                              ],
                            ),
                          ),
                        );

                        movieList.add(
                          Divider(
                            height: 2,
                          ),
                        );
                      }

                      break;

                    case MediaType.TV:
                      {
                        tvList.add(
                          ListTile(
                            onTap: () {
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => (TvDetails(
                                      name: snapshot.data.results
                                          .elementAt(i)
                                          .name,
                                      id: snapshot.data.results
                                          .elementAt(i)
                                          .id)),
                                ),
                              );
                            },
                            title: Row(
                              children: <Widget>[
                                snapshot.data.results.elementAt(i).posterPath ==
                                        null
                                    ? Container(
                                        height: _height,
                                        child: AspectRatio(
                                          aspectRatio: 2 / 3,
                                          child: Card(
                                            child: Center(
                                              child: Icon(Icons.no_sim),
                                            ),
                                          ),
                                        ),
                                      )
                                    : Poster(
                                        height: _height,
                                        path: snapshot.data.results
                                            .elementAt(i)
                                            .posterPath,
                                        imageUrl:
                                            "https://image.tmdb.org/t/p/w500/" +
                                                snapshot.data.results
                                                    .elementAt(i)
                                                    .posterPath,
                                      ),
                                Text(snapshot.data.results
                                    .elementAt(i)
                                    .name
                                    .toString()),
                              ],
                            ),
                          ),
                        );

                        tvList.add(
                          Divider(
                            height: 2,
                          ),
                        );
                      }

                      break;

                    case MediaType.PERSON:
                      {
                        peopleList.add(
                          ListTile(
                            onTap: () {
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => (PeopleDetails(
                                    id: snapshot.data.results.elementAt(i).id,
                                  )),
                                ),
                              );
                            },
                            title: Row(
                              children: <Widget>[
                                snapshot.data.results
                                            .elementAt(i)
                                            .profilePath ==
                                        null
                                    ? Container(
                                        height: _height,
                                        child: AspectRatio(
                                          aspectRatio: 2 / 3,
                                          child: Card(
                                            child: Center(
                                              child: Icon(Icons.no_sim),
                                            ),
                                          ),
                                        ),
                                      )
                                    : Poster(
                                        height: _height,
                                        path: snapshot.data.results
                                            .elementAt(i)
                                            .profilePath,
                                        imageUrl:
                                            "https://image.tmdb.org/t/p/w500/" +
                                                snapshot.data.results
                                                    .elementAt(i)
                                                    .profilePath,
                                      ),
                                Text(snapshot.data.results
                                    .elementAt(i)
                                    .name
                                    .toString()),
                              ],
                            ),
                          ),
                        );

                        peopleList.add(
                          Divider(
                            height: 2,
                          ),
                        );
                      }
                      break;
                  }
                }

                return TabBarView(
                  children: <Widget>[
                    movieList.isEmpty
                        ? Center(child: Text("No results"))
                        : new ListView(
                            children: movieList,
                          ),
                    tvList.isEmpty
                        ? Center(child: Text("No results"))
                        : new ListView(
                            children: tvList,
                          ),
                    peopleList.isEmpty
                        ? Center(child: Text("No results"))
                        : new ListView(
                            children: peopleList,
                          ),
                  ],
                );
              }

              if (snapshot.hasError) {
                print(snapshot.error.toString());
                return Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    //TODO Melhorar o display
                    new Text("Error"),
                    new RaisedButton(
                      onPressed: () {
                        setState(() {
                          _result = searchQuery(widget.query, _page.toString());
                        });
                      },
                      child: Text("Reload"),
                    ),
                  ],
                ));
              }

              return Center(child: new CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }
}

class PeopleDetails extends StatefulWidget {
  final id;

  const PeopleDetails({Key key, this.id}) : super(key: key);

  @override
  _PeopleDetailsState createState() => _PeopleDetailsState();
}

class _PeopleDetailsState extends State<PeopleDetails> {
//  var _data;

  @override
  void initState() {
//    _data = getPeopleDetails(widget.id.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.id.toString());
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: getPeopleDetails(widget.id.toString()),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                {
                  if (snapshot.hasData) {
                    return CustomScrollView(
                      slivers: <Widget>[
                        SliverAppBar(
                          elevation: 5,
                          forceElevated: true,
                          backgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                          snap: true,
                          floating: true,
                          primary: true,
                          title: Text(snapshot.data.name),
                        ),
                        SliverList(
                          delegate: SliverChildListDelegate(
                            <Widget>[
                              Text(snapshot.data.name.toString()),
                              Text(snapshot.data.birthday.toString()),
                              Text(snapshot.data.knownForDepartment.toString()),
                              Text(snapshot.data.deathday.toString()),
                              Text(snapshot.data.id.toString()),
                              Text(snapshot.data.name.toString()),
                              Text(snapshot.data.alsoKnownAs.toString()),
                              Text(snapshot.data.gender.toString()),
                              Text(snapshot.data.biography.toString()),
                              Text(snapshot.data.popularity.toString()),
                              Text(snapshot.data.placeOfBirth.toString()),
                              snapshot.data.profilePath == null
                                  ? Container()
                                  : Poster(
                                      height: 200.0,
                                      path: snapshot.data.profilePath,
                                      imageUrl:
                                          "https://image.tmdb.org/t/p/w500/" +
                                              snapshot.data.profilePath,
                                    ),
                              Text(snapshot.data.adult.toString()),
                              Text(snapshot.data.imdbId.toString()),
                              Text(snapshot.data.homepage.toString()),
                            ],
                          ),
                        ),
                      ],
                    );
//                    return new ListView(
//                      children: <Widget>[
//                        Text(snapshot.data.name.toString()),
//                        Text(snapshot.data.birthday.toString()),
//                        Text(snapshot.data.knownForDepartment.toString()),
//                        Text(snapshot.data.deathday.toString()),
//                        Text(snapshot.data.id.toString()),
//                        Text(snapshot.data.name.toString()),
//                        Text(snapshot.data.alsoKnownAs.toString()),
//                        Text(snapshot.data.gender.toString()),
//                        Text(snapshot.data.biography.toString()),
//                        Text(snapshot.data.popularity.toString()),
//                        Text(snapshot.data.placeOfBirth.toString()),
//                        snapshot.data.profilePath == null
//                            ? Container()
//                            : Poster(
//                                height: 200.0,
//                                path: snapshot.data.profilePath,
//                                imageUrl: "https://image.tmdb.org/t/p/w500/" +
//                                    snapshot.data.profilePath,
//                              ),
//                        Text(snapshot.data.adult.toString()),
//                        Text(snapshot.data.imdbId.toString()),
//                        Text(snapshot.data.homepage.toString()),
//                      ],
//                    );
                  } else {
                    print(snapshot.error.toString());
                    return Center(child: new Text("No data"));
                  }
                }
                break;
              default:
                {
                  return new Center(
                    child: CircularProgressIndicator(),
                  );
                }
            }
          },
        ),
      ),
    );
  }
}

class StaffScreen extends StatefulWidget {
  StaffScreen({Key key, this.cast}) : super(key: key);
  final cast;

  @override
  _StaffScreenState createState() => _StaffScreenState();
}

class _StaffScreenState extends State<StaffScreen> {
  @override
  Widget build(BuildContext context) {
    List<Widget> list = new List<Widget>();
    for (var i = 0; i < widget.cast.length; i++) {
      list.add(
        Container(
          width: 140,
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => (PeopleDetails(id: widget.cast[i].id)),
                ),
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                widget.cast[i].profilePath == null
                    ? Container()
                    : Poster(
                        height: 200.0,
                        path: widget.cast[i].profilePath,
                        imageUrl: "https://image.tmdb.org/t/p/w500/" +
                            widget.cast[i].profilePath,
                      ),
                new Text(
                  widget.cast[i].name,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      );
    }
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              title: Text("Cast"),
              snap: true,
              floating: true,
            ),
            SliverGrid(
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 180,
                  childAspectRatio: 2 / 3,
                ),
                delegate: SliverChildListDelegate(list)),
          ],
        ),
      ),
    );
  }
}

class NewTopMovie extends StatefulWidget {
  @override
  _NewTopMovieState createState() => _NewTopMovieState();
}

class _NewTopMovieState extends State<NewTopMovie> {
  bool isLoading = false;
  var _opacity = 0.0;
  ScrollController _controller;

  @override
  void initState() {
    // TODO: implement initState
    _controller = new ScrollController()..addListener(_scrollListener);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('appbarTitle'),
      ),
      body: Consumer<TopMovie>(
        builder: (ctx, topMovie, child) {
          if (topMovie.results == null) topMovie.getMoreResults(1);
          return topMovie.results != null
              ? GridView.builder(
                  gridDelegate: new SliverGridDelegateWithMaxCrossAxisExtent(
                      childAspectRatio: 2 / 3.5,
                      maxCrossAxisExtent: 250,
                      mainAxisSpacing: 8.0,
                      crossAxisSpacing: 8.0),
                  itemCount: topMovie.results.length,
                  controller: _controller,
                  padding: EdgeInsets.all(8.0),
                  itemBuilder: (context, index) {
                    return GridTile(
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Stack(
                                fit: StackFit.expand,
                                children: <Widget>[
                                  Poster(
                                    height: 200.0,
                                    path: topMovie.results
                                        .elementAt(index)
                                        .posterPath,
                                    imageUrl:
                                        "https://image.tmdb.org/t/p/w500/" +
                                            topMovie.results
                                                .elementAt(index)
                                                .posterPath,
                                  ),
                                  Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          CupertinoPageRoute(
                                            builder: (context) => (MovieDetails(
                                                name: topMovie.results
                                                    .elementAt(index)
                                                    .title,
                                                id: topMovie.results
                                                    .elementAt(index)
                                                    .id)),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                topMovie.results.elementAt(index).title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  })
              : Container(
                  child: RaisedButton(
                    child: const Text('RAISED BUTTON',
                        semanticsLabel: 'RAISED BUTTON 1'),
                    onPressed: () {
                      // Perform some action
                      topMovie.getMoreResults(1);
                    },
                  ),
                );
        },
//          child: Container()),
      ),
    );
  }

  void _scrollListener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      print("Reached");
      var state = Provider.of<TopMovie>(context);
      if (state.page == null) state.page = 1;
      int page = state.page;
      page = page + 1;
      state.changePage(page);
      state.getMoreResults(page);
    }
  }
}

//class _MoviesTopRatedState extends State<MoviesTopRated> {
//  var data;
//  var page = 1;
//  var _opacity = 0.0;
//  bool isLoading = true;
//
//  ScrollController _controller;
//
//  @override
//  void initState() {
//    _controller = new ScrollController()..addListener(_scrollListener);
//    data = new MoviesTopRatedResults();
//    setInitialData();
//    super.initState();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      body: SafeArea(
//        child: Stack(
//          children: <Widget>[
//            FutureBuilder(
//              future: _getData(),
//              builder: (context, snapshot) {
//                if (snapshot.connectionState == ConnectionState.waiting ||
//                    snapshot.connectionState == ConnectionState.active) {
//                  return Center(child: CircularProgressIndicator());
//                }
//
//                if (snapshot.hasData) {
//                  return GridView.builder(
////                    gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
////                        childAspectRatio: 2 / 3.5,
////                        crossAxisCount: 2,
////                        mainAxisSpacing: 8.0,
////                        crossAxisSpacing: 8.0),
//                    gridDelegate: new SliverGridDelegateWithMaxCrossAxisExtent(
//                        childAspectRatio: 2 / 3.5,
//                        maxCrossAxisExtent: 250,
//                        mainAxisSpacing: 8.0,
//                        crossAxisSpacing: 8.0),
//                    itemCount: snapshot.data.results.length,
//                    padding: EdgeInsets.all(8.0),
//                    controller: _controller,
//                    itemBuilder: (context, index) {
//                      return GridTile(
//                        child: Column(
//                          children: <Widget>[
//                            Expanded(
//                              child: ClipRRect(
//                                borderRadius: BorderRadius.circular(8.0),
//                                child: Stack(
//                                  fit: StackFit.expand,
//                                  children: <Widget>[
//                                    Poster(
//                                      height: 200.0,
//                                      path: snapshot.data.results
//                                          .elementAt(index)
//                                          .posterPath,
//                                      imageUrl:
//                                      "https://image.tmdb.org/t/p/w500/" +
//                                          snapshot.data.results
//                                              .elementAt(index)
//                                              .posterPath,
//                                    ),
//                                    Material(
//                                      color: Colors.transparent,
//                                      child: InkWell(
//                                        onTap: () {
//                                          Navigator.push(
//                                            context,
//                                            CupertinoPageRoute(
//                                              builder: (context) =>
//                                              (MovieDetails(
//                                                  name: snapshot
//                                                      .data.results
//                                                      .elementAt(index)
//                                                      .title,
//                                                  id: snapshot.data.results
//                                                      .elementAt(index)
//                                                      .id)),
//                                            ),
//                                          );
//                                        },
//                                      ),
//                                    ),
//                                  ],
//                                ),
//                              ),
//                            ),
//                            Padding(
//                              padding:
//                              const EdgeInsets.symmetric(vertical: 8.0),
//                              child: Align(
//                                alignment: Alignment.centerLeft,
//                                child: Text(
//                                  snapshot.data.results.elementAt(index).title,
//                                  maxLines: 1,
//                                  overflow: TextOverflow.ellipsis,
//                                  style: TextStyle(
//                                      fontSize: 16.0,
//                                      fontWeight: FontWeight.w400),
//                                ),
//                              ),
//                            ),
//                          ],
//                        ),
//                      );
//                    },
//                  );
//                } else {
//                  return Center(
//                    child: Text("Empty"),
//                  );
//                }
//              },
//            ),
//            AnimatedOpacity(
//              opacity: _opacity,
//              duration: Duration(milliseconds: 225),
//              child: isLoading
//                  ? Container(
//                height: MediaQuery.of(context).size.height,
//                width: MediaQuery.of(context).size.width,
//                decoration: BoxDecoration(
//                  color: new Color.fromRGBO(255, 255, 255, 0.8),
//                ),
//                child: Center(
//                  child: CircularProgressIndicator(),
//                ),
//              )
//                  : Container(),
//            ),
//          ],
//        ),
//      ),
//    );
//  }
//
//  Future _getMoreResults() async {
//    setState(() {
//      isLoading = true;
//      _opacity = 1.0;
//    });
//    MoviesTopRatedResults rs = await getTopRatedMovies(page + 1);
//    var temp = data;
//    temp.then((item) {
//      rs.results.forEach((f) {
//        item.results.add(f);
//      });
//    });
//    setState(() {
//      _opacity = 0.0;
//      data = temp;
//      page = page + 1;
//      isLoading = false;
//    });
//  }
//
//  _getData() {
//    return data;
//  }
//
//  void setInitialData() {
//    setState(() {
//      data = getTopRatedMovies(page);
//      isLoading = false;
//    });
//  }
//
//  void _scrollListener() {
//    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
//      _getMoreResults();
//    }
//  }
//}
