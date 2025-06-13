import 'package:ffe_app/utils/triangle_painter.dart';
import 'package:ffe_app/widgets/common_app_bar.dart';
import 'package:ffe_app/widgets/toggle_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class DiagnosticsScreen extends StatefulWidget {
  const DiagnosticsScreen({super.key});

  @override
  State<DiagnosticsScreen> createState() => _DiagnosticsScreenState();
}

class _DiagnosticsScreenState extends State<DiagnosticsScreen> {
  bool isMotorTesting = false;
  bool isRedLed = false;
  bool isAmberLed = false;
  bool isGreenLed = false;
  double outputPowerPercentage = 35.0;
  double rxSensitivityPercentage = 20.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1E1745),
      appBar: CommonAppBar(title: 'Diagnostics'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              SizedBox(height: 15),
              _buildMotorRemoteContainer(),
              SizedBox(height: 15),
              _buildDeviceInfoContainer(),
              SizedBox(height: 15),
              _buildLedTestContainer(),
              SizedBox(height: 15),
              _buildOutputPowerContainer(),
              SizedBox(height: 15),
              _buildRxSensitivityContainer(),
              SizedBox(height: 15),
              _buildTempContainer(),
              SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMotorRemoteContainer() {
    return Column(
      children: [
        Container(
          height: 350,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFEFEFEF), Color(0xFFF1F1F1)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: IntrinsicHeight(
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF333333), Colors.black],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.circular(13),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 22),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'RECEIVED SIGNAL STRENGTH',
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            '100%',
                            style: GoogleFonts.inter(
                              fontSize: 60,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF88B51F),
                            ),
                          ),
                          SizedBox(height: 143),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: 152,
                      height: 152,
                      decoration: BoxDecoration(
                        color: Color(0xFF24883B),
                        shape: BoxShape.circle,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomPaint(
                              size: Size(20, 20),
                              painter: TrianglePainter(color: Colors.white),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomPaint(
                                  size: Size(20, 20),
                                  painter: TrianglePainter(
                                    color: Colors.white,
                                    rotationAngle: -90,
                                  ),
                                ),
                                Container(
                                  height: 70,
                                  width: 70,
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Color(0xFF31AC4D),
                                      width: 2,
                                    ),
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: Text(
                                        'OK',
                                        style: GoogleFonts.inter(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF31AC4D),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                CustomPaint(
                                  size: Size(20, 20),
                                  painter: TrianglePainter(
                                    color: Colors.white,
                                    rotationAngle: 90,
                                  ),
                                ),
                              ],
                            ),
                            CustomPaint(
                              size: Size(20, 20),
                              painter: TrianglePainter(
                                color: Colors.white,
                                rotationAngle: 180,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xFFF1F1F1),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'MOTOR TESTING',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF333333),
                      ),
                    ),
                    ToggleButtonWidget(
                      isMotorTesting: isMotorTesting,
                      onToggle: (value) {
                        setState(() {
                          isMotorTesting = value;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Right Rotation',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF333333),
                      ),
                    ),
                    Text(
                      'NOT TESTED',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF595959),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Left Rotation',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF333333),
                      ),
                    ),
                    Text(
                      'NOT TESTED',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF595959),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Top Rotation',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF333333),
                      ),
                    ),
                    Text(
                      'NOT TESTED',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF595959),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Bottom Rotation',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF333333),
                      ),
                    ),
                    Text(
                      'NOT TESTED',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF595959),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDeviceInfoContainer() {
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
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 23),
        child: Column(
          children: [
            Text(
              'Device Information',
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF333333),
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Manufacturing Date',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.black.withValues(alpha: 0.5),
                        ),
                      ),
                      // 10-Jun-2023
                      Text(
                        DateFormat('dd-MMM-yyyy').format(DateTime.now()),
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF333333),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    height: 40,
                    child: VerticalDivider(
                      color: Color.fromARGB(255, 196, 195, 195),
                      thickness: 1,
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Firmware Version',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.black.withValues(alpha: 0.5),
                        ),
                      ),
                      Text(
                        'Version 1.01',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF333333),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 18),
            Container(
              decoration: BoxDecoration(
                color: Color(0xffDC0613),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Text(
                  'More Details',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLedTestContainer() {
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
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 23),
        child: Column(
          children: [
            Text(
              'LED Test',
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF333333),
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Container(
                  width: 60,
                  height: 25,
                  decoration: BoxDecoration(color: Color(0xffDC0613)),
                ),
                SizedBox(width: 10),
                Text(
                  'Red LED',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF333333),
                  ),
                ),
                Spacer(),
                ToggleButtonWidget(
                  isMotorTesting: isRedLed,
                  onToggle: (value) {
                    setState(() {
                      isRedLed = value;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Container(
                  width: 60,
                  height: 25,
                  decoration: BoxDecoration(color: Color(0xffFFA500)),
                ),
                SizedBox(width: 10),
                Text(
                  'Amber LED',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF333333),
                  ),
                ),
                Spacer(),
                ToggleButtonWidget(
                  isMotorTesting: isAmberLed,
                  onToggle: (value) {
                    setState(() {
                      isAmberLed = value;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Container(
                  width: 60,
                  height: 25,
                  decoration: BoxDecoration(color: Color(0xFF31AC4D)),
                ),
                SizedBox(width: 10),
                Text(
                  'Green LED',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF333333),
                  ),
                ),
                Spacer(),
                ToggleButtonWidget(
                  isMotorTesting: isGreenLed,
                  onToggle: (value) {
                    setState(() {
                      isGreenLed = value;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOutputPowerContainer() {
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
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 23),
        child: Column(
          children: [
            Text(
              'Output Power',
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF333333),
              ),
            ),
            SizedBox(height: 16),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Power transmitted to the LASER beam',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF333333),
                ),
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(26),
                    ),
                    child: Stack(
                      children: [
                        // Background progress bar
                        Container(
                          width:
                              (MediaQuery.of(context).size.width - 100) *
                              (outputPowerPercentage / 100),
                          decoration: BoxDecoration(
                            color: Color(0xFF31AC4D),
                            borderRadius: BorderRadius.circular(26),
                          ),
                        ),
                        // Slider
                        SliderTheme(
                          data: SliderThemeData(
                            trackHeight: 40,
                            thumbColor: Colors.transparent,
                            activeTrackColor: Color(0xFF31AC4D),
                            inactiveTrackColor: Colors.white,
                            thumbShape: RoundSliderThumbShape(
                              enabledThumbRadius: 0,
                              elevation: 0,
                            ),
                            overlayShape: RoundSliderOverlayShape(
                              overlayRadius: 0,
                            ),
                          ),
                          child: Slider(
                            value: outputPowerPercentage,
                            min: 0,
                            max: 100,
                            divisions: 100,
                            onChanged: (value) {
                              setState(() {
                                outputPowerPercentage = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  '${outputPowerPercentage.round()}%',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF333333),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRxSensitivityContainer() {
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
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 23),
        child: Column(
          children: [
            Text(
              'Receiver Sensitivity',
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF333333),
              ),
            ),
            SizedBox(height: 16),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Amount of light received from the reflector.',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF333333),
                ),
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(26),
                    ),
                    child: Stack(
                      children: [
                        // Background progress bar
                        Container(
                          width:
                              (MediaQuery.of(context).size.width - 100) *
                              (rxSensitivityPercentage / 100),
                          decoration: BoxDecoration(
                            color: Color(0xFF31AC4D),
                            borderRadius: BorderRadius.circular(26),
                          ),
                        ),
                        // Slider
                        SliderTheme(
                          data: SliderThemeData(
                            trackHeight: 40,
                            thumbColor: Colors.transparent,
                            activeTrackColor: Color(0xFF31AC4D),
                            inactiveTrackColor: Colors.white,
                            thumbShape: RoundSliderThumbShape(
                              enabledThumbRadius: 0,
                              elevation: 0,
                            ),
                            overlayShape: RoundSliderOverlayShape(
                              overlayRadius: 0,
                            ),
                          ),
                          child: Slider(
                            value: rxSensitivityPercentage,
                            min: 0,
                            max: 100,
                            divisions: 100,
                            onChanged: (value) {
                              setState(() {
                                rxSensitivityPercentage = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  '${rxSensitivityPercentage.round()}%',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF333333),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTempContainer() {
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
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 23),
        child: Column(
          children: [
            Text(
              'Temperature',
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF333333),
              ),
            ),
            SizedBox(height: 16),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Heat recorded at Device.',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF333333),
                ),
              ),
            ),
            SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: Color(0xFF31AC4D),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Text(
                  '+35°C',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
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
