import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../header.dart';

class DirectorateScreen extends StatelessWidget {
  const DirectorateScreen({super.key});

  static const Color bgColor = Color(0xFFE1F5FE);

  @override
  Widget build(BuildContext context) {
    return const Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: bgColor,
        body: DirectorateContent(),
      ),
    );
  }
}

class DirectorateContent extends StatelessWidget {
  const DirectorateContent({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, String> decorateData = {
      'backgroundUrl': 'images/kdr_logo.png',
      'name': 'اداري ریاستونه',
    };

    return Column(
      children: [
        CustomHeader(
          userName: 'Guest User',
          bannerImagePath: decorateData['backgroundUrl']!,
          fullText: decorateData['name']!,
        ),
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('Kandahar University')
                .doc('kdru')
                .collection('administrativeUnits')
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }
              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return const Center(child: Text('ډاټا شتون نلري'));
              }

              final documents = snapshot.data!.docs;

              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: documents.length,
                itemBuilder: (context, index) {
                  final data = documents[index].data() as Map<String, dynamic>;

                  final vision = data['vision'] ?? 'لرلي';
                  final mission = data['mission'] ?? 'رسالت شتون نلري';
                  final goals = data['goals'] ?? 'اهداف شتون نلري';
                  final organ = data['organ']?.toString() ?? '';
                  final info = data['information'] ?? 'معلومات نشته';

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),

                      // Organ Image
                      if (organ.isNotEmpty)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            organ,
                            width: 150,
                            height: 150,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(Icons.broken_image, size: 100);
                            },
                          ),
                        ),

                      const SizedBox(height: 20),

                      // General Info
                      Text(
                        info,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'pashto',
                        ),
                        textAlign: TextAlign.center,
                      ),

                      const SizedBox(height: 30),

                      // Vision Section
                      _buildSectionTitleWithIcon('لرلید', 'images/view.png'),
                      const SizedBox(height: 12),
                      _buildInfoCard(vision),

                      const SizedBox(height: 24),

                      // Mission Section
                      _buildSectionTitleWithIcon('رسالت', 'images/view.png'),
                      const SizedBox(height: 12),
                      _buildInfoCard(mission),

                      const SizedBox(height: 24),

                      // Goals Section
                      _buildSectionTitleWithIcon('اهداف', 'images/view.png'),
                      const SizedBox(height: 12),
                      _buildInfoCard(goals),

                      const SizedBox(height: 24),

                      // Banner Section
                      const Text(
                        'دا د بینر برخه ده',
                        style: TextStyle(fontFamily: 'pashto', fontSize: 16),
                      ),
                      const SizedBox(height: 24),
                      Image.asset('images/seo.png'),

                      const SizedBox(height: 24),

                      // Contact Info Section
                      const SectionTitle(title: 'د تماس معلومات'),
                      const SizedBox(height: 12),

                      if (data['contactInfo'] != null &&
                          data['contactInfo'] is Map<String, dynamic>)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: (data['contactInfo']
                          as Map<String, dynamic>)
                              .entries
                              .map((entry) => Padding(
                            padding:
                            const EdgeInsets.symmetric(vertical: 4),
                            child: Text(
                              '${entry.key}: ${entry.value}',
                              style: const TextStyle(
                                fontFamily: 'pashto',
                                fontSize: 14,
                              ),
                            ),
                          ))
                              .toList(),
                        )
                      else
                        const Text('د تماس معلومات شتون نلري'),

                      const SizedBox(height: 24),
                      const Divider(thickness: 1),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitleWithIcon(String title, String iconPath) {
    return Row(
      children: [
        Image.asset(iconPath, width: 30, height: 30),
        const SizedBox(width: 12),
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'pashto',
            color: Color(0xFF0D3B66),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoCard(String text) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 16, fontFamily: 'pashto'),
        textDirection: TextDirection.rtl,
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        fontFamily: 'pashto',
      ),
      textDirection: TextDirection.rtl,
    );
  }
}
