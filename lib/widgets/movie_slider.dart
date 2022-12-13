import 'package:flutter/material.dart';
import 'package:app_pelicula/models/models.dart';


class MovieSlider extends StatefulWidget {

  final String? title;
  final List<Movie> movies;
  final Function onNextPage;

  const MovieSlider({Key? key, required this.movies, required this.onNextPage, this.title}) : super(key: key);

  @override
  State<MovieSlider> createState() => _MovieSliderState();
}

class _MovieSliderState extends State<MovieSlider> {

  // Me va permitir en el initState, crearme un Listener
  //! Debe estar amarrado a un widget que use un scroll (en el ListView.builder)
  final ScrollController scrollController =  ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if(scrollController.position.pixels >= scrollController.position.maxScrollExtent - 500){
        widget.onNextPage();
      }
    });
  }

  @override
  void dispose() {
    
    
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 260,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if(widget.title != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child:  Text(widget.title!, style: const TextStyle(fontSize:20, fontWeight: FontWeight.bold),),
          ),
          const SizedBox(height: 5,),
          Expanded(
            child: ListView.builder(
              controller: scrollController, //!
              scrollDirection: Axis.horizontal,
              itemCount: widget.movies.length,
              itemBuilder: (_, int index){
                return  _MoviePoster(movie: widget.movies[index], heroId:'${widget.title}-$index-${widget.movies[index].id}');
              }
            ),
          )
        ],
      ),
    );
  }
}

class _MoviePoster extends StatelessWidget {
  final Movie movie;
  // Para el Hero
  final String heroId;

  const _MoviePoster({
    Key? key, required this.movie, required this.heroId
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    movie.heroId = heroId;

    return Container(
      width: 130,
      height: 190,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children:  [
          GestureDetector(
            onTap: ()=>Navigator.pushNamed(context, 'details', arguments: movie),
            child: Hero(
              tag: movie.heroId!,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                  placeholder: const AssetImage('assets/no-image.jpg'), 
                  image: NetworkImage(movie.fullPosterImg),
                  width: 130,
                  height: 185,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(height: 5,),
          Text(
             movie.title,
             overflow: TextOverflow.ellipsis,
             maxLines: 2,
             textAlign: TextAlign.center,
          )

        ]
      ),
    );
  }
}