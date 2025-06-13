import 'package:ffe_app/screens/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}


class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SignInScreen()));
      }
    });
    super.initState();
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
