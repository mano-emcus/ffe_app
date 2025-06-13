import 'package:ffe_app/widgets/common_text_field_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ActivationLinkScreen extends StatefulWidget {
  const ActivationLinkScreen({super.key});

  @override
  State<ActivationLinkScreen> createState() => _ActivationLinkScreenState();
}

class _ActivationLinkScreenState extends State<ActivationLinkScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Color(0xFF1E1745),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: SvgPicture.asset('assets/svgs/ffe_logo_white.svg'),
          ),
          SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height - 30,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: _buildActivationLinkContainer(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivationLinkContainer() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 21, top: 50),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(17),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 21,
            right: 21,
            top: 56,
            bottom: 38,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'An email has been sent to your email address containing the activation link.\n\nPlease click the link to activate your account.\n\nIf you do not receive the email within a few minutes, please check your spam folder.',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF1E1745),
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 17),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFD80B19),
                    borderRadius: BorderRadius.circular(27),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 87,
                      vertical: 14,
                    ),
                    child: Text(
                      'Dismiss',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
