import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_screen.dart';
import 'welcome_screen.dart';
import 'forgot_password_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget _initialScreen = const WelcomeScreen();

  @override
  void initState() {
    super.initState();
    _checkRememberMe();
  }

  Future<void> _checkRememberMe() async {
    final prefs = await SharedPreferences.getInstance();
    final savedUsername = prefs.getString('rememberMeUsername');
    if (savedUsername != null) {
      setState(() {
        _initialScreen = HomeScreen(username: savedUsername);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFE94834)),
        useMaterial3: true,
        fontFamily: 'Inter',
      ),
      home: _initialScreen,
    );
  }
}

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _errorMessage;
  bool _isLoading = false;
  bool _rememberMe = false; // Added remember me state

  @override
  void initState() {
    super.initState();
    _loadRememberMeCredentials(); // Load saved credentials on init
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Load saved credentials from shared preferences
  Future<void> _loadRememberMeCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    final savedUsername = prefs.getString('rememberMeUsername');
    final savedPassword = prefs.getString('rememberMePassword');
    if (savedUsername != null && savedPassword != null) {
      _emailController.text = savedUsername;
      _passwordController.text = savedPassword;
      setState(() {
        _rememberMe = true;
      });
    }
  }

  // Save credentials to shared preferences
  Future<void> _saveRememberMeCredentials(String username, String password) async {
    final prefs = await SharedPreferences.getInstance();
    if (_rememberMe) {
      prefs.setString('rememberMeUsername', username);
      prefs.setString('rememberMePassword', password);
    } else {
      prefs.remove('rememberMeUsername');
      prefs.remove('rememberMePassword');
    }
  }

  // Kullanıcı girişini doğrulama metodu
  void _validateAndLogin() async { // Made async to use await
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    // Email alanı username olarak kullanılacak
    final username = _emailController.text.trim();
    final password = _passwordController.text.trim();

    // Dummy gecikme ekliyoruz
    await Future.delayed(const Duration(seconds: 1)); // Use await

    if (username == "fatih123" && password == "12345") {
      // Başarılı giriş
      await _saveRememberMeCredentials(username, password); // Save credentials
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(username: username),
        ),
      );
    } else {
      // Başarısız giriş
      setState(() {
        _errorMessage = "Geçersiz kullanıcı adı veya şifre!";
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF181818),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 60),

                // Sign In başlığı
                const Text(
                  'Sign In',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Inter',
                  ),
                ),

                const SizedBox(height: 50),

                // Email alanı
                const Text(
                  'Email',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Inter',
                  ),
                ),

                const SizedBox(height: 16),

                // Email input alanı
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(60),
                    border: Border.all(color: const Color(0xFFE0CB0C), width: 2),
                  ),
                  child: TextField(
                    controller: _emailController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      border: InputBorder.none,
                      hintText: 'Kullanıcı adı: fatih123',
                      hintStyle: TextStyle(color: Colors.white54),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // Şifre alanı
                const Text(
                  'Password',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Inter',
                  ),
                ),

                const SizedBox(height: 16),

                // Şifre input alanı
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(60),
                    border: Border.all(color: const Color(0xFFE0CB0C), width: 2),
                  ),
                  child: TextField(
                    controller: _passwordController,
                    obscureText: true,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      border: InputBorder.none,
                      hintText: 'Şifre: 12345',
                      hintStyle: TextStyle(color: Colors.white54),
                    ),
                  ),
                ),

                // Remember Me checkbox
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: _rememberMe,
                          onChanged: (value) {
                            setState(() {
                              _rememberMe = value ?? false;
                            });
                          },
                          activeColor: const Color(0xFFE0CB0C),
                        ),
                        const Text(
                          'Remember Me',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: 'Inter',
                          ),
                        ),
                      ],
                    ),
                    // Forgot Password butonu
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ForgotPasswordScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ),
                  ],
                ),

                // Hata mesajı
                if (_errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: Text(
                      _errorMessage!,
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 14,
                      ),
                    ),
                  ),

                const SizedBox(height: 40),

                // Sign In butonu
                GestureDetector(
                  onTap: _isLoading ? null : _validateAndLogin,
                  child: Container(
                    width: double.infinity,
                    height: 56,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(60),
                      border: Border.all(color: const Color(0xFFE0CB0C), width: 2),
                    ),
                    child: Center(
                      child: _isLoading
                          ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                          : const Text(
                        'Sign In',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // OR
                const Center(
                  child: Text(
                    'OR',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: 'Inter',
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                // Continue with Google butonu
                GestureDetector(
                  onTap: () {
                    // Google ile giriş işlemleri burada yapılacak
                  },
                  child: Container(
                    width: double.infinity,
                    height: 56,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(60),
                      border: Border.all(color: const Color(0xFFE0CB0C), width: 2),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Google ikonu
                        Container(
                          width: 24,
                          height: 24,
                          margin: const EdgeInsets.only(right: 12),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: ClipOval(
                            child: Image.asset(
                              'assets/images/google.png',
                              width: 20,
                              height: 20,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const Text(
                          'Continue with Google',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: 'Inter',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
