import 'package:flutter/material.dart';
import '../../../../header.dart';

class ComputerScienceTeacherScreen extends StatefulWidget {
  const ComputerScienceTeacherScreen({super.key});

  @override
  _ComputerScienceTeacherScreenState createState() =>
      _ComputerScienceTeacherScreenState();
}

class _ComputerScienceTeacherScreenState
    extends State<ComputerScienceTeacherScreen> {
  int selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
    // You can navigate to different screens based on the index if needed.
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("د استادانو صفحه"),
          backgroundColor: Colors.blue[700],
        ),
        body: const SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                TeacherProfileCard(
                  name: 'موسی هوډمن ',
                  title: 'د امتحاناتو کمیټی مسول، د معلوماتي سیستمونو برخه',
                  email: 'hoodman@gmail.com',
                  phone: '+93 70 987 6543',
                  specialization: 'تخصص: د ډیټابیس مدیریت،  ',
                  research:
                      'ریسرچ: د لویو ډیټابیسو اصلاح، د مصنوعي ځیرکتیا الگورېتمونه',
                  degree: '   درجه: لیسانس د کمپیوټر ساینس ',
                ),
                TeacherProfileCard(
                  name: 'فیض الله همدرد',
                  title: 'معوین، سافټویر انجنیرنګ',
                  email: 'nadir@gmail.com',
                  phone: '93701234567+',
                  specialization: 'تخصص: سافټویر ، کلاوډ کمپیوټینګ',
                  research:
                      'ریسرچ: د کلاوډ امنیت میتودونه، د سافټویر پراختیا معیارونه',
                  degree: 'درجه: د سافټویر انجنیرنګ لیسانس',
                ),
                TeacherProfileCard(
                  name: 'شمس الرحمن رشیدی',
                  title: 'آمر، سایبر امنیت',
                  email: 'hkarimi@gmail.com',
                  phone: '93701234567+',
                  specialization: 'تخصص: د شبکې امنیت، اخلاقي هېکینګ',
                  research:
                      'ریسرچ: د کرپټوګرافي پرمختللي سیستمونه، د سایبري بریدونو دفاع',
                  degree: '  PHD درجه: د سایبر امنیت ',
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: CustomBottomNavBar(
          onItemTapped: _onItemTapped,
          selectedIndex: selectedIndex,
        ),
      ),
    );
  }
}

class TeacherProfileCard extends StatelessWidget {
  final String name;
  final String title;
  final String email;
  final String phone;
  final String specialization;
  final String research;
  final String degree;

  const TeacherProfileCard({
    super.key,
    required this.name,
    required this.title,
    required this.email,
    required this.phone,
    required this.specialization,
    required this.research,
    required this.degree,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.asset(
                  'images/hoodman.jpg',
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.8),
                      ],
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        title,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInfoRow(Icons.email, email),
                const SizedBox(height: 12),
                _buildInfoRow(Icons.phone, phone),
                const SizedBox(height: 12),
                _buildInfoRow(Icons.school, specialization),
                const SizedBox(height: 12),
                _buildInfoRow(Icons.book, research),
                const SizedBox(height: 12),
                _buildInfoRow(Icons.school, degree),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 20,
          color: Colors.blue[700],
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }
}

// Custom Bottom Navigation Bar Widget
class CustomBottomNavBar extends StatelessWidget {
  final Function(int) onItemTapped;
  final int selectedIndex;

  const CustomBottomNavBar(
      {super.key, required this.onItemTapped, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: onItemTapped,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          label: 'Profile',
        ),
      ],
    );
  }
}
