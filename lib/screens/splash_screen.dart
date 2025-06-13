import 'package:ffe_app/core/api/auth_service.dart';
import 'package:ffe_app/screens/home_screen/home_screen.dart';
import 'package:ffe_app/screens/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late final AuthService _authService;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _authService = AuthService();
    _initialize();
  }

  Future<void> _initialize() async {
    try {
      // Wait for both initialization and minimum splash duration
      await Future.wait([
        _authService.initTokenStorage(),
        Future.delayed(const Duration(seconds: 2)),
      ]);

      if (!mounted) return;

      final isLoggedIn = await _authService.isLoggedIn();
      
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => isLoggedIn
              ? const HomeScreen()
              : const SignInScreen(),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      
      setState(() {
        _isLoading = false;
        _error = 'Failed to initialize: ${e.toString()}';
      });

      // Wait a bit before navigating to sign in screen
      await Future.delayed(const Duration(seconds: 1));
      
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SignInScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  width: 100,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFFDC0613), // Solid red
                        Color.fromARGB(255, 88, 3, 9)
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  width: 100,
                  decoration: BoxDecoration(color: Color(0xFF1E1745)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset('assets/svgs/ble_icon.svg', colorFilter: ColorFilter.mode(Colors.transparent, BlendMode.srcIn),),
                      SizedBox(height: 14),
                      SvgPicture.asset('assets/svgs/ffe_logo.svg'),
                      SizedBox(height: 14),
                      SvgPicture.asset('assets/svgs/ble_icon.svg'),
                      if (_isLoading) ...[
                        SizedBox(height: 20),
                        SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        ),
                      ],
                      if (_error != null) ...[
                        SizedBox(height: 20),
                        Text(
                          _error!,
                          style: TextStyle(color: Colors.red[300], fontSize: 12),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.lerp(Alignment.bottomLeft, Alignment.topLeft, 0.7) ?? Alignment.bottomCenter,
            child: Image.asset('assets/images/ffe_device_logo.png'),
          ),
        ],
      ),
    );
  }
}
