import 'package:app_peliculas/src/models/Movie.dart';
import 'package:app_peliculas/src/providers/MoviesProvider.dart';
import 'package:flutter/material.dart';

class DataSearch extends SearchDelegate {
  final movies = [
    'Spiderman',
    'Wonder Woman',
    'Shazam',
    'Saint Seiya',
    'Krizalid'
  ];

  final recentMovies = ['Spiderman', 'Shazam'];

  String selection = '';

  final moviesProvider = new MoviesProvider();
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Container(
        height: 100.0,
        width: 100.0,
        color: Colors.blueAccent,
        child: Text(selection),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    /*  final suggestionList = (query.isEmpty)
        ? recentMovies
        : movies.where((m) => m.toLowerCase().startsWith(query)).toList();
    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Icon(Icons.movie),
          title: Text(suggestionList[index]),
          onTap: () {
            selection = suggestionList[index];
            showResults(context);
          },
        );
      },
    );*/
    if (query.isEmpty) {
      return Container();
    }
    return FutureBuilder(
      future: moviesProvider.searchMovie(query),
      builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
        if (snapshot.hasData) {
          final movies = snapshot.data;
          return ListView(
              children: movies.map((movie) {
            return ListTile(
              leading: FadeInImage(
                image: NetworkImage(movie.getPosterImg()),
                placeholder: AssetImage('img/no-image.jpg'),
                width: 50.0,
                fit: BoxFit.contain,
              ),
              title: Text(movie.title),
              subtitle: Text(movie.originalTitle),
              onTap: () {
                close(context, null);
                movie.uniqueId = '';
                Navigator.pushNamed(context, 'detail', arguments: movie);
              },
            );
          }).toList());
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
