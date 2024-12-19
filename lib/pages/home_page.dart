import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stars/models/genres_model.dart';
import 'package:stars/models/now_playing_model.dart';
import 'package:stars/pages/loading_page.dart';
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
    List<Result> nowPlaying = context.watch<MoviesProvider>().nowPlaying;
    List<Result> popularMovies = context.watch<MoviesProvider>().popularMovies;
    List<Result> upcomingMovies = context.watch<MoviesProvider>().upcoming;
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

    return moviesProvider.isLoading
        ? const LoadingPage()
        : SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 15),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Text(
                    'Top Rated',
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
                    itemBuilder: (context, index) => Row(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      DetailsPage(
                                          movieId: '${topRated[index].id}'))),
                          child: Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
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
                                      image: NetworkImage(
                                          topRated[index].fullBackdropPath),
                                      placeholder: const AssetImage(
                                          'assets/no-image.jpg'),
                                    ),
                                    Container(
                                      height: 50,
                                      width: double.infinity,
                                      color: Colors.black.withOpacity(0.4),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '${topRated[index].title}',
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.start,
                                                style: const TextStyle(
                                                    fontSize: 18),
                                              ),
                                              Text(
                                                getGenres(index),
                                                style: TextStyle(
                                                    color: Colors.white
                                                        .withOpacity(0.8)),
                                              ),
                                            ]),
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                        ),
                        if (index == topRated.length - 1)
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: IconButton(
                                iconSize: 42,
                                onPressed: () => moviesProvider.getTopRated(),
                                icon: const Icon(
                                  Icons.chevron_right_rounded,
                                )),
                          )
                      ],
                    ),
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
                  onNextPage: () => moviesProvider.getNowPlaying(),
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
                  onNextPage: () => moviesProvider.getPopularMovies(),
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
                  onNextPage: () => moviesProvider.getUpcoming(),
                ),
              ],
            ),
          );
  }
}

class MovieList extends StatefulWidget {
  final List<Result> movies;
  final Function onNextPage;
  const MovieList({
    super.key,
    required this.movies,
    required this.onNextPage,
  });

  @override
  State<MovieList> createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240,
      // color: Colors.grey,
      width: double.infinity,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: widget.movies.length,
        itemBuilder: (context, index) => Row(
          children: [
            Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                width: 130,
                // height: 220,
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => DetailsPage(
                                  movieId: '${widget.movies[index].id}'))),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: FadeInImage(
                          height: 175,
                          width: 130,
                          fit: BoxFit.cover,
                          image:
                              NetworkImage(widget.movies[index].fullPosterImg),
                          placeholder: const AssetImage('assets/no-image.jpg'),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      widget.movies[index].title ?? '',
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 5),
                    RatingBar.builder(
                      itemBuilder: (context, index) => const Icon(
                        Icons.star,
                        color: Color(0xff576ca8),
                      ),
                      onRatingUpdate: (value) => false,
                      allowHalfRating: true,
                      initialRating:
                          (widget.movies[index].voteAverage ?? 0) / 2,
                      itemSize: 14,
                    )
                  ],
                )),
            if (index == widget.movies.length - 1)
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: IconButton(
                    iconSize: 42,
                    onPressed: () => widget.onNextPage(),
                    icon: const Icon(
                      Icons.chevron_right_rounded,
                    )),
              )
          ],
        ),
      ),
    );
  }
}
