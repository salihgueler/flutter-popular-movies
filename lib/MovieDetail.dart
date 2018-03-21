import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/Movie.dart';


class MovieDetail extends StatelessWidget {
  // Movie object to handle.
  Movie movie;

  // Constructor for the class.
  MovieDetail(this.movie);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text(movie.title),
        ),
        body: new ListView(
            children: <Widget>[
              new Image.network(
                  "https://image.tmdb.org/t/p/w500/" + movie.backdropPath),
              new Container(
                padding: const EdgeInsets.all(32.0),
                child: new Row(
                  children: [
                    // First child in the Row for the name and the
                    // Release date information.
                    new Expanded(
                      // Name and Release date are in the same column
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Code to create the view for name.
                          new Container(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: new Text(
                              "Original Name: " + movie.originalTitle,
                              style: new TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          // Code to create the view for release date.
                          new Text(
                            "Release Date: " + movie.releaseDate,
                            style: new TextStyle(
                              color: Colors.grey[500],
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Icon to indicate the rating.
                    new Icon(
                      Icons.star,
                      color: Colors.red[500],
                    ),
                    new Text('${movie.voteAverage}'),
                  ],
                ),
              ),
              new Container(
                  padding: const EdgeInsets.all(32.0),
                  child: new Text(movie.overview,
                    softWrap: true,
                  )
              )
            ]
        )
    );
  }
}