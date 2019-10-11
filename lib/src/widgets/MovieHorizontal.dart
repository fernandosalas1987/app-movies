import 'package:app_peliculas/src/models/Movie.dart';
import 'package:flutter/material.dart';

class MovieHorizontal extends StatelessWidget {
  //const MovieHorizontal({Key key}) : super(key: key);
  final List<Movie> movies;
  final Function nextPage;
  MovieHorizontal({@required this.movies, @required this.nextPage});

  final _pageController =
      new PageController(initialPage: 1, viewportFraction: 0.3);
  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    _pageController.addListener(() {
      if (_pageController.position.pixels >=
          _pageController.position.maxScrollExtent - 200) {
        nextPage();
      }
    });
    return Container(
      height: _screenSize.height * 0.4,
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        // children: _cards(context),
        itemCount: movies.length,
        itemBuilder: (context, i) {
          return _card(context, movies[i]);
        },
      ),
    );
  }

  Widget _card(BuildContext context, Movie movie) {
    final cardMovie= Container(
      margin: EdgeInsets.only(right: 15.0),
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              image: NetworkImage(movie.getPosterImg()),
              placeholder: AssetImage('img/loading.gif'),
              fit: BoxFit.cover,
              height: 160.0,
            ),
          ),
          SizedBox(height: 5.0),
          Text(
            movie.title,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.caption,
          )
        ],
      ),
    );

    return GestureDetector(
      child: cardMovie,
      onTap: (){
        Navigator.pushNamed(context,'detail',arguments: movie);
      },
    );
  }

  List<Widget> _cards(BuildContext context) {
    return movies.map((movie) {
      return Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                image: NetworkImage(movie.getPosterImg()),
                placeholder: AssetImage('img/loading.gif'),
                fit: BoxFit.cover,
                height: 160.0,
              ),
            ),
            SizedBox(height: 5.0),
            Text(
              movie.title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption,
            )
          ],
        ),
      );
    }).toList();
  }
}
