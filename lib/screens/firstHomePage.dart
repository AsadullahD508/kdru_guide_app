import 'dart:async';
import 'package:flutter/material.dart';
import '../widgets/custom_header.dart';
import 'home_screen.dart';

class HomeFirstPage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomeFirstPage>
    with SingleTickerProviderStateMixin {
  final List<String> galleryImages = [
    'images/kdr.jpg',
    'images/kdr.jpg',
    'images/kdr.jpg',
    'images/kdr.jpg',
  ];

  late PageController _pageController;
  late Timer _timer;
  int _currentPage = 0;

  // Animation Controller for FadeTransition
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.5);
    _startAutoSlide();

    // Initialize FadeTransition Animation
    _fadeController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 2.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );
    _fadeController.forward();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer.cancel();
    _fadeController.dispose(); // Dispose of the controller
    super.dispose();
  }

  void _startAutoSlide() {
    _timer = Timer.periodic(Duration(seconds: 7), (timer) {
      _currentPage++;
      if (_currentPage >= galleryImages.length) {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 6000),
        curve: Curves.bounceIn,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/education.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CustomHeader(
                      title: 'کور صفحه',
                      selectedIndex: 0,
                    ),
                    SizedBox(height: 20),
                    FadeTransition(
                      opacity: _fadeAnimation,
                      child: const Text(
                        'د کند هار پوهنتون افلیکیشن ته شه راغلاست ',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontFamily: 'pashto'), // Pashto font
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 8.0,
                            spreadRadius: 1.0,
                          ),
                        ],
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text(
                              'لارشود افلیکیشن',
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontFamily: 'pashto'), // Pashto font
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'دلته تاسی د کندهار پوهنتون په اړه معلومات پیدا کولای شی '
                            'د ټولو پوهنځیو مضامین او استادانو په اړه معلومات پیدا کولای شی ',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontFamily: 'pashto', // Pashto font
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: _buildActionButton('پوهنځی ', () {
                            // Action for faculties
                          }),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: _buildActionButton('د پوهنتنون معلومات ', () {
                            // Navigate to HomeScreen
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Homescreen()),
                            );
                          }),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    const Text(
                      'البوم',
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: 'pashto'),
                    ),
                    SizedBox(height: 10),
                    Container(
                      height: 200,
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: galleryImages.length,
                        itemBuilder: (context, index) {
                          return AnimatedBuilder(
                            animation: _pageController,
                            builder: (context, child) {
                              double value = 1.0;
                              if (_pageController.position.haveDimensions) {
                                value = (_pageController.page! - index).abs();
                                value = (1 - (value * 0.5)).clamp(0.0, 1.0);
                              }

                              return AnimatedOpacity(
                                opacity: value,
                                duration: Duration(milliseconds: 800),
                                curve: Curves.easeInOut,
                                child: Transform.scale(
                                  scale: value,
                                  child: Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.black26,
                                          blurRadius: 10.0,
                                          offset: Offset(0, 5),
                                        ),
                                      ],
                                      image: DecorationImage(
                                        image: AssetImage(galleryImages[index]),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                    // New Section: Related Information
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 8.0,
                            spreadRadius: 1.0,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'معلومات اضافي',
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontFamily: 'pashto'), // Pashto font
                          ),
                          SizedBox(height: 10),
                          const Text(
                            'دلته تاسو کولی شئ د پوهنتون په اړه نور معلومات ومومئ.'
                            'د پوهنځیو، استادانو او د شته خدماتو په اړه معلومات.',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontFamily: 'pashto', // Pashto font
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    // New Button to navigate to another screen
                    ElevatedButton(
                      onPressed: () {
                        // Action for the new button
                      },
                      child: const Text(
                        'نور معلومات',
                        style: TextStyle(
                          fontFamily:
                              'pashto', // Set the custom font family 'pashto'
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.blue,
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton(String title, VoidCallback onPressed) {
    return _AnimatedActionButton(title: title, onPressed: onPressed);
  }
}

class _AnimatedActionButton extends StatefulWidget {
  final String title;
  final VoidCallback onPressed;

  const _AnimatedActionButton({
    required this.title,
    required this.onPressed,
  });

  @override
  State<_AnimatedActionButton> createState() => _AnimatedActionButtonState();
}

class _AnimatedActionButtonState extends State<_AnimatedActionButton>
    with SingleTickerProviderStateMixin {
  double _scale = 1.0;
  Color _buttonColor = Colors.white;
  Color _textColor = Colors.black;

  // Animation Controller for button scaling and color transitions
  late AnimationController _buttonAnimationController;
  late Animation<Color?> _buttonColorAnimation;
  late Animation<Color?> _textColorAnimation;

  @override
  void initState() {
    super.initState();
    _buttonAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 150),
    );

    _buttonColorAnimation =
        ColorTween(begin: Colors.white, end: Colors.red).animate(
      CurvedAnimation(
          parent: _buttonAnimationController, curve: Curves.easeInOut),
    );

    _textColorAnimation =
        ColorTween(begin: Colors.black, end: Colors.white).animate(
      CurvedAnimation(
          parent: _buttonAnimationController, curve: Curves.easeInOut),
    );
  }

  void _onTap() async {
    await _buttonAnimationController.forward();
    await Future.delayed(Duration(milliseconds: 150));
    await _buttonAnimationController.reverse();

    widget.onPressed();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _buttonAnimationController,
      builder: (context, child) {
        return AnimatedScale(
          scale: _scale,
          duration: Duration(milliseconds: 150),
          child: ElevatedButton(
            onPressed: _onTap,
            child: Text(
              widget.title,
              style: TextStyle(
                color: _textColorAnimation.value, // Apply dynamic text color
                fontFamily: 'pashto', // Set the custom font family 'pashto'
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  _buttonColorAnimation.value, // Apply dynamic button color
              foregroundColor: Colors.black,
            ),
          ),
        );
      },
    );
  }
}
