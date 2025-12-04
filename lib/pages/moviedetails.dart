import 'package:flutter/material.dart';
import 'package:movies_app/api/api_service/tmdb_service.dart';
import 'package:movies_app/model/movie.dart';
import 'package:movies_app/utils/context_extension.dart';
import 'package:url_launcher/url_launcher.dart';

class MovieDetails extends StatefulWidget {
  final int id;
  const MovieDetails({super.key, required this.id});

  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  Movie? movie;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadMovie();
  }

  Future<void> loadMovie() async {
    try {
      movie = await TmdbService().getmoviedetails(widget.id);
    } catch (e) {
      print("Error loading movie: $e");
    }
    loading = false;
    if (mounted) setState(() {});
  }

  Future<void> _launchTrailer(String trailerKey) async {
    final url = Uri.parse('https://www.youtube.com/watch?v=$trailerKey');
    print("Launching trailer: $url"); // debug

    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(
          url,
          mode: LaunchMode.externalApplication, // <-- important
        );
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Could not open trailer")));
      }
    } catch (e) {
      print("Error launching URL: $e");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Could not open trailer")));
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenh = context.h;
    final screenw = context.w;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text(
          "movie details",
          style: TextStyle(color: Colors.red, fontFamily: 'pdark'),
        ),
        leading: Icon(Icons.arrow_back_ios_new, color: Colors.red),
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator(color: Colors.red))
          : movie == null
          ? const Center(child: Text("Failed to load movie"))
          : SingleChildScrollView(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Poster with YouTube overlay
                  Stack(
                    children: [
                      Container(
                        width: screenw,
                        height: screenh * 0.2,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                              "https://image.tmdb.org/t/p/w500${movie!.posterpath}",
                            ),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      if (movie!.trailerKey != null)
                        Positioned.fill(
                          child: Center(
                            child: IconButton(
                              icon: const Icon(
                                Icons.play_circle_outline,
                                size: 64,
                                color: Colors.red,
                              ),
                              onPressed: () =>
                                  _launchTrailer(movie!.trailerKey!),
                            ),
                          ),
                        ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Title
                  Text(
                    movie!.title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Rating
                  Text(
                    "Rating: ${movie!.voteaverage} ⭐",
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  ),

                  const SizedBox(height: 15),

                  // Overview
                  const Text(
                    "Overview",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    movie!.overview,
                    style: const TextStyle(fontSize: 15, color: Colors.white70),
                  ),
                ],
              ),
            ),
    );
  }
}
