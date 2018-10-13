import 'package:flutter_app/Movie.dart';
import 'package:flutter_app/MovieList.dart';
import 'package:test/test.dart';

void main() {

  MovieList movieList;

  String jsonText = '{' +
      '"page": 1,' +
      '"total_results": 7104,' +
      '"total_pages": 356,' +
      '"results": [{' +
      '"vote_count": 1296,' +
      '"id": 19404,' +
      '"video": false,' +
      '"vote_average": 9.2,' +
      '"title": "Dilwale Dulhania Le Jayenge",' +
      '"popularity": 15.99626,' +
      '"poster_path": "/uC6TTUhPpQCmgldGyYveKRAu8JN.jpg",' +
      '"original_language": "hi",' +
      '"original_title": "Dilwale Dulhania Le Jayenge",' +
      '"genre_ids": [' +
      '35,' +
      '18,' +
      '10749' +
      '],' +
      '"backdrop_path": "/nl79FQ8xWZkhL3rDr1v2RFFR6J0.jpg",' +
      '"adult": false,' +
      '"overview": "Raj is a rich, carefree, happy-go-lucky second generation NRI. Simran is the daughter of Chaudhary Baldev Singh, who in spite of being an NRI is very strict about adherence to Indian values. Simran has left for India to be married to her childhood fiancé. Raj leaves for India with a mission at his hands, to claim his lady love under the noses of her whole family. Thus begins a saga.",' +
      '"release_date": "1995-10-20"' +
      '}]' +
      '}';

  setUp(() {
    movieList = new MovieList();
  });

  group("movie list creation test", () {
    test('create movie item', () {
      List results = movieList.getResultsList(jsonText);
      expect(results.length, 1);
      Movie movie = movieList.createMovieObject(results[0]);
      expect(movie, isNot(null));
      expect(movie.originalTitle, "Dilwale Dulhania Le Jayenge");
    });

    test('create movie list with json string', () {
      List<Movie> list = movieList.createMovieList(jsonText);
      expect(list.length, 1);
    });
  });
}
