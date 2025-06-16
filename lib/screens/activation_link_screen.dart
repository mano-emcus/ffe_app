import 'package:ffe_app/widgets/common_text_field_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

class ActivationLinkScreen extends StatefulWidget {
  const ActivationLinkScreen({super.key});

  @override
  State<ActivationLinkScreen> createState() => _ActivationLinkScreenState();
}

class _ActivationLinkScreenState extends State<ActivationLinkScreen> {
  final List<TextEditingController> _otpControllers = List.generate(6, (index) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());
  bool _isLoading = false;

  @override
  void dispose() {
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

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
                child: _buildOtpVerificationContainer(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOtpVerificationContainer() {
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
            top: 40,
            bottom: 38,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Verify Your Email',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1E1745),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              Text(
                'We have sent a 6-digit verification code to your email address. Please enter the code below to activate your account.',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF1E1745),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 32),
              _buildOtpInputFields(),
              SizedBox(height: 24),
              _buildVerifyButton(),
              SizedBox(height: 16),
              _buildResendSection(),
              SizedBox(height: 24),
              _buildDismissButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOtpInputFields() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(6, (index) {
        return Container(
          width: 45,
          height: 55,
          decoration: BoxDecoration(
            border: Border.all(
              color: _otpControllers[index].text.isNotEmpty 
                  ? Color(0xFF1E1745) 
                  : Color(0xFFE0E0E0),
              width: 2,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextField(
            controller: _otpControllers[index],
            focusNode: _focusNodes[index],
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            maxLength: 1,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1E1745),
            ),
            decoration: InputDecoration(
              counterText: '',
              border: InputBorder.none,
            ),
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            onChanged: (value) {
              setState(() {});
              if (value.isNotEmpty) {
                if (index < 5) {
                  _focusNodes[index + 1].requestFocus();
                } else {
                  _focusNodes[index].unfocus();
                }
              } else if (value.isEmpty && index > 0) {
                _focusNodes[index - 1].requestFocus();
              }
            },
          ),
        );
      }),
    );
  }

  Widget _buildVerifyButton() {
    bool isOtpComplete = _otpControllers.every((controller) => controller.text.isNotEmpty);
    
    return GestureDetector(
      onTap: isOtpComplete && !_isLoading ? _verifyOtp : null,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: isOtpComplete ? Color(0xFF1E1745) : Color(0xFFE0E0E0),
          borderRadius: BorderRadius.circular(27),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: _isLoading
              ? Center(
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                )
              : Text(
                  'Verify Code',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: isOtpComplete ? Colors.white : Color(0xFF9E9E9E),
                  ),
                  textAlign: TextAlign.center,
                ),
        ),
      ),
    );
  }

  Widget _buildResendSection() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: "Didn't receive the code? ",
        style: TextStyle(
          fontSize: 14,
          color: Color(0xFF757575),
        ),
        children: [
          TextSpan(
            text: "Resend Code",
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFFD80B19),
              fontWeight: FontWeight.w600,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = _resendOtp,
          ),
        ],
      ),
    );
  }

  Widget _buildDismissButton() {
    return GestureDetector(
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
    );
  }

  void _verifyOtp() {
    setState(() {
      _isLoading = true;
    });

    String otp = _otpControllers.map((controller) => controller.text).join();
    
    // TODO: Implement actual OTP verification logic here
    print('Verifying OTP: $otp');
    
    // Simulate API call
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
      
      // TODO: Handle verification result
      // On success: Navigate to next screen
      // On failure: Show error message
    });
  }

  void _resendOtp() {
    // TODO: Implement resend OTP logic here
    print('Resending OTP...');
    
    // Clear current OTP fields
    for (var controller in _otpControllers) {
      controller.clear();
    }
    setState(() {});
    
    // Focus on first field
    _focusNodes[0].requestFocus();
    
    // Show snackbar confirmation
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Verification code sent successfully'),
        backgroundColor: Color(0xFF1E1745),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
