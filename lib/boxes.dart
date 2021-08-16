import 'package:hive/hive.dart';
import 'movies.dart';

class Boxes {
  static Box<Movies> getMovies() =>
      Hive.box<Movies>('movies');
}