import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: [
            Opacity(
              opacity: 0.9,
              child: Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage('assets/images/background_image_2.jpg'),
                  fit: BoxFit.cover,
                )),
              ),
            ),
            const AnimatedLoginButton(),
          ],
        ),
      ),
    );
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class AnimatedLoginButton extends StatefulWidget {
  const AnimatedLoginButton({super.key});

  @override
  _AnimatedLoginButtonState createState() => _AnimatedLoginButtonState();
}

class _AnimatedLoginButtonState extends State<AnimatedLoginButton> {
  bool _progressBarVisibility = false;
  bool _textVisibility = true;
  bool _successTextVisibility = false;
  late double _maxWidth, _maxHeight;
  double _width = 300;
  double _height = 60;
  double _opacity = 0;
  BorderRadiusGeometry _borderRadius = BorderRadius.circular(30);
  final Color _color = Colors.deepOrangeAccent;

  Future<void> _manageTextVisibility() async {
    await Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        if (_width == 60) {
          _textVisibility = false;
        }
      });
    });
  }

  Future<void> _manageProgressBarVisibility() async {
    await Future.delayed(const Duration(milliseconds: 200), () {
      setState(() {
        if (_width == 60) {
          _progressBarVisibility = true;
        } else {
          _progressBarVisibility = false;
        }
      });
    });
  }

  Future<void> _manageContainerExpansion() async {
    await Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        if (_width == 60) {
          _progressBarVisibility = false;
          _borderRadius = BorderRadius.circular(0);
          _width = _maxWidth;
          _height = _maxHeight;
        }
      });
    });
  }

  Future<void> _manageSuccessTextVisibility() async {
    await Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _successTextVisibility = true;
      });
    });
  }

  Future<void> _manageSuccessTextOpacity() async {
    await Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _opacity = 1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    _maxWidth = MediaQuery.of(context).size.width;
    _maxHeight = MediaQuery.of(context).size.height;

    return Column(
      children: [
        Flexible(
            flex: 50,
            fit: FlexFit.tight,
            child: Container(
              child: Image.asset('assets/images/tick.png'),
            )),
        Flexible(
            flex: 20,
            fit: FlexFit.tight,
            child: Padding(
              padding: const EdgeInsets.only(right: 20, left: 20),
              child: TextFormField(
                style: const TextStyle(
                  color: Colors.white,
                ),
                cursorColor: Colors.white,
                decoration: const InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.white,
                    )),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.white,
                    )),
                    prefixIcon: Icon(
                      Icons.account_circle_outlined,
                      color: Colors.white,
                    ),
                    hintText: 'Username',
                    hintStyle: TextStyle(
                      color: Colors.white,
                    )),
              ),
            )),
        Flexible(
            flex: 20,
            fit: FlexFit.tight,
            child: Padding(
              padding: const EdgeInsets.only(right: 20, left: 20),
              child: TextFormField(
                style: const TextStyle(
                  color: Colors.white,
                ),
                obscureText: true,
                cursorColor: Colors.white,
                decoration: const InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                    color: Colors.white,
                  )),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                    color: Colors.white,
                  )),
                  prefixIcon: Icon(
                    Icons.lock_outline_rounded,
                    color: Colors.white,
                  ),
                  hintText: 'Password',
                  hintStyle: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            )),
        Center(
          child: GestureDetector(
            child: AnimatedContainer(
              width: _width,
              height: _height,
              decoration: BoxDecoration(
                color: _color,
                borderRadius: _borderRadius,
              ),
              duration: const Duration(
                milliseconds: 1000,
              ),
              child: Center(
                child: Stack(
                  children: [
                    Visibility(
                      visible: _textVisibility,
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                        ),
                      ),
                    ),
                    Visibility(
                      visible: _progressBarVisibility,
                      child: const CircularProgressIndicator(
                        backgroundColor: Colors.white,
                        strokeWidth: 1,
                      ),
                    ),
                    Visibility(
                      visible: _successTextVisibility,
                      child: AnimatedOpacity(
                        opacity: _opacity,
                        duration: const Duration(seconds: 3),
                        child: const Text(
                          'Login Successful',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 35,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            onTap: () {
              setState(() {
                if (_width == 300) {
                  _width = 60;
                }
                _manageTextVisibility();
                _manageProgressBarVisibility();
                _manageContainerExpansion();
                _manageSuccessTextVisibility();
                _manageSuccessTextOpacity();
              });
            },
          ),
        ),
        const Spacer(
          flex: 5,
        ),
        // Text(
        //   "Don't have an account? Sign Up"
        // ),
        // Spacer(flex: 5,),
      ],
    );
  }
}
