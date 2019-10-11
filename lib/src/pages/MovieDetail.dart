import 'package:app_peliculas/src/models/Movie.dart';
import 'package:flutter/material.dart';

class MovieDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute.of(context).settings.arguments;

    return Scaffold(
        body: CustomScrollView(
      slivers: <Widget>[
        _createAppbar(movie),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              _posterTitulo(context, movie),
              _description(movie),
              _description(movie),
              _description(movie),
              _description(movie),
              _description(movie),
              _description(movie)
            ]
          ),
        )
      
      ],
    ));
  }

  Widget _createAppbar(Movie movie) {
    return SliverAppBar(
          pinned: true,
          expandedHeight: 250.0,
          floating: false,
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: true,
            title: Text(movie.title),
            background: FadeInImage(
              image: NetworkImage(movie.getBackgroundImg()),
              placeholder: AssetImage('img/no-image.jpg'),
              fadeInDuration: Duration(microseconds: 150),
              fit: BoxFit.cover,
            ),
          ),
          
        );
  }

  Widget _posterTitulo(BuildContext context, Movie movie) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: <Widget>[
          SizedBox(width: 20.0),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(movie.title,
                    style: Theme.of(context).textTheme.title,
                    overflow: TextOverflow.ellipsis),
                Text(movie.originalTitle,
                    style: Theme.of(context).textTheme.subhead,
                    overflow: TextOverflow.ellipsis),
                Row(
                  children: <Widget>[
                    Icon(Icons.star_border),
                    Text(movie.voteAverage.toString(),
                        style: Theme.of(context).textTheme.subhead)
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  _description(Movie movie) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: Text(
        movie.overview,
        textAlign: TextAlign.justify,
      ),
    );
  }
}
