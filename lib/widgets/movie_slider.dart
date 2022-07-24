import 'package:flutter/material.dart';
import 'package:movies_app2/models/models.dart';


class MovieSlider extends StatefulWidget {

  final Orientation  orientation;
  final List<Movie> popularMovies;
  final String? title;
  final Function onNextPage;

  const MovieSlider({
    Key? key,
    required this.orientation,
    required this.popularMovies,
    required this.onNextPage,
    this.title
    }) : super(key: key);

  @override
  State<MovieSlider> createState() => _MovieSliderState();
}

class _MovieSliderState extends State<MovieSlider> {

  final ScrollController scrollController = new ScrollController();

  //Este widget es un statefull para tener un ciclo de vida y crear y destruir el controller del scroll horizontal
  //para hacer la paginacion

  //al iniciar el estado
  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      
      if(scrollController.position.pixels >=scrollController.position.maxScrollExtent - 300){
        widget.onNextPage();
      }
      // print(scrollController.position.pixels);
      // print(scrollController.position.maxScrollExtent);

    });
    
  }

  //al terminar el estado
  @override
  void dispose() {
    
    
    super.dispose();
  }

  
  @override
  Widget build(BuildContext context) {

    final Size size = MediaQuery.of(context).size;

    return Container(
      width: widget.orientation == Orientation.portrait ? double.infinity : size.width * 0.35,
      height: widget.orientation == Orientation.portrait ?  220 : size.height * 0.8,
      // color: Colors.green,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          if(this.widget.title != null)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              child: Text(widget.title!, style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
            ),
          

          //tiene que estar dentro de un expanded porque el listviwebuilder 
          //adapta su tamaño según el padre y el padre es el column que se adapta según
          //el tamaño de los hijos, por ende generaría un error y con el expanded lo soluciono
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              scrollDirection: widget.orientation == Orientation.portrait ?  Axis.horizontal : Axis.vertical,
              itemCount: widget.popularMovies.length,
              itemBuilder: (BuildContext context, int index) {
                return _MoviesPoster(orientation : widget.orientation, movie: widget.popularMovies[index],);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _MoviesPoster extends StatelessWidget {

  final Orientation  orientation;
  final Movie movie;


  const _MoviesPoster({
    Key? key,
    required this.orientation,
    required this.movie
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {



    return Container(
      width: 130 ,
      height: orientation == Orientation.portrait ? 190 : 160,
      // color: Colors.yellow,
      margin: orientation == Orientation.portrait ?  const EdgeInsets.all(10) : const EdgeInsets.all(20),
      child: Column(
        children: [

          GestureDetector(
            onTap: (){
              Navigator.pushNamed(context, "details",arguments: movie);
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: FadeInImage(
                placeholder:  AssetImage("assets/no-image.jpg"), 
                image: NetworkImage(movie.fullPosterImg),
                width: 130,
                height: 160,
                fit: BoxFit.cover,
                        
              ),
            ),
          ),

          Text(movie.title,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          textAlign: TextAlign.center,)

        ],
      ),
    );
  }
}