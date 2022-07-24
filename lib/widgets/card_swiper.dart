import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:movies_app2/models/movie_model.dart';

class CardSwiper extends StatelessWidget {

  final Orientation orientation;
  final List<Movie> movies;

  const CardSwiper({Key? key, required this.orientation, required this.movies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //print(orientation);
    final Size size = MediaQuery.of(context).size;




    //loading
    if(movies.length == 0){
      return SizedBox(
        width: double.infinity,
        height:  size.height * 0.5,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }





    return Container(
      width: orientation == Orientation.portrait ?  double.infinity : size.width * 0.65,
      height:orientation == Orientation.portrait ? size.height *0.5 : size.height * 0.8,
      // color: orientation == Orientation.portrait ? Colors.red : Colors.purple,
      child: Swiper(
        itemCount: movies.length,
        layout: SwiperLayout.STACK,
        itemWidth: orientation == Orientation.portrait ? size.width * 0.6 : size.width * 0.4 ,
        itemHeight: orientation == Orientation.portrait ? size.height * 0.4 : size.height * 0.6,
        itemBuilder: (BuildContext context, int index){

          final movie = movies[index];
      

          return GestureDetector(
            onTap: (){
              Navigator.pushNamed(context, "details",arguments: movie);
            },
            child: Hero(
              tag: movie.id,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child:  FadeInImage(
                  placeholder:  const AssetImage("assets/no-image.jpg"),
                  image: NetworkImage(movie.fullPosterImg),
                  fit: BoxFit.cover,
                  ),
              ),
            ),
          );

        },

      ),
    );
  }
}
