import 'package:flutter/material.dart';

class CustomHeader extends StatefulWidget {
  final String userName;
  final String bannerImagePath;
  final String fullText;

  const CustomHeader({
    Key? key,
    required this.userName,
    required this.bannerImagePath,
    required this.fullText,
  }) : super(key: key);

  @override
  State<CustomHeader> createState() => _CustomHeaderState();
}

class _CustomHeaderState extends State<CustomHeader>
    with TickerProviderStateMixin {
  late AnimationController _imageController;
  late Animation<Offset> _imageOffsetAnimation;

  String displayedText = "";
  int _currentLetterIndex = 0;

  @override
  void initState() {
    super.initState();

    _imageController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _imageOffsetAnimation =
        Tween<Offset>(begin: const Offset(3.0, 0), end: Offset.zero).animate(
      CurvedAnimation(parent: _imageController, curve: Curves.easeOut),
    );

    _imageController.forward();
    Future.delayed(const Duration(milliseconds: 300), _startTyping);
  }

  void _startTyping() {
    Future.delayed(const Duration(milliseconds: 60), () {
      if (_currentLetterIndex < widget.fullText.length) {
        setState(() {
          displayedText += widget.fullText[_currentLetterIndex];
          _currentLetterIndex++;
        });
        _startTyping();
      }
    });
  }

  @override
  void dispose() {
    _imageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl, // RTL ټول widget ته
      child: Container(
        color: Colors.lightBlue[50],
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.notifications_none),
                    const SizedBox(width: 10),
                    CircleAvatar(radius: 15, backgroundColor: Colors.grey[300]),
                  ],
                ),
                const Text(
                  "کند هار پوهنتون",
                  style: TextStyle(fontSize: 16, fontFamily: 'pashto'),
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_forward),
                  onPressed: () {
                    if (Navigator.of(context).canPop()) {
                      Navigator.of(context).popUntil((route) {
                        if (!Navigator.of(context).canPop()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'تاسې په اصلي صفحه کې یاست.',
                                textDirection: TextDirection.rtl,
                                style: TextStyle(fontFamily: 'pashto'),
                              ),
                              duration: Duration(seconds: 2),
                            ),
                          );
                          return true;
                        }
                        return false;
                      });
                    } else {
                      // که نور pages نه وي
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'تاسې په اصلي صفحه کې یاست.',
                            textDirection: TextDirection.rtl,
                            style: TextStyle(fontFamily: 'pashto'),
                          ),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          displayedText,
                          textDirection: TextDirection.rtl,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                            fontFamily: 'pashto',
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  SlideTransition(
                    position: _imageOffsetAnimation,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        widget.bannerImagePath,
                        width: 60,
                        height: 100,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
