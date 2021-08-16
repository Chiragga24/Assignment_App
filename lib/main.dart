import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled/boxes.dart';
import 'movies.dart';
import 'utils.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'dialog.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(MoviesAdapter());
  await Hive.openBox<Movies>("movies");

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Assignment App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Assignment App'),
    );
  }
}


class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ScrollController _scrollController = new ScrollController();
  var a = 5;
  addValue() {
    setState(() {
      a +=5;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addValue();
    _scrollController
      ..addListener(() {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          addValue();
        }
      });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    Hive.close();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: ValueListenableBuilder<Box<Movies>>(
        valueListenable: Boxes.getMovies().listenable(),
        builder: (context, box, _) {
          final transactions = box.values.toList().cast<Movies>();
          return buildContent(transactions);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () =>
            showDialog(
              context: context,
              builder: (context) =>
                  MovieDialog(
                    onClickedDone: addTransaction,
                  ),
            ),
      ),
    );
  }

    Widget buildContent(List<Movies> movies) {
      if (movies.isEmpty) {
        return Center(
          child: Text(
            'No Movies Yet!!',
            style: TextStyle(fontSize: 24),
          ),
        );
      } else {

        return Column(
          children: [
            SizedBox(height: 24),
            Text(
              "Movies List",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 24),
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: EdgeInsets.all(8),
                itemCount: min<int>(a,movies.length) ,
                itemBuilder: (BuildContext context, int index) {
                    final movie = movies[index];
                    return buildTransaction(context, movie);
                },
              ),
            ),
          ],
        );
      }
    }

    Widget buildTransaction(
        BuildContext context,
        Movies movie,
        ) {

      return Card(
        color: Colors.white,
        child: ExpansionTile(
          tilePadding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          title: Text(
            movie.title,
            maxLines: 1,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          subtitle: Text(movie.director),
          leading: Container(
            width: MediaQuery.of(context).size.width * 0.3,
            child: movie.imagePath != ""? Image.file(File(movie.imagePath)): Image.asset("error.png"),),
          children: [
            buildButtons(context, movie),
          ],
        ),
      );
    }

    Widget buildButtons(BuildContext context, Movies movie) => Row(
      children: [
        Expanded(
          child: TextButton.icon(
            label: Text('Edit'),
            icon: Icon(Icons.edit),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => MovieDialog(
                  movie: movie,
                  onClickedDone: (title, director, imagePath) =>
                      editTransaction(movie, title, director, imagePath),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: TextButton.icon(
            label: Text('Delete'),
            icon: Icon(Icons.delete),
            onPressed: () => deleteTransaction(movie),
          ),
        )
      ],
    );

    Future addTransaction(String title, String director ,String imagePath) async {
      final movie = Movies()
        ..title = title
        ..director = director
        ..imagePath = imagePath;


      final box = Boxes.getMovies();
      box.add(movie);
    }

    void editTransaction(
        Movies movie,
        String title, String director ,String imagePath
        ) {
      movie.title = title;
      movie.director = director;
      movie.imagePath = imagePath;

      movie.save();
    }
    void deleteTransaction(Movies movie) {

      movie.delete();
      //setState(() => transactions.remove(transaction));
    }
  }
