import 'package:ffe_app/widgets/common_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with SingleTickerProviderStateMixin {
  bool isGood = true;
  bool isFault = false;
  bool isFire = false;
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;
  Color _currentColor = const Color(0xff1BA47F);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _colorAnimation = ColorTween(
      begin: _currentColor,
      end: _currentColor,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  void _updateColorAnimation() {
    final Color newColor =
        isGood
            ? const Color(0xff1BA47F)
            : isFault
            ? const Color(0xFFE98800)
            : const Color(0xFFC21330);

    _colorAnimation = ColorTween(
      begin: _currentColor,
      end: newColor,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _currentColor = newColor;
    _controller.forward(from: 0.0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1E1745),
      appBar: const CommonAppBar(),
      // drawer: const AppDrawer(),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 16,
                bottom: 96,
                left: 16,
                right: 16,
              ),
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xff160961),
                          _colorAnimation.value ?? const Color(0xff1BA47F),
                        ],
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                      ),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: child,
                  );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 60),
                    SvgPicture.asset(
                      'assets/svgs/ray_gun_logo.svg',
                      width: 500,
                    ),
                    const SizedBox(height: 60),
                    Text(
                      'SIGNAL STRENGTH',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '95%',
                      style: GoogleFonts.poppins(
                        fontSize: 70,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (isGood) {
                            isGood = false;
                            isFault = true;
                            isFire = false;
                          } else if (isFault) {
                            isGood = false;
                            isFault = false;
                            isFire = true;
                          } else if (isFire) {
                            isGood = true;
                            isFault = false;
                            isFire = false;
                          }
                          _updateColorAnimation();
                        });
                      },
                      child: Container(
                        height: 78,
                        decoration: BoxDecoration(
                          color: isGood
                              ? Colors.black.withValues(alpha: 0.3)
                              : isFault
                              ? Colors.black.withValues(alpha: 0.3)
                              : const Color(0xFFFFFFFF).withValues(alpha: 0.7),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 45),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                isGood
                                    ? 'GOOD'
                                    : isFault
                                    ? 'FAULT'
                                    : 'FIRE',
                                style: GoogleFonts.poppins(
                                  fontSize: 36,
                                  fontWeight: FontWeight.bold,
                                  color: isGood
                                      ? const Color(0xff88B51F)
                                      : isFault
                                      ? const Color(0xFFE98800)
                                      : const Color(0xFFC21330),
                                ),
                              ),
                              const SizedBox(width: 10),
                              isGood
                                      ? SvgPicture.asset('assets/svgs/good_icon.svg')
                                  : isFault
                                  ? SvgPicture.asset('assets/svgs/fault_icon.svg')
                                  : SvgPicture.asset('assets/svgs/fire_icon.svg'),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SvgPicture.asset(
                      'assets/svgs/waves.svg',  
                      colorFilter: ColorFilter.mode(
                        isGood
                            ? const Color(0xff88B51F)
                            : isFault
                            ? const Color(0xFF343131)
                            : const Color(0xFFFFFFFF),
                        BlendMode.srcIn,
                      ),
                      width: MediaQuery.sizeOf(context).width,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
