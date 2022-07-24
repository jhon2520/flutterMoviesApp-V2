import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:movies_app2/models/models.dart';
import 'package:movies_app2/widgets/widgets.dart';







class DetailsScreen extends StatelessWidget {
  
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;

    return Scaffold(
        body: CustomScrollView(
          // los sliver son widgets que tienen preprogramado un comportamiento cuando
          // se hace scroll en el padre
          slivers: [
            _CustomAppBarr(movie: movie),
            SliverList(
              delegate: SliverChildListDelegate([
                  _PosterAddTitle(movie: movie),
                  _Overview(movie: movie,),
                  _Overview(movie: movie,),
                  _Overview(movie: movie,),
                  _Overview(movie: movie,),
                  _Overview(movie: movie,),
                  CastingCards(movieId: movie.id),
              ]
            ))
          ],
        )
    );
  }
}

class  _CustomAppBarr extends StatelessWidget {

  final Movie movie;

  const  _CustomAppBarr({Key? key,required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.indigo,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: const EdgeInsets.all(0),
        title: Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          padding: const EdgeInsets.only( bottom: 10, left: 10, right: 10),
          color: Colors.black12,
          child:  Text(
              movie.title,
              style: const TextStyle( fontSize: 16 ),
              textAlign: TextAlign.center,
            ),
        ),

        background: FadeInImage(
          placeholder:  AssetImage('assets/loading.gif'), 
          image:  NetworkImage( movie.fullbackdropPath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}


class _PosterAddTitle extends StatelessWidget {

  final Movie movie;

  const _PosterAddTitle({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        
        children: [
          Hero(
            tag: movie.id,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                  placeholder:  AssetImage("assets/no-image.jpg"),
                  image: NetworkImage(movie.fullPosterImg),
                  height: 150,
              ),
            ),
          ),
          const SizedBox(width: 15),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(movie.title, 
                style: textTheme.headline5, 
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                ),
                Text(movie.originalTitle, 
                style: textTheme.subtitle1, 
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                ),
                Row(
                  children: [
                    const Icon(Icons.star,size: 15,color: Colors.grey,),
                    const SizedBox(width: 10,),
                    Text("${movie.voteAverage}",style: textTheme.caption,)
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _Overview extends StatelessWidget {

  final Movie movie;

  const _Overview({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
      child: Text(movie.overview,style: Theme.of(context).textTheme.subtitle1, textAlign: TextAlign.justify,),
    );
  }
}