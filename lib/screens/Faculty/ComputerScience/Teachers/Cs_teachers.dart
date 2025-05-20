import 'package:flutter/material.dart';
import 'TeacherProfileScreen.dart';

// Your other imports
import '../../../../header.dart';
import '../../../../widgets/buttom_header.dart';

class ComputerScienceTeacherScreen extends StatefulWidget {
  const ComputerScienceTeacherScreen({Key? key}) : super(key: key);

  @override
  State<ComputerScienceTeacherScreen> createState() =>
      _ComputerScienceTeacherScreenState();
}

class _ComputerScienceTeacherScreenState
    extends State<ComputerScienceTeacherScreen> {
  int selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      body: Column(
        children: [
          const CustomHeader(
            userName: 'Guest User',
            bannerImagePath: 'images/computerscience.jpg',
            fullText: 'کمپیوټر ساینس پوهنځي ته ښه راغلاست',
          ),
          Expanded(
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: ListView(
                padding: const EdgeInsets.all(16.0),
                children: [
                  _buildTeacherCard(
                    context,
                    name: 'انجینر عبدالله شفیق',
                    title: 'د ویب پراختیا استاد',
                    graduatedYear: '۲۰۱۵',
                    jobStartYear: '۲۰۱۷',
                    imagePath: 'assets/a.jpg',
                  ),
                  _buildTeacherCard(
                    context,
                    name: 'دوکتور ناصر احمد',
                    title: 'د معلوماتي علومو متخصص',
                    graduatedYear: '۲۰۱۴',
                    jobStartYear: '۲۰۱۶',
                    imagePath: 'assets/a.jpg',
                  ),
                  _buildTeacherCard(
                    context,
                    name: 'پوهنمل ناهید احمدزی',
                    title: 'ماشین زده کړه',
                    graduatedYear: '۲۰۱۶',
                    jobStartYear: '۲۰۱۸',
                    imagePath: 'assets/a.jpg',
                  ),
                  _buildTeacherCard(
                    context,
                    name: 'انجینر احمد شاه سلیم',
                    title: 'د سایبري امنیت استاد',
                    graduatedYear: '۲۰۱۳',
                    jobStartYear: '۲۰۱۴',
                    imagePath: 'assets/a.jpg',
                  ),
                  _buildTeacherCard(
                    context,
                    name: 'م. فرهاد سادات',
                    title: 'د ډیټابیس استاد',
                    graduatedYear: '۲۰۱۷',
                    jobStartYear: '۲۰۱۹',
                    imagePath: 'assets/a.jpg',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTeacherCard(
    BuildContext context, {
    required String name,
    required String title,
    required String graduatedYear,
    required String jobStartYear,
    required String imagePath,
  }) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const TeacherProfileScreen(),
          ),
        );
      },
      child: Card(
        color: Colors.white,
        margin: const EdgeInsets.only(bottom: 16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage(imagePath),
                radius: 30,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[700],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'فراغت: $graduatedYear   |   دندې پیل: $jobStartYear',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
