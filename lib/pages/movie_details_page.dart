import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:stars/models/credits_model.dart';
import 'package:stars/models/movie_detail_model.dart';
import 'package:stars/providers/movies_provider.dart';

class DetailsPage extends StatefulWidget {
  final String movieId;
  const DetailsPage({Key? key, required this.movieId}) : super(key: key);

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
    await moviesProvider.getDetails(widget.movieId);
    await moviesProvider.getCast(widget.movieId);
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MovieDetail movie = moviesProvider.details;
    List<Cast> cast = moviesProvider.castList;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
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
                    color: Color(int.parse('0xff2A0B51')).withOpacity(0.8),
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
                children: [
                  const SizedBox(width: 20),
                  RatingBar.builder(
                    itemBuilder: (context, index) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (value) => false,
                    allowHalfRating: true,
                    initialRating: (movie.voteAverage ?? 0) / 2,
                    itemSize: 16,
                  ),
                  Text('(${movie.voteCount} Reviews)'),
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
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text('Genre: ${movie.genresString}')),
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text('Year: ${movie.releaseDate}')),
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text('Duration: ${movie.runtime} min')),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: const Text('The Plot',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              ),
              const SizedBox(height: 10),
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text('${movie.overview}')),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: const Text('Cast',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              ),
              const SizedBox(height: 20),
              Container(
                height: 200,
                width: double.infinity,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: cast.length,
                  itemBuilder: (constext, index) => Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 15),
                        height: 110,
                        width: 90,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: FadeInImage(
                            fit: BoxFit.cover,
                            // height: 140,
                            width: 100,
                            image: NetworkImage(cast[index].fullProfilePath),
                            placeholder:
                                const AssetImage('assets/no-image.jpg'),
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        cast[index].name ?? '',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
