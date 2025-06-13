import 'package:ffe_app/screens/activation_link_screen.dart';
import 'package:ffe_app/widgets/common_text_field_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late TextEditingController nameController;
  late TextEditingController companyNameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  bool isTermsAndConditions = false;
  @override
  void initState() {
    nameController = TextEditingController();
    companyNameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
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
                child: _buildSignUpContainer(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSignUpContainer() {
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
                  'Register',
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
                    'Name',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                ),
                SizedBox(height: 10),
                CommonTextFieldWidget(
                  controller: nameController,
                  hintText: 'Enter your name',
                  isName: true,
                ),
                SizedBox(height: 13),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Company Name',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                ),
                SizedBox(height: 10),
                CommonTextFieldWidget(
                  controller: companyNameController,
                  hintText: 'Enter your company name',
                  isName: true,
                ),
                SizedBox(height: 13),
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
                SizedBox(height: 13),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Confirm Password',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                ),
                SizedBox(height: 10),
                CommonTextFieldWidget(
                  controller: confirmPasswordController,
                  hintText: 'Enter your password',
                  isPassword: true,
                ),
                SizedBox(height: 5),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isTermsAndConditions = !isTermsAndConditions;
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
                          child: Icon(
                            Icons.check,
                            color:
                                isTermsAndConditions
                                    ? Colors.transparent
                                    : Colors.black,
                            size: 16,
                          ),
                        ),
                      ),
                    ),
                    // SizedBox(width: 10),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text:
                                    'By signing up you are agreeing with the FFE ',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF1E1745),
                                ),
                              ),
                              TextSpan(
                                text: 'Terms & Conditions',
                                recognizer:
                                    TapGestureRecognizer()
                                      ..onTap = () {
                                        print('Terms & Conditions');
                                      },
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFFD80B19),
                                ),
                              ),
                              TextSpan(
                                text: ' and ',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF1E1745),
                                ),
                              ),
                              TextSpan(
                                text: 'Privacy Policy',
                                recognizer:
                                    TapGestureRecognizer()
                                      ..onTap = () {
                                        print('Terms & Conditions');
                                      },
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFFD80B19),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 17),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFF0F3F5),
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
                          'Cancel',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => ActivationLinkScreen(),
                          ),
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
                            'Register',
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
                SizedBox(height: 16),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Already have account? ',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF1E1745),
                        ),
                      ),
                      TextSpan(
                        recognizer:
                            TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pop(context);
                              },
                        text: 'Sign in here.',
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
