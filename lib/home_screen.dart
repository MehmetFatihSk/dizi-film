import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final String username;
  
  const HomeScreen({
    super.key,
    required this.username,
  });

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
                                    "Good Morning ${username.substring(0, 3).toUpperCase()}",
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
                              child: _buildMovieCard(movieImages[index % movieImages.length]),
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
                              child: _buildMovieCard(movieImages[reversedIndex % movieImages.length]),
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

  Widget _buildMovieCard(String imagePath) {
    return Container(
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

    return Container(
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
    );
  }
} 