import 'package:app_peliculas/src/models/Movie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class CardSwiper extends StatelessWidget {
  //const CardSwiper {Key key}) : super(key: key);
  final List<Movie> movies;
  CardSwiper({@required this.movies});
  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Swiper(
        itemWidth: _screenSize.width * 0.7,
        itemHeight: _screenSize.width * 0.9,
        itemBuilder: (BuildContext context, int index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              image: NetworkImage(movies[index].getPosterImg()),
              placeholder: AssetImage('img/loading.gif'),
            )
          );
        },
        //pagination: new SwiperPagination(),
        // control: new SwiperControl(),
        itemCount: movies.length,
        // itemWidth: 200.0,
        layout: SwiperLayout.STACK,
      ),
    );
  }
}
