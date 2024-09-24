import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stars/models/genres_model.dart';
import 'package:stars/models/now_playing_model.dart';
import 'package:stars/pages/movie_details_page.dart';
import 'package:stars/providers/movies_provider.dart';

import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  MoviesProvider moviesProvider = MoviesProvider();

  @override
  void initState() {
    moviesProvider = context.read<MoviesProvider>();
    _loadMovies();
    super.initState();
  }

  void _loadMovies() async {
    await moviesProvider.getTopRated();
    await moviesProvider.getNowPlaying();
    await moviesProvider.getPopularMovies();
    await moviesProvider.getUpcoming();
    await moviesProvider.getGenres();
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Result> topRated = moviesProvider.topRated;
    List<Result> nowPlaying = moviesProvider.nowPlaying;
    List<Result> popularMovies = moviesProvider.popularMovies;
    List<Result> upcomingMovies = moviesProvider.upcoming;
    List<Genre> allGenres = moviesProvider.genres;

    String getGenres(int index) {
      String genres = '';
      final genreIdsLength = topRated[index].genreIds?.length ?? 0;
      for (var i = 0; i < genreIdsLength; i++) {
        for (var element in allGenres) {
          if (element.id == topRated[index].genreIds?[i]) {
            genres += ' ${element.name!}';
          }
        }
      }
      return genres;
    }

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 15),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Text(
              'For you',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          Container(
            height: 210,
            width: double.infinity,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: topRated.length,
              itemBuilder: (context, index) => Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  width: 338,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        FadeInImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(topRated[index].fullBackdropPath),
                          placeholder: const AssetImage('assets/no-image.jpg'),
                        ),
                        Container(
                          height: 50,
                          width: double.infinity,
                          color: Colors.black.withOpacity(0.4),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${topRated[index].title}',
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.start,
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                  Text(
                                    getGenres(index),
                                    style: TextStyle(
                                        color: Colors.white.withOpacity(0.8)),
                                  ),
                                ]),
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
          ),
          const SizedBox(height: 15),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Text(
              'Now Playing',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          MovieList(
            movies: nowPlaying,
          ),
          const SizedBox(height: 15),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Text(
              'Popular Movies',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          MovieList(
            movies: popularMovies,
          ),
          const SizedBox(height: 15),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Text(
              'Upcoming Movies',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          MovieList(
            movies: upcomingMovies,
          ),
        ],
      ),
    );
  }
}

class MovieList extends StatelessWidget {
  final List<Result> movies;
  const MovieList({
    super.key,
    required this.movies,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240,
      // color: Colors.grey,
      width: double.infinity,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: movies.length,
        itemBuilder: (context, index) => Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            width: 130,
            height: 190,
            child: Column(
              children: [
                GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              DetailsPage(movieId: '${movies[index].id}'))),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: FadeInImage(
                      height: 175,
                      width: 130,
                      fit: BoxFit.cover,
                      image: NetworkImage(movies[index].fullPosterImg),
                      placeholder: const AssetImage('assets/no-image.jpg'),
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  movies[index].title ?? '',
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 5),
                RatingBar.builder(
                  itemBuilder: (context, index) => const Icon(Icons.star),
                  onRatingUpdate: (value) => false,
                  allowHalfRating: true,
                  initialRating: (movies[index].voteAverage ?? 0) / 2,
                  itemSize: 14,
                )
              ],
            )),
      ),
    );
  }
}
