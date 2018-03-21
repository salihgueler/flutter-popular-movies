import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/Movie.dart';
import 'package:flutter_app/MovieDetail.dart';


// Main method starts execution
void main() {
  runApp(
      new MaterialApp(
          home: new Scaffold(
            // App toolbar code
              appBar: new AppBar(
                title: new Text('Movie List'),
              ),
              // Body part of the screen
              body: new FutureBuilder(
                  future: getMovies(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List> snapshot) {
                    if (!snapshot.hasData)
                      // Shows progress indicator until the data is load.
                      return new MaterialApp(
                          home: new Scaffold(
                            body: new Center(
                              child: new CircularProgressIndicator(),
                            ),
                          )
                      );
                    // Shows the real data with the data retrieved.
                    List movies = snapshot.data;
                    return new CustomScrollView(
                      primary: false,
                      slivers: <Widget>[
                        new SliverPadding(
                          padding: const EdgeInsets.all(10.0),
                          sliver: new SliverGrid.count(
                            crossAxisSpacing: 10.0,
                            mainAxisSpacing: 10.0,
                            crossAxisCount: 2,
                            children: createMovieCardItem(movies, context),
                          ),
                        ),
                      ],
                    );
                  }
              )
          )
      )
  );
  getMovies();
}

/// Method to get movies from the backend
Future<List<Movie>> getMovies() async {
  final String url = 'http://api.themoviedb.org/3/movie/top_rated?api_key=9bc617f38b9d1d072ab43573f3b1d632';
  var httpClient = new HttpClient();
  try {
    // Make the call
    var request = await httpClient.getUrl(Uri.parse(url));
    var response = await request.close();
    if (response.statusCode == HttpStatus.OK) {
      var json = await response.transform(UTF8.decoder).join();
      // Decode the json response
      var data = JSON.decode(json);
      // Get the result list
      List results = data["results"];
      // Get the Movie list
      List<Movie> movieList = createMovieList(results);
      // Print the results.
      return movieList;
    } else {
      print("Failed http call.");
    }
  } catch (exception) {
    print(exception.toString());
  }
  return null;
}

/// Method to parse information from the retrieved data
List<Movie> createMovieList(List data) {
  List<Movie> list = new List();
  for (int i = 0; i < data.length; i++) {
    String title = data[i]["title"];
    String posterPath = data[i]["poster_path"];
    String backdropImage = data[i]["backdrop_path"];
    String originalTitle = data[i]["original_title"];
    double voteAverage = data[i]["vote_average"];
    String overview = data[i]["overview"];
    String releaseDate = data[i]["release_date"];

    Movie movie = new Movie(
        title,
        posterPath,
        backdropImage,
        originalTitle,
        voteAverage,
        overview,
        releaseDate);
    list.add(movie);
  }
  return list;
}

List<Widget> createMovieCardItem(List<Movie> movies, BuildContext context) {
  // Children list for the list.
  List<Widget> listElementWidgetList = new List<Widget>();
  if (movies != null) {
    var lengthOfList = movies.length;
    for (int i = 0; i < lengthOfList; i++) {
      Movie movie = movies[i];
      // Image URL
      var imageURL = "https://image.tmdb.org/t/p/w500/" + movie.posterPath;
      // List item created with an image of the poster
      var listItem = new GridTile(
          footer: new GridTileBar(
            backgroundColor: Colors.black45,
            title: new Text(movie.title),
          ),
          child: new GestureDetector(
            onTap: () {
              Navigator.push(context, new MaterialPageRoute(builder:
                  (BuildContext context) => new MovieDetail(movie)));
            },
            child: new Image.network(imageURL, fit: BoxFit.cover),
          )
      );
      listElementWidgetList.add(listItem);
    }
  }
  return listElementWidgetList;
}