import 'package:app_pelicula/providers/movies_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_pelicula/search/search_delegate.dart';
import 'package:app_pelicula/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final moviesProvider = Provider.of<MoviesProvider>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Películas en cines')),
        elevation: 0,
        actions: [
          IconButton(onPressed: () => showSearch(context: context, delegate: MovieSearchDelegate()), 
                     icon: const Icon(Icons.search_outlined)
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
              // Tarjeta principales
              CardSwiper(movies: moviesProvider.onDisplayMovies,),
              // Slider de peliculas
              MovieSlider(movies: moviesProvider.popularMovies,  title: 'Populares', 
               onNextPage: () => moviesProvider.getPopularMovies()
              ,)
          ],
        ),
      )
    );
  }
}