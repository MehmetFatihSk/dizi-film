import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'movie_detail_screen.dart';
import 'welcome_screen.dart'; // Import WelcomeScreen
import 'profile_screen.dart'; // Import ProfileScreen

class HomeScreen extends StatefulWidget { // Changed to StatefulWidget
  final String username;

  const HomeScreen({
    super.key,
    required this.username,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> { // State class

  // Logout function
  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('rememberMeUsername');
    await prefs.remove('rememberMePassword');
    // Navigate back to the WelcomeScreen
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const WelcomeScreen()),
      (Route<dynamic> route) => false, // Remove all routes from the stack
    );
  }

  @override
  Widget build(BuildContext context) {
    // Film görselleri listesi
    final List<String> movieImages = [
      'assets/images/movies/a.jpg',
      'assets/images/movies/fish.jpg',
      'assets/images/movies/lion.jpg',
      'assets/images/movies/s.jpg',
      'assets/images/movies/shark.jpg',
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar( // Added AppBar
        title: const Text('Home', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: _logout, // Call logout function
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),

                      // Kullanıcı karşılama bölümü
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 15,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(60),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Good Morning ${widget.username.substring(0, 3).toUpperCase()}", // Use widget.username
                                    style: const TextStyle(
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  const Text(
                                    "Enjoy Your Moment",
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 9,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 40,
                              height: 40,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFFE0CB0C),
                              ),
                              child: const Icon(
                                Icons.person,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 25),

                      // Film arama başlığı
                      const Text(
                        "Find You Movies",
                        style: TextStyle(
                          fontSize: 9,
                          fontFamily: 'Inter',
                          color: Colors.white,
                        ),
                      ),

                      const SizedBox(height: 15),

                      // Arama kutusu
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.grey[800],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Row(
                          children: [
                            SizedBox(width: 15),
                            Icon(
                              Icons.search,
                              color: Colors.white54,
                            ),
                            SizedBox(width: 10),
                            Text(
                              "Search movies...",
                              style: TextStyle(
                                color: Colors.white54,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 25),

                      // Devam eden filmler başlığı ve butonları
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Continue Watching",
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'Inter',
                              color: Colors.white,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              // "View More" işlevi
                            },
                            child: const Text(
                              "View More >>",
                              style: TextStyle(
                                fontSize: 11,
                                fontFamily: 'Inter',
                                color: Color(0xFFE0CB0C),
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 15),

                      // Devam eden filmler slaytı
                      SizedBox(
                        height: 150,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: movieImages.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: _buildMovieCard(context, movieImages[index % movieImages.length]),
                            );
                          },
                        ),
                      ),

                      const SizedBox(height: 25),

                      // Önerilen filmler başlığı ve butonları
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Recommend For You",
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'Inter',
                              color: Colors.white,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              // "View More" işlevi
                            },
                            child: const Text(
                              "View More >>",
                              style: TextStyle(
                                fontSize: 11,
                                fontFamily: 'Inter',
                                color: Color(0xFFE0CB0C),
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 15),

                      // Önerilen filmler slaytı - Karışık sırayla film görselleri
                      SizedBox(
                        height: 150,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: movieImages.length,
                          itemBuilder: (context, index) {
                            // Farklı bir gösterim sırası için
                            final reversedIndex = movieImages.length - 1 - index;
                            return Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: _buildMovieCard(context, movieImages[reversedIndex % movieImages.length]),
                            );
                          },
                        ),
                      ),

                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),

            // Alt menü
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: const BoxDecoration(
                color: Color(0xFF181818),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildNavItem("home_icon.png", true),
                  _buildNavItem("download_icon.png", false),
                  _buildNavItem("profile_icon.png", false),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Simple map for movie descriptions
  final Map<String, String> movieDescriptions = const {
    'assets/images/movies/a.jpg': 'This is a placeholder description for movie A. It is a fictional movie and this text is just to demonstrate how descriptions will appear on the detail page. Replace with actual movie details and a compelling summary of the plot and characters.',
    'assets/images/movies/fish.jpg': 'Finding Dory is a 2016 American computer-animated adventure film produced by Pixar Animation Studios and released by Walt Disney Pictures. It is the sequel to Finding Nemo (2003). The film features the voices of Ellen DeGeneres and Albert Brooks, reprising their roles from the first film, and also stars Ed O\'Neill, Kaitlin Olson, Ty Burrell, Diane Keaton, and Eugene Levy. The film focuses on the amnesiac fish Dory, who journeys to be reunited with her parents.',
    'assets/images/movies/lion.jpg': 'This is a placeholder description for the lion movie. It is a fictional movie and this text is just to demonstrate how descriptions will appear on the detail page. Replace with actual movie details and a compelling summary of the plot and characters.',
    'assets/images/movies/s.jpg': 'This is a placeholder description for movie S. It is a fictional movie and this text is just to demonstrate how descriptions will appear on the detail page. Replace with actual movie details and a compelling summary of the plot and characters.',
    'assets/images/movies/shark.jpg': 'This is a placeholder description for the shark movie. It is a fictional movie and this text is just to demonstrate how descriptions will appear on the detail page. Replace with actual movie details and a compelling summary of the plot and characters.',
  };

  Widget _buildMovieCard(BuildContext context, String imagePath) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MovieDetailScreen(
              imagePath: imagePath,
              description: movieDescriptions[imagePath] ?? 'No description available.',
            ),
          ),
        );
      },
      child: Container(
        width: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            // Film ismi ve bilgileri için koyu gradient
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              height: 60,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.7),
                    ],
                  ),
                ),
              ),
            ),

            // Oynat butonu
            Positioned(
              bottom: 10,
              right: 10,
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 5,
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.play_arrow,
                  color: Colors.black,
                  size: 20,
                ),
              ),
            ),

            // İlerleme durumu (sadece "Continue Watching" filmlerinde)
            Positioned(
              bottom: 0,
              left: 10,
              right: 10,
              child: Container(
                height: 3,
                margin: const EdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  color: Colors.grey[700],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 70, // Random ilerleme
                      height: 3,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        color: const Color(0xFFE0CB0C),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(String iconName, bool isActive) {
    // İkon adlarına göre Icon widget'ları oluşturuyoruz
    IconData getIconData(String name) {
      switch (name) {
        case "home_icon.png":
          return Icons.home;
        case "download_icon.png":
          return Icons.download;
        case "profile_icon.png":
          return Icons.person;
        default:
          return Icons.circle;
      }
    }

    return GestureDetector(
      onTap: () {
        if (iconName == "profile_icon.png") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ProfileScreen()),
          );
        }
        // Add navigation for other icons if needed
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFFE0CB0C) : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Icon(
          getIconData(iconName),
          size: 22,
          color: isActive ? Colors.black : Colors.white,
        ),
      ),
    );
  }
}
