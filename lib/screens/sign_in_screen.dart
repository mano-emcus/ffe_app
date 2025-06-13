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

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
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
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFD80B19),
                      borderRadius: BorderRadius.circular(27),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 49,
                        right: 50,
                        top: 14,
                        bottom: 14,
                      ),
                      child: Text(
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
