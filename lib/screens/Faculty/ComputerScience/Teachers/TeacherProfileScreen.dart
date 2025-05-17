import 'package:flutter/material.dart';

// Import your custom header here (adjust the path as needed)
import '../../../../header.dart';

class TeacherProfileScreen extends StatelessWidget {
  const TeacherProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      body: SafeArea(
        child: Column(
          children: [
            // Use the custom header widget here
            const CustomHeader(
              userName: 'Guest User',
              bannerImagePath: 'images/computerscience.jpg',
              fullText: 'کمپیوټر ساینس پوهنځي ته ښه راغلاست',
            ),
            // Expanded to allow scrolling content below header
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40),

                    // Profile Card
                    Container(
                      padding: const EdgeInsets.all(30),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(70),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.lightBlue.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              border:
                                  Border.all(color: Colors.lightBlue, width: 3),
                            ),
                            padding: const EdgeInsets.all(6),
                            child: const CircleAvatar(
                              radius: 50,
                              backgroundImage: AssetImage('assets/a.jpg'),
                            ),
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'Qudratullah (Afghan)',
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'PhD in Computer Science',
                            style: TextStyle(
                                fontSize: 16, color: Colors.grey[700]),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.school, color: Colors.blue, size: 20),
                              SizedBox(width: 6),
                              Text(
                                'Faculty: Computer Science',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.apartment,
                                  color: Colors.lightBlue, size: 20),
                              SizedBox(width: 6),
                              Text(
                                'Department: Software Engineering',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.workspace_premium,
                                  color: Colors.orange, size: 20),
                              SizedBox(width: 6),
                              Text(
                                'Degree: Doctorate (PhD)',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 30),

                    // Research Section
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Researches',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 12),
                          _buildResearchItem(
                            title: 'AI in Education',
                            description:
                                'Exploring the use of AI to personalize learning experiences and improve student outcomes.',
                            status: 'Published',
                            statusColor: Colors.green,
                            location: 'Kandahar University',
                            startYear: '2022',
                            endYear: '2023',
                          ),
                          const SizedBox(height: 16),
                          _buildResearchItem(
                            title: 'Blockchain Technology',
                            description:
                                'An analysis of blockchain use in secure academic record keeping and digital identity.',
                            status: 'Rejected',
                            statusColor: Colors.red,
                            location: 'Zabul Institute',
                            startYear: '2021',
                            endYear: '2022',
                          ),
                          const SizedBox(height: 16),
                          _buildResearchItem(
                            title: 'Cybersecurity in Cloud Computing',
                            description:
                                'Addressing modern security challenges in distributed cloud platforms.',
                            status: 'Published',
                            statusColor: Colors.green,
                            location: 'Kabul Tech',
                            startYear: '2023',
                            endYear: '2024',
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Contact Section
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 4, vertical: 7),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.4),
                            spreadRadius: 2,
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '📞 Contact',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[900],
                            ),
                          ),
                          const SizedBox(height: 16),
                          _contactItem(Icons.email, Colors.blue,
                              'qudrathan048@gmail.com', Colors.blue[50]!),
                          _contactItem(Icons.phone, Colors.green, '+0704419972',
                              Colors.green[50]!),
                          _contactItem(
                              Icons.facebook,
                              Colors.blueAccent,
                              'facebook.com/qudratullah',
                              Colors.lightBlue[50]!),
                          _contactItem(Icons.ondemand_video, Colors.red,
                              'youtube.com/@qudratullah', Colors.red[50]!),
                          _contactItem(Icons.music_note, Colors.purple,
                              'tiktok.com/@qudratullah', Colors.purple[50]!),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResearchItem({
    required String title,
    required String description,
    required String status,
    required Color statusColor,
    required String location,
    required String startYear,
    required String endYear,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(description, style: const TextStyle(fontSize: 14)),
        const SizedBox(height: 4),
        Text('📍 Location: $location',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        const SizedBox(height: 4),
        Text('🗓️ Years: $startYear - $endYear',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          decoration: BoxDecoration(
            color: statusColor,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            status,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget _contactItem(
      IconData icon, Color iconColor, String text, Color bgColor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 28),
          const SizedBox(width: 10),
          Text(
            text,
            style: const TextStyle(fontSize: 16, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
