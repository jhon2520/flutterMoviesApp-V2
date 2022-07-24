import 'package:flutter/material.dart';
import 'package:movies_app2/models/models.dart';
import 'package:movies_app2/providers/movies_provider.dart';
import 'package:provider/provider.dart';

class MovieSearchDelegate extends SearchDelegate {
  @override
  String? get searchFieldLabel => "Buscar película";

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          //cerrar search
          close(context, null);
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text("buildResults");
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //buildsuggestions se dispara cada que se presiona una tecla en el search

    if (query.isEmpty) {
      return const Center(
          child: Icon(
        Icons.movie_creation_outlined,
        color: Colors.black38,
        size: 150,
      ));
    }

    final searchMoviesProvider =
        Provider.of<MoviesProvider>(context, listen: false);
    searchMoviesProvider.getSuggestionsByQuery(query);

    return StreamBuilder(
      stream: searchMoviesProvider.suggestionStream,
      builder: (_, AsyncSnapshot<List<Movie>> snapshot) {
        if (!snapshot.hasData) {
          return const Center(
              child: Icon(
            Icons.movie_creation_outlined,
            color: Colors.black38,
            size: 150,
          ));
        }

        final movies = snapshot.data!;

        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (BuildContext context, int index) {
            return _MovieItem(movie: movies[index]);
          },
        );
      },
    );
  }
}


class _MovieItem extends StatelessWidget {

  final Movie movie;

  const _MovieItem({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: FadeInImage(
        image: NetworkImage(movie.fullPosterImg) ,
        placeholder: AssetImage("assets/no-image.jpg") ,
        width: 50,
        fit: BoxFit.cover,  
      ),
      title: Text(movie.title),
      subtitle: Text(movie.originalLanguage),
      onTap: (){
        Navigator.pushNamed(context, "details",arguments: movie);
      },
    );
  }
}
