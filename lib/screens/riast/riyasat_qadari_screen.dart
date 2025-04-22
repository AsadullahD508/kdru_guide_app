import 'package:flutter/material.dart';

void main() {
  runApp(RiyasatScreen());
}

class RiyasatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      home: DepartmentOverviewScreen(),
    );
  }
}

class DepartmentOverviewScreen extends StatefulWidget {
  @override
  _DepartmentOverviewScreenState createState() =>
      _DepartmentOverviewScreenState();
}

class _DepartmentOverviewScreenState extends State<DepartmentOverviewScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AchievementsScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(30)),
                child: Image.asset(
                  'images/kdr.jpg',
                  width: double.infinity,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 20,
                left: 20,
                child: Text(
                  'Kandahar University',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                          blurRadius: 10,
                          color: Colors.black45,
                          offset: Offset(0, 2))
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
            child: Text(
              'Riyasat Qadari',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildCard(
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 25,
                        backgroundImage: AssetImage('images/presedent.jpg'),
                      ),
                      title: Text('Mowlawi Abdul Rahman Taibe',
                          style: TextStyle(fontWeight: FontWeight.w600)),
                      subtitle: Text('Director',
                          style: TextStyle(color: Colors.grey[600])),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text('Objectives & Responsibilities',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  _buildObjectiveItem('1. Quality Education'),
                  _buildObjectiveItem('2. Research & Development'),
                  _buildObjectiveItem('3. Community Engagement'),
                  _buildObjectiveItem(
                      '4. Promotion of Innovation and Creativity'),
                  _buildObjectiveItem(
                      '5. Strengthening National and International Collaboration'),
                  _buildObjectiveItem(
                      '6. Development of Professional and Ethical Graduates'),
                  _buildObjectiveItem(
                      '7. Capacity Building for Staff and Faculty Members'),
                  _buildObjectiveItem(
                      '8. Supporting Sustainable Development Goals (SDGs)'),
                  SizedBox(height: 20),
                  Text('Afghan Scholars',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  _buildCard(
                    child: ListTile(
                      title: Text('Dr. Ahmad Zahir',
                          style: TextStyle(fontWeight: FontWeight.w600)),
                      subtitle: Text('Scholar, Philosopher'),
                    ),
                  ),
                  SizedBox(height: 10),
                  _buildCard(
                    child: ListTile(
                      title: Text('Prof. Nadia Sediqi',
                          style: TextStyle(fontWeight: FontWeight.w600)),
                      subtitle: Text('Academic Researcher'),
                    ),
                  ),
                  SizedBox(height: 10),
                  _buildCard(
                    child: ListTile(
                      title: Text('Dr. Shah Mohammad',
                          style: TextStyle(fontWeight: FontWeight.w600)),
                      subtitle: Text('Scientist and Academic'),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text('Requirements',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text(
                    'Applicants must meet the academic and professional criteria set by the department.',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Achievements',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildObjectiveItem(String text) {
    return Row(
      children: [
        Icon(Icons.check_circle, color: Colors.blue, size: 20),
        SizedBox(width: 8),
        Expanded(child: Text(text, style: TextStyle(fontSize: 16))),
      ],
    );
  }

  Widget _buildCard({required Widget child}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: child,
      ),
    );
  }
}

class AchievementsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Student Achievements')),
      body: Center(
        child: Text(
          'List of outstanding students, awards, and certificates.',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
