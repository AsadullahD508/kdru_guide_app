import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import '../../header.dart';
import '../../language_provider.dart';
import '../../services/firebase_cache_service.dart';
import '../../widgets/cache_status_widget.dart';

class DirectorateScreen extends StatefulWidget {
  const DirectorateScreen({super.key});

  static const Color bgColor = Color(0xFFE1F5FE);

  @override
  State<DirectorateScreen> createState() => _DirectorateScreenState();
}

class _DirectorateScreenState extends State<DirectorateScreen> {
  @override
  void initState() {
    super.initState();
    _enableOfflinePersistence();
  }

  Future<void> _enableOfflinePersistence() async {
    try {
      // Enable offline persistence for Firebase using new method
      FirebaseFirestore.instance.settings = const Settings(
        persistenceEnabled: true,
        cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
      );
      debugPrint('Firebase offline persistence enabled');
    } catch (e) {
      debugPrint('Error enabling offline persistence: $e');
      // Persistence might already be enabled
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: DirectorateScreen.bgColor,
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
          child: StreamBuilder<DocumentSnapshot>(
            stream: FirebaseCacheService.instance.getUniversityDataStream(),
            builder: (context, snapshot) {
              debugPrint('Connection State: ${snapshot.connectionState}');
              debugPrint('Has Data: ${snapshot.hasData}');
              debugPrint('Has Error: ${snapshot.hasError}');

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const LoadingWithCacheWidget();
              }

              if (snapshot.hasError) {
                debugPrint('Error: ${snapshot.error}');
                return ErrorWithRetryWidget(
                  error: snapshot.error.toString(),
                  onRetry: () {
                    (context as Element).markNeedsBuild();
                  },
                  onClearCache: () async {
                    await FirebaseCacheService.instance.clearCache();
                    if (context.mounted) {
                      (context as Element).markNeedsBuild();
                    }
                  },
                );
              }

              if (!snapshot.hasData) {
                debugPrint('No data in snapshot');
                return const Center(
                  child: Text('ډاټا شتون نلري - No Data',
                               style: TextStyle(fontFamily: 'pashto')),
                );
              }

              if (!snapshot.data!.exists) {
                debugPrint('Document does not exist');
                return const Center(
                  child: Text('ډاکیومنټ شتون نلري - Document not found',
                               style: TextStyle(fontFamily: 'pashto')),
                );
              }

              final data = snapshot.data!.data() as Map<String, dynamic>?;

              if (data == null) {
                debugPrint('Document data is null');
                return const Center(
                  child: Text('ډاټا خالي ده - Data is null',
                               style: TextStyle(fontFamily: 'pashto')),
                );
              }

              debugPrint('Document data keys: ${data.keys.toList()}');
              debugPrint('Document data: $data');
              debugPrint('Data source: ${snapshot.data!.metadata.isFromCache ? "Cache" : "Server"}');

              final vision = data['Vision'] ?? 'لرلید شتون نلري';
              final mission = data['Mission'] ?? 'رسالت شتون نلري';
              final goals = data['goals'] ?? 'اهداف شتون نلري';
              final organ = data['organ']?.toString() ?? '';
              final info = data['information'] ?? 'معلومات نشته';
              final name = data['name'] ?? 'کندهار پوهنتون';
              final director = data['director'] ?? 'اسد خان';
              final year = data['year'] ?? '۱۳۹۰';
              final innovativeProjects = data['innovativeProjects'] ?? 'نتشه کومه پروژه';
              final internationalRelations = data['internationalRelations'] ?? 'نتشه کومم داسی خاص اړیک';
              final qualityEnhancement = data['qualityEnhancement'] ?? 'شه ده ډیره بده نه ده';

              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Cache Status Indicator
                    CacheStatusWidget(document: snapshot.data),

                    const SizedBox(height: 20),

                    // University Name and Year
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'pashto',
                        color: Color(0xFF0D3B66),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'د تاسیس کال: $year',
                      style: const TextStyle(
                        fontSize: 16,
                        fontFamily: 'pashto',
                        color: Colors.grey,
                      ),
                      textAlign: TextAlign.center,
                    ),

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

                    // Director Info
                    _buildSectionTitleWithIcon('ریس', 'images/view.png'),
                    const SizedBox(height: 12),
                    _buildInfoCard(director),

                    const SizedBox(height: 24),

                    // General Info
                    _buildSectionTitleWithIcon('عمومي معلومات', 'images/view.png'),
                    const SizedBox(height: 12),
                    _buildInfoCard(info),

                    const SizedBox(height: 24),

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

                    // Innovative Projects Section
                    _buildSectionTitleWithIcon('نوښتګر پروژې', 'images/view.png'),
                    const SizedBox(height: 12),
                    _buildInfoCard(innovativeProjects),

                    const SizedBox(height: 24),

                    // International Relations Section
                    _buildSectionTitleWithIcon('نړیوال اړیکې', 'images/view.png'),
                    const SizedBox(height: 12),
                    _buildInfoCard(internationalRelations),

                    const SizedBox(height: 24),

                    // Quality Enhancement Section
                    _buildSectionTitleWithIcon('د کیفیت ښه والی', 'images/view.png'),
                    const SizedBox(height: 12),
                    _buildInfoCard(qualityEnhancement),

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
                                  child: Row(
                                    children: [
                                      Icon(
                                        entry.key == 'mobile' 
                                            ? Icons.phone 
                                            : Icons.email,
                                        color: const Color(0xFF0D3B66),
                                        size: 20,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        '${entry.key}: ${entry.value}',
                                        style: const TextStyle(
                                          fontFamily: 'pashto',
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ))
                            .toList(),
                      )
                    else
                      const Text('د تماس معلومات شتون نلري'),

                    const SizedBox(height: 24),
                  ],
                ),
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
