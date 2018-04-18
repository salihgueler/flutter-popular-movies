import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_app/Movie.dart';
import 'package:flutter_app/MovieDetail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'MockImageHttpClient.dart';

void main() {

  // Mock object creation
  Movie movie = new Movie(
      "Dilwale Dulhania Le Jayenge",
      "/uC6TTUhPpQCmgldGyYveKRAu8JN.jpg",
      "/nl79FQ8xWZkhL3rDr1v2RFFR6J0.jpg",
      "Dilwale Dulhania Le Jayenge",
      9.2,
      "Raj is a rich, carefree, happy-go-lucky second generation NRI. Simran is the daughter of Chaudhary Baldev Singh, who in spite of being an NRI is very strict about adherence to Indian values. Simran has left for India to be married to her childhood fiancé. Raj leaves for India with a mission at his hands, to claim his lady love under the noses of her whole family. Thus begins a saga.",
      "1995-10-20");

  // Expected widget within created widgets
  List<String> expectedTexts = [
    "Original Name: " + movie.originalTitle,
    "Release Date: " + movie.releaseDate,
    movie.voteAverage.toString(),
    movie.overview,
    movie.title
  ];

  testWidgets('Movie Detail Widget test', (WidgetTester tester) async {

    HttpOverrides.runZoned(() async {
      await tester.pumpWidget(new MaterialApp(home: new MovieDetail(movie)));

      // Gets the created widgets
      Iterable<Widget> listOfWidgets = tester.allWidgets;

      checkIfTextsCreatedCorrectly(listOfWidgets, expectedTexts);
    }, createHttpClient: createMockImageHttpClient);
  });
}

/// Method to check if all texts are created as expected.
void checkIfTextsCreatedCorrectly(Iterable<Widget> listOfWidgets, List<String> expectedTexts) {
  var textWidgetPosition = 0;
  for(Widget widget in listOfWidgets) {
    if(widget is Text) {
      expect(widget.data, expectedTexts[textWidgetPosition]);
      textWidgetPosition++;
    }
  }
}
