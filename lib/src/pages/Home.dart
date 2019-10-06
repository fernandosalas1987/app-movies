import 'package:app_peliculas/src/providers/MoviesProvider.dart';
import 'package:app_peliculas/src/widgets/CardSwiper.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  // const HomePage({Key key}) : super(key: key);
  final moviesProvider = new MoviesProvider();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Peliculas en cines'),
        backgroundColor: Colors.indigoAccent,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          )
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[_swiperCards()],
        ),
      ),
    );
  }

  Widget _swiperCards() {
    return FutureBuilder(
      future: moviesProvider.getNowPlaying(),
      initialData: [],
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return CardSwiper(movies: snapshot.data);
        } else {
          return Container(
              height: 400.0, child: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }
}
