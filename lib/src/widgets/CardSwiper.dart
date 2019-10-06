import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class CardSwiper extends StatelessWidget {
  //const CardSwiper {Key key}) : super(key: key);
  final List<dynamic> movies;
  CardSwiper({@required this.movies});
  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(top: 5.0),
      child: Swiper(
        itemWidth: _screenSize.width * 0.5,
        itemHeight: _screenSize.width * 0.7,
        itemBuilder: (BuildContext context, int index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              image: NetworkImage(movies[index].getPosterImg()),
              placeholder: AssetImage('img/loading.gif'),
              fit: BoxFit.cover,
              
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
