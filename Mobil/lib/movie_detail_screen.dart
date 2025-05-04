import 'package:flutter/material.dart';

class MovieDetailScreen extends StatelessWidget {
  final String imagePath;
  final String description;

  const MovieDetailScreen({
    super.key,
    required this.imagePath,
    required this.description,
  });

  // Dummy data for movie details (replace with actual data fetching)
  String getMovieTitle(String path) {
    switch (path) {
      case 'assets/images/movies/a.jpg':
        return 'Movie A Title';
      case 'assets/images/movies/fish.jpg':
        return 'Finding Dory'; // Based on the image
      case 'assets/images/movies/lion.jpg':
        return 'Lion Movie Title';
      case 'assets/images/movies/s.jpg':
        return 'Movie S Title';
      case 'assets/images/movies/shark.jpg':
        return 'Shark Movie Title';
      default:
        return 'Unknown Movie';
    }
  }

  double getMovieRating(String path) {
    switch (path) {
      case 'assets/images/movies/fish.jpg':
        return 7.2; // Based on the image
      default:
        return 0.0;
    }
  }

  String getMovieDuration(String path) {
    switch (path) {
      case 'assets/images/movies/fish.jpg':
        return '1h 45min'; // Based on the image
      default:
        return 'N/A';
    }
  }

  String getMovieGenre(String path) {
    switch (path) {
      case 'assets/images/movies/fish.jpg':
        return 'Adventure'; // Based on the image
      default:
        return 'N/A';
    }
  }


  @override
  Widget build(BuildContext context) {
    final movieTitle = getMovieTitle(imagePath);
    final movieRating = getMovieRating(imagePath);
    final movieDuration = getMovieDuration(imagePath);
    final movieGenre = getMovieGenre(imagePath);

    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.asset(
                  imagePath,
                  width: double.infinity,
                  height: 400, // Adjust height as needed
                  fit: BoxFit.cover,
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back, color: Colors.white),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.bookmark_border, color: Colors.white),
                          onPressed: () {
                            // Bookmark functionality
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  left: 16,
                  right: 16,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        movieTitle,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.yellow[700], size: 16),
                          const SizedBox(width: 4),
                          Text(
                            movieRating.toString(),
                            style: const TextStyle(color: Colors.white, fontSize: 14),
                          ),
                          const SizedBox(width: 16),
                          Icon(Icons.timer, color: Colors.white70, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            movieDuration,
                            style: const TextStyle(color: Colors.white70, fontSize: 14),
                          ),
                          const SizedBox(width: 16),
                          Icon(Icons.category, color: Colors.white70, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            movieGenre,
                            style: const TextStyle(color: Colors.white70, fontSize: 14),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Story Line',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // Watch Now functionality
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE0CB0C),
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      icon: const Icon(Icons.play_arrow),
                      label: const Text(
                        'Watch Now',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
