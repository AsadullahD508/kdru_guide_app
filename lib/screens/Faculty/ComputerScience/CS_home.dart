import 'package:flutter/material.dart';
import '../../../header.dart';
import '../../../widgets/buttom_header.dart';
import './Cs_Department/CS_department.dart';
import 'Teachers/Cs_teachers.dart';

class CsFaculty extends StatefulWidget {
  const CsFaculty({super.key});

  @override
  _CsFacultyState createState() => _CsFacultyState();
}

class _CsFacultyState extends State<CsFaculty> {
  int selectedIndex = 0;
  bool showAllImages = false;
  bool showAllDepartments = false;

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });

    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const CsFaculty()),
      );
    }
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
            child: SingleChildScrollView(
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Image.asset('images/kdr_logo.png',
                              width: 20, height: 20),
                          const SizedBox(width: 12),
                          const Expanded(
                            child: Text(
                              'کمپیوټر ساینس پوهنځی',
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'pashto',
                                color: Color(0xFF0D3B66),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                      Row(
                        children: [
                          Image.asset('images/folder.png',
                              width: 40, height: 40),
                          const SizedBox(width: 12),
                          const Expanded(
                            child: Text(
                              ' دپوهنځی تاریخچه',
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'pashto',
                                color: Color(0xFF0D3B66),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          'د کمپیوټر ساینس پوهنځی په ۱۳۹۳ هجري شمسي کال کې تاسیس شو...'
                          'د کمپیوټر ساینس پوهنځی په ۱۳۹۳ هجري شمسي کال کې تاسیس شو...'
                          'د کمپیوټر ساینس پوهنځی په ۱۳۹۳ هجري شمسي کال کې تاسیس شو...'
                          'د کمپیوټر ساینس پوهنځی په ۱۳۹۳ هجري شمسي کال کې تاسیس شو...'
                          'د کمپیوټر ساینس پوهنځی په ۱۳۹۳ هجري شمسي کال کې تاسیس شو...'
                          'د کمپیوټر ساینس پوهنځی په ۱۳۹۳ هجري شمسي کال کې تاسیس شو...',
                          style: TextStyle(
                            fontFamily: 'pashto',
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      // First row with two cards
                      Row(
                        children: [
                          Expanded(
                            child: _buildStatCard(
                              'دیپارتمینت',
                              '4',
                              'images/department (2).png',
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildStatCard(
                              'استادان',
                              '6',
                              'images/organization-structure.png',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      // Second row with one card
                      Row(
                        children: [
                          Expanded(
                            child: _buildStatCard(
                              'کمپیوټر لیب',
                              '۲',
                              'images/laboratory.png',
                            ),
                          ),
                          Center(
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ComputerScienceTeacherScreen()),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text(
                                'ټول استادان وګورئ',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 40),
                      Container(
                        color: Colors.white, // Set background color to white
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('images/view.png',
                                  width: 60, height: 60),
                              const Text(
                                'موخي',
                                style: TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontFamily: 'pashto',
                                ),
                              ),
                              const SizedBox(height: 12),
                              const Text(
                                'د یو معیاري، نوښتګر او نړیوالې کچې کمپیوټر ساینس پوهنځی جوړول...'
                                'د یو معیاري، نوښتګر او نړیوالې کچې کمپیوټر ساینس پوهنځی جوړول...'
                                'د یو معیاري، نوښتګر او نړیوالې کچې کمپیوټر ساینس پوهنځی جوړول...',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontFamily: 'pashto',
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),
                      _buildVisionSection(),
                      const SizedBox(height: 24),
                      _buildMissionSection(),
                      const SizedBox(height: 40),
                      _buildDepartmentsSection(),
                      const SizedBox(height: 40),
                      _buildGallerySectionWithAnimation(),
                      const SizedBox(height: 24),
                      Center(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            setState(() {
                              showAllImages = !showAllImages;
                            });
                          },
                          icon: const Icon(Icons.add),
                          label: Text(
                            showAllImages
                                ? 'کمه انځورونه ښکاره کړه'
                                : 'نور انځورونه ښکاره کړه',
                            style: const TextStyle(fontFamily: 'pashto'),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF759FC6),
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(
        onItemTapped: _onItemTapped,
        selectedIndex: selectedIndex,
      ),
    );
  }

  Widget _buildStatCard(String title, String value, String iconPath) {
    return Container(
      padding: const EdgeInsets.all(16),
      height: 160,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.7),
            spreadRadius: 4,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontFamily: 'pashto',
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Image.asset(iconPath, width: 32, height: 32),
            ],
          ),
          const SizedBox(height: 12),
          Center(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0D3B66),
                fontFamily: 'pashto',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVisionSection() {
    return Container(
      height: 250,
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/kdr.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        color: Colors.black54,
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('images/view.png', width: 60, height: 60),
              const Text('لرلید',
                  style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'pashto')),
              const SizedBox(height: 12),
              const Text(
                'د یو معیاري، نوښتګر او نړیوالې کچې کمپیوټر ساینس پوهنځی جوړول...',
                style: TextStyle(
                    fontSize: 16, color: Colors.white70, fontFamily: 'pashto'),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMissionSection() {
    return Container(
      color: Colors.black54,
      padding: const EdgeInsets.all(16),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('images/achieve.png', width: 60, height: 60),
            const Text('ریسالت',
                style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'pashto')),
            const SizedBox(height: 12),
            const Text(
              'د کمپیوټر ساینس پوهنځی د تدریس، څیړنې او نوښت له لارې...',
              style: TextStyle(
                  fontSize: 16, color: Colors.white70, fontFamily: 'pashto'),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGallerySectionWithAnimation() {
    List<String> images = List.generate(6, (index) => 'images/kdr.jpg');
    int imageCount = showAllImages ? images.length : 2;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'ګالري',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0D3B66),
            fontFamily: 'pashto',
          ),
        ),
        const SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: imageCount,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (_) => Dialog(
                    backgroundColor: Colors.transparent,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Hero(
                        tag: 'image$index',
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            images[index],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
              child: Hero(
                tag: 'image$index',
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: AssetImage(images[index]),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildDepartmentsSection() {
    List<String> departments = ['عمومی'];
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('څانګي',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0D3B66),
                  fontFamily: 'pashto')),
          const SizedBox(height: 16),
          Column(
            children: departments
                .take(showAllDepartments ? departments.length : 1)
                .map((dept) => GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const ComputerScienceDepartment(
                                    departmentName: 'عمومي',
                                  )),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.blue[100],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                dept,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'pashto',
                                  color: Colors.black,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const Icon(Icons.arrow_forward_ios_rounded,
                                color: Colors.black54),
                          ],
                        ),
                      ),
                    ))
                .toList(),
          ),
          if (departments.length > 1)
            TextButton(
              onPressed: () {
                setState(() {
                  showAllDepartments = !showAllDepartments;
                });
              },
              child: Text(
                showAllDepartments ? 'کمه ښکاره کړه' : 'ټول ښکاره کړه',
                style: const TextStyle(fontFamily: 'pashto'),
              ),
            ),
        ],
      ),
    );
  }
}
