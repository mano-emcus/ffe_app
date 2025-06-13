import 'package:ffe_app/core/api/auth_service.dart';
import 'package:ffe_app/screens/home_screen/home_screen.dart';
import 'package:ffe_app/screens/sign_up_screen.dart';
import 'package:ffe_app/widgets/common_text_field_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  bool isRememberMe = false;
  bool isLoading = false;
  String? errorMessage;
  late final AuthService _authService;
  bool _isInitialized = false;

  @override
  void initState() {
    emailController = TextEditingController(text: 'geminiAdmin@gmail.com');
    passwordController = TextEditingController(text: 'GeminiAdmin@123');
    _authService = AuthService();
    _initializeAuthService();
    super.initState();
  }

  Future<void> _initializeAuthService() async {
    try {
      // Wait for token storage initialization
      await Future.delayed(Duration.zero);
      if (mounted) {
        setState(() {
          _isInitialized = true;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          errorMessage = 'Failed to initialize: ${e.toString()}';
          _isInitialized = true;
        });
      }
    }
  }

  Future<void> _handleSignIn() async {
    if (!_isInitialized) {
      setState(() {
        errorMessage = 'Please wait while we initialize...';
      });
      return;
    }

    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      setState(() {
        errorMessage = 'Please fill in all fields';
      });
      return;
    }

    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final response = await _authService.signIn(
        email: emailController.text.trim(),
        password: passwordController.text,
      );

      if (mounted) {
        // Navigate to home screen on success
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          print(e);
          errorMessage = e.toString().replaceAll('ApiException: [0] ', '');
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return Scaffold(
        backgroundColor: Color(0xFF1E1745),
        body: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        ),
      );
    }

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
                child: _buildSignInContainer(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSignInContainer() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 21),
      child: IntrinsicHeight(
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
              top: 25,
              bottom: 38,
            ),
            child: Column(
              children: [
                Text(
                  'Sign In',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF1E1745),
                  ),
                ),
                SizedBox(height: 15),
                if (errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Text(
                      errorMessage!,
                      style: TextStyle(
                        color: Color(0xFFD80B19),
                        fontSize: 14,
                      ),
                    ),
                  ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Email Address',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                ),
                SizedBox(height: 10),
                CommonTextFieldWidget(
                  controller: emailController,
                  hintText: 'Enter your email address',
                  isEmail: true,
                ),
                SizedBox(height: 13),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Password',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                ),
                SizedBox(height: 10),
                CommonTextFieldWidget(
                  controller: passwordController,
                  hintText: 'Enter your password',
                  isPassword: true,
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isRememberMe = !isRememberMe;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                          right: 10,
                          top: 10,
                          bottom: 10,
                        ),
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(3),
                            border: Border.all(
                              color: Color(0xFF707070).withValues(alpha: 0.2),
                            ),
                          ),
                          child:
                              isRememberMe
                                  ? Icon(
                                    Icons.check,
                                    color: Colors.black,
                                    size: 16,
                                  )
                                  : null,
                        ),
                      ),
                    ),
                    // SizedBox(width: 10),
                    Text(
                      'Remember me',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF1E1745),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 3),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFFD80B19),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                GestureDetector(
                  onTap: isLoading ? null : _handleSignIn,
                  child: Container(
                    decoration: BoxDecoration(
                      color: isLoading ? Color(0xFFD80B19).withOpacity(0.7) : Color(0xFFD80B19),
                      borderRadius: BorderRadius.circular(27),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 49,
                        right: 50,
                        top: 14,
                        bottom: 14,
                      ),
                      child: isLoading
                          ? SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          : Text(
                              'Sign In',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Don\'t have an account? ',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF1E1745),
                        ),
                      ),
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            // print('Sign up here'); 
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SignUpScreen()),
                            );
                          },
                        text: 'Sign up here',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFFD80B19),
                        ),
                      ),
                    ],
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
