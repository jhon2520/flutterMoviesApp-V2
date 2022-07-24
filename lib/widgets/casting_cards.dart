import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_app2/models/models.dart';
import 'package:movies_app2/providers/movies_provider.dart';
import 'package:provider/provider.dart';

class CastingCards extends StatelessWidget {
  final int movieId;

  const CastingCards({Key? key, required this.movieId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);

    return FutureBuilder(
      future: moviesProvider.getMovieCast(movieId),
      builder: (_, AsyncSnapshot<List<Cast>> snapshot) {

        if(!snapshot.hasData){
          return Container(
            height: 180,
            child: CupertinoActivityIndicator(),
          );
        }
        
        final List<Cast> cast = snapshot.data!;


        return Container(
          margin: const EdgeInsets.only(bottom: 30),
          width: double.infinity,
          height: 180,
          // color: Colors.red,
          child: ListView.builder(
            itemCount: 10,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return _CastCard(actor: cast[index],);
            },
          ),
        );
      },
    );
  }
}


class _CastCard extends StatelessWidget {

  final Cast actor;

  const _CastCard({Key? key, required this.actor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      height: 110,
      width: 110,
      // color: Colors.yellow,
      child: Column(
        children: [

          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child:FadeInImage(
              placeholder:  const AssetImage("assets/no-image.jpg"), 
              image: NetworkImage(actor.fullprofilePath),
              height: 120,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          Text(actor.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}