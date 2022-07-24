import 'package:flutter/material.dart';
import 'package:movies_app2/providers/movies_provider.dart';
import 'package:movies_app2/screens/screens.dart';
import 'package:movies_app2/search/search_delegate.dart';
import 'package:movies_app2/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final orientation = MediaQuery.of(context).orientation;

    //provider 
    final moviesProvider = Provider.of<MoviesProvider>(context,listen: true);

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: ()=>showSearch(context: context, delegate: MovieSearchDelegate()), 
            icon: const Icon(Icons.search))
        ],
        centerTitle: true,
        title: const Text("Peliculas en cine"),
        elevation: 0,
      ),
      body:SingleChildScrollView(
        child: AnimatedSwitcher( 
          duration: const Duration(milliseconds: 800),
          transitionBuilder: (widget,animation){
            return ScaleTransition(
              scale: animation,
              child: widget,  
            );
          },
          child: orientation == Orientation.portrait ? Column(
          children: [
      
            //card swiper
            CardSwiper(orientation: Orientation.portrait, movies: moviesProvider.onDisplayMovies,),
      
            //listado horizontal de peliculas
            MovieSlider(
              orientation: Orientation.portrait, 
              popularMovies: moviesProvider.popularMovies,
              onNextPage: ()=> moviesProvider.getPopularMovies(),

            )
          ],
        ) : Container(
          child: Row(
            children: [
              CardSwiper(orientation: Orientation.landscape, movies: moviesProvider.onDisplayMovies,),
              MovieSlider(
                orientation: Orientation.landscape,
                popularMovies: moviesProvider.popularMovies,
                onNextPage: ()=> moviesProvider.getPopularMovies(),
              )
            ],
          ),
        )
      ))
    );
  }
}
