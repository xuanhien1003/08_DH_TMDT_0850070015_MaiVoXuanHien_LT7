import 'package:flutter/material.dart';
import 'package:flutter_auth_animation/constants.dart';
import 'package:flutter_auth_animation/widgets/login_form.dart';
import 'package:flutter_auth_animation/widgets/sign_up_form.dart';
import 'package:flutter_auth_animation/widgets/socal_buttons.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin {
  bool _isShowSignup = false;

  late AnimationController _animationController;
  late Animation<double> _animationTextRotate;

  void setUpAnimation() {
    _animationController =
        AnimationController(vsync: this, duration: defaultDuration);

    _animationTextRotate =
        Tween<double>(begin: 0, end: 90).animate(_animationController);
  }

  void updateView() {
    setState(() {
      _isShowSignup = !_isShowSignup;
    });
    _isShowSignup
        ? _animationController.forward()
        : _animationController.reverse();
  }

  @override
  void initState() {
    setUpAnimation();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //man hinh: width, height
    final _size = MediaQuery.of(context).size;
    return Scaffold(
      body: AnimatedBuilder(
          animation: _animationController,
          builder: (context, _) {
            return Stack(
              children: [
                // login
                AnimatedPositioned(
                  duration: defaultDuration,
                  width: _size.width * 0.88,
                  height: _size.height,
                  left: _isShowSignup ? _size.width * 0.76 : 0,
                  child: Container(
                    color: login_bg,
                    child: LoginForm(),
                  ),
                ),

                // Sign up
                AnimatedPositioned(
                    duration: defaultDuration,
                    height: _size.height,
                    width: _size.width * 0.88,
                    left:
                        _isShowSignup ? _size.width * 0.12 : _size.width * 0.88,
                    child: Container(
                      color: signup_bg,
                      child: SignUpForm(),
                    )),

                // add logo
                AnimatedPositioned(
                  duration: defaultDuration,
                  top: _size.height * 0.1,
                  left: 0,
                  right:
                      _isShowSignup ? _size.width * 0.06 : _size.width * 0.06,
                  child: CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.white60,
                    child: AnimatedSwitcher(
                      duration: defaultDuration,
                      child: _isShowSignup
                          ? SvgPicture.asset(
                              "assets/animation_logo.svg",
                              color: signup_bg,
                            )
                          : SvgPicture.asset(
                              "assets/animation_logo.svg",
                              color: login_bg,
                            ),
                    ),
                  ),
                ),
                AnimatedPositioned(
                  duration: defaultDuration,
                  width: _size.width,
                  bottom: _size.height * 0.1,
                  right: _isShowSignup ? _size.width : _size.width, // center
                  child: SocalButtns(),
                ),

                // Login text
                //Login text animation
                AnimatedPositioned(
                    duration: defaultDuration,
                    bottom:
                        _isShowSignup ? _size.height / 2 : _size.height * 0.3,
                    left: _isShowSignup ? 0 : _size.width * 0.44 - 80,
                    child: AnimatedDefaultTextStyle(
                      duration: defaultDuration,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: _isShowSignup ? 20 : 32,
                        fontWeight: FontWeight.bold,
                        color: _isShowSignup ? Colors.black : Colors.white70,
                      ),
                      child: Transform.rotate(
                        angle: -_animationTextRotate.value * 3.14 / 180,
                        alignment: Alignment.topLeft,
                        child: InkWell(
                          onTap: () {
                            if (_isShowSignup) {
                              updateView();
                            } else {
                              //login
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: defpaultPadding * 0.75),
                            width: 160,
                            // color: Colors.red,
                            child: Text(
                              "Log In".toUpperCase(),
                            ),
                          ),
                        ),
                      ),
                    )),

                //Sign up text
                AnimatedPositioned(
                    duration: defaultDuration,
                    bottom: !_isShowSignup
                        ? _size.height / 2 - 80
                        : _size.height * 0.3,
                    left: _isShowSignup ? 150 : _size.width * 0.44 + 60,
                    child: AnimatedDefaultTextStyle(
                      duration: defaultDuration,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: !_isShowSignup ? 20 : 32,
                        fontWeight: FontWeight.bold,
                        color: _isShowSignup ? Colors.white : Colors.white70,
                      ),
                      child: Transform.rotate(
                        angle: (90 - _animationTextRotate.value) * 3.14 / 180,
                        alignment: Alignment.topRight,
                        child: InkWell(
                          onTap: () {
                            if (_isShowSignup) {
                              // sign up
                            } else {
                              updateView();
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: defpaultPadding * 0.75),
                            width: 160,
                            // color: Colors.red,
                            child: Text(
                              "Sign up 2".toUpperCase(),
                            ),
                          ),
                        ),
                      ),
                    ))
              ],
            );
          }),
    );
  }
}
