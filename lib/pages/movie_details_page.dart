import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:stars/models/genres_model.dart';
import 'package:stars/models/movie_detail_model.dart';
import 'package:stars/providers/movies_provider.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({Key? key}) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage>
    with TickerProviderStateMixin {
  MoviesProvider moviesProvider = MoviesProvider();

  @override
  void initState() {
    moviesProvider = context.read<MoviesProvider>();
    _loadDetails();
    super.initState();
  }

  void _loadDetails() async {
    await moviesProvider.getDetails('917496');
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MovieDetail movie = moviesProvider.details;

    // String getGenres() {
    //   String genres = '';
    //   if (movie.genres != null) {
    //     for (var element in movie.genres!) {
    //         genres += ' ${element.name!}';
    //     }
    //   }
    //   return genres;
    // }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: 400,
                    width: double.infinity,
                    child: FadeInImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(movie.fullPosterImg),
                      placeholder: const AssetImage('assets/no-image.jpg'),
                    ),
                  ),
                  Container(
                    height: 400,
                    width: double.infinity,
                    color: Color(int.parse('0xff2A0B51')).withOpacity(0.6),
                  ),
                  Container(
                    height: 400,
                    width: double.infinity,
                    child: FadeInImage(
                      fit: BoxFit.contain,
                      image: NetworkImage(movie.fullPosterImg),
                      placeholder: const AssetImage('assets/no-image.jpg'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Genre: ${movie.genresString}'),
                  RatingBar.builder(
                    itemBuilder: (context, index) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (value) => false,
                    allowHalfRating: true,
                    initialRating: (movie.voteAverage ?? 0) / 2,
                    itemSize: 16,
                  )
                ],
              ),
              const SizedBox(height: 30),
              Container(
                width: double.infinity,
                alignment: Alignment.center,
                child: Text(
                  '${movie.title}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 22),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Text('Year: ${movie.releaseDate}'),
                ],
              ),
              Row(
                children: [
                  Text('Duration: ${movie.runtime} min'),
                ],
              ),
              const SizedBox(height: 20),
              const Text('The Plot',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              const SizedBox(height: 10),
              Text('${movie.overview}'),
              const SizedBox(height: 20),
              const Text('Cast',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
