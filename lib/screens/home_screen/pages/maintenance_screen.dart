import 'package:ffe_app/widgets/common_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class MaintenanceScreen extends StatefulWidget {
  const MaintenanceScreen({super.key});

  @override
  State<MaintenanceScreen> createState() => _MaintenanceScreenState();
}

class _MaintenanceScreenState extends State<MaintenanceScreen> {
  double agcProgress = 0.2; // Default 20%

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1E1745),
      appBar: CommonAppBar(title: 'Maintenance'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              SizedBox(height: 15),
              _buildAutoGainControlContainer(),
              SizedBox(height: 15),
              _buildDeviceLogsContainer(alarmCount: 20, faultCount: 12),
              SizedBox(height: 15),
              _buildFireTestContainer(),
              SizedBox(height: 15),
              _buildReCofigureAlignmentContainer(),
              SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAutoGainControlContainer() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFEFEFEF), Color(0xFFF1F1F1)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Auto Gain Control (AGC)'),
            SizedBox(height: 36),
            _buildAgcSliderWidget(),
          ],
        ),
      ),
    );
  }

  Widget _buildAgcSliderWidget() {
    const double fixedGreenWidth = 0.4; // Fixed 40% width for green section
    return SizedBox(
      height: 80,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          // Progress Bar with Slider
          Positioned(
            top: 45,
            left: 0,
            right: 0,
            child: GestureDetector(
              onHorizontalDragUpdate: (details) {
                final RenderBox box = context.findRenderObject() as RenderBox;
                final double width = box.size.width;
                final double dx = details.localPosition.dx.clamp(0, width);
                setState(() {
                  agcProgress = (dx / width).clamp(0.0, 1.0);
                });
              },
              child: Container(
                height: 28,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: (fixedGreenWidth * 100).toInt(),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xFF6CB33F),
                          borderRadius: BorderRadius.horizontal(
                            left: Radius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 100 - (fixedGreenWidth * 100).toInt(),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFE89B23),
                          borderRadius: BorderRadius.horizontal(
                            right: Radius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Percentage Indicator
          Positioned(
            left: (agcProgress * (MediaQuery.of(context).size.width - 32)) - 15, // Adjusted for padding and indicator width
            top: 0,
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Transform.rotate(
                      angle: 0.785398, // 45 degrees in radians (pi/4)
                      child: Container(
                        width: 33,
                        height: 33,
                        decoration: BoxDecoration(
                          color: Color(0xFF96B53A),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                            bottomLeft: Radius.circular(20),
                          ),
                        ),
                      ),
                    ),
                    Text(
                      '${(agcProgress * 100).toInt()}%',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                Container(
                  width: 2, 
                  height: 40, 
                  color: Color(0xFF96B53A),
                ),
              ],
            ),
          ),
          // Add invisible touch area for better edge interaction
          Positioned.fill(
            child: GestureDetector(
              onHorizontalDragUpdate: (details) {
                final RenderBox box = context.findRenderObject() as RenderBox;
                final double width = box.size.width;
                final double dx = details.localPosition.dx.clamp(0, width);
                setState(() {
                  agcProgress = (dx / width).clamp(0.0, 1.0);
                });
              },
              child: Container(
                color: Colors.transparent,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeviceLogsContainer({
    required int alarmCount,
    required int faultCount,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFEFEFEF), Color(0xFFF1F1F1)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Device Logs'),
            SizedBox(height: 10),
            Divider(color: Color(0xFF707070), thickness: 1),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Alarm Count',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF333333),
                  ),
                ),
                Text(
                  '$alarmCount',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF333333),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Fault Count',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF333333),
                  ),
                ),
                Text(
                  '$faultCount',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF333333),
                  ),
                ),
              ],
            ),
            SizedBox(height: 41),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF707070).withValues(alpha: 0.4),
                    borderRadius: BorderRadius.circular(21),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 12,
                    ),
                    child: Text(
                      'Retrieve Logs',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF333333),
                      ),
                    ),
                  ),
                ),

                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF707070).withValues(alpha: 0.4),
                    borderRadius: BorderRadius.circular(21),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 12,
                    ),
                    child: Text(
                      'Reset Count',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF333333),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFireTestContainer() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFEFEFEF), Color(0xFFF1F1F1)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 23),
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFF707070).withValues(alpha: 0.4),
            borderRadius: BorderRadius.circular(21),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
            child: Center(
              child: Text(
                'Fire Test',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF333333),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildReCofigureAlignmentContainer() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFEFEFEF), Color(0xFFF1F1F1)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 23),
        child: Column(
          children: [
            SvgPicture.asset('assets/svgs/reconfigure_ray_gun_logo.svg'),
            SizedBox(height: 18),
            Container(
              decoration: BoxDecoration(
                color: Color(0xFF707070).withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(21),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 12,
                ),
                child: Center(
                  child: Text(
                    'Re Configure Alignment',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF333333),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
