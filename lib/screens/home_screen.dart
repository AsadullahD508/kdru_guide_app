import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/buttom_header.dart';
import '../header.dart';
import '../language_provider.dart';
import '../utils/responsive_utils.dart';
import 'Faculty/ComputerScience/CS_home.dart';

class Homescreen extends StatefulWidget {
  final int selectedIndex;
  const Homescreen({super.key, this.selectedIndex = 2});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  late int _selectedIndex;
  List<Map<String, String>> faculties = [];
  String aboutTitle = '';
  String aboutDescription = '';
  String universityDean = '';
  String universityYear = '';
  String universityEmail = '';
  String universityMobile = '';
  int departmentsCount = 0;
  int teachersCount = 0;
  String _currentLanguage = '';

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final languageProvider = Provider.of<LanguageProvider>(context);
    if (languageProvider.isInitialized &&
        _currentLanguage != languageProvider.currentLanguage) {
      _currentLanguage = languageProvider.currentLanguage;
      _fetchData(languageProvider);
    }
  }

  void _fetchData(LanguageProvider languageProvider) {
    _fetchFaculties(languageProvider);
    _fetchUniversityInfo(languageProvider);
    _fetchStats(languageProvider);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _navigateToFaculty(String facultyId, String facultyName) {
    // Navigate to the faculty page with the provided faculty ID
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FacultyScreen(
          facultyId: facultyId,
          galleryId: facultyId, // Using facultyId as galleryId for now
          departmentId: '', // Empty string for now, will be handled in the faculty screen
        ),
      ),
    );
  }

  static Widget _buildStatCard(String title, String value,
      LanguageProvider languageProvider, BuildContext context) {
    return Container(
      padding: ResponsiveUtils.getResponsivePadding(
        context,
        mobile: const EdgeInsets.all(24),
        tablet: const EdgeInsets.all(28),
        desktop: const EdgeInsets.all(32),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: ResponsiveUtils.getResponsiveBorderRadius(context),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            spreadRadius: 1,
            blurRadius: ResponsiveUtils.getCardElevation(context),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: ResponsiveUtils.getResponsiveFontSize(
                      context,
                      mobile: 16,
                      tablet: 18,
                      desktop: 20,
                    ),
                    color: Colors.black,
                    fontFamily: languageProvider.getFontFamily(),
                  ),
                  textDirection: languageProvider.getTextDirection(),
                ),
              ),
              Image.asset(
                'images/seo.png',
                width: context.responsiveValue(
                  mobile: 24.0,
                  tablet: 28.0,
                  desktop: 32.0,
                ),
                height: context.responsiveValue(
                  mobile: 24.0,
                  tablet: 28.0,
                  desktop: 32.0,
                ),
              ),
            ],
          ),
          SizedBox(height: ResponsiveUtils.getResponsiveSpacing(context)),
          Text(
            value,
            style: TextStyle(
              fontSize: ResponsiveUtils.getResponsiveFontSize(
                context,
                mobile: 16,
                tablet: 18,
                desktop: 20,
              ),
              fontWeight: FontWeight.bold,
              color: const Color(0xFF0D3B66),
              fontFamily: languageProvider.getFontFamily(),
            ),
            textDirection: languageProvider.getTextDirection(),
          ),
        ],
      ),
    );
  }

  Future<void> _fetchFaculties(LanguageProvider languageProvider) async {
    try {
      final snapshot = await languageProvider.getFacultiesCollectionRef().get();

      final data = snapshot.docs.map((doc) {
        return {
          'id': doc.id,
          'name': doc['name'].toString(),
          'logo': doc['logo'].toString(),
        };
      }).toList();

      if (mounted) {
        setState(() {
          faculties = data;
        });
      }
    } catch (e) {
      debugPrint('Error fetching faculties: $e');
    }
  }

  Future<void> _fetchUniversityInfo(LanguageProvider languageProvider) async {
    try {
      // Get the first university document from the university collection
      final snapshot = await languageProvider.getUniversityCollectionRef().limit(1).get();

      if (snapshot.docs.isNotEmpty && mounted) {
        final doc = snapshot.docs.first;
        final data = doc.data() as Map<String, dynamic>?;
        if (data != null) {
          setState(() {
            aboutTitle = data['name'] ?? '';
            aboutDescription = data['information'] ?? '';
            universityYear = data['year'] ?? '';
            universityDean = data['dean'] ?? '';

            // Extract contact information
            final contactInfo = data['contactInfo'] as Map<String, dynamic>?;
            if (contactInfo != null) {

              universityEmail = contactInfo['email'] ?? '';
              universityMobile = contactInfo['mobile'] ?? '';
            }
          });
        }
      }
    } catch (e) {
      debugPrint('Error fetching university info: $e');
    }
  }

  Future<void> _fetchStats(LanguageProvider languageProvider) async {
    try {
      int deptTotal = 0;
      int teacherTotal = 0;

      final facultiesSnapshot =
          await languageProvider.getFacultiesCollectionRef().get();

      for (var facultyDoc in facultiesSnapshot.docs) {
        final facultyId = facultyDoc.id;

        // Count departments
        final deptSnapshot =
            await languageProvider.getDepartmentsCollectionRef(facultyId).get();
        deptTotal += deptSnapshot.size.toInt();

        // Count teachers from each department
        for (var departmentDoc in deptSnapshot.docs) {
          final departmentId = departmentDoc.id;

          try {
            // Try 'teachers' collection first
            final teacherSnapshot = await languageProvider
                .getDepartmentsCollectionRef(facultyId)
                .doc(departmentId)
                .collection('teachers')
                .get();
            teacherTotal += teacherSnapshot.size.toInt();
            debugPrint('Found ${teacherSnapshot.size} teachers in faculty $facultyId, department $departmentId (teachers collection)');
          } catch (e1) {
            try {
              // Try 'teacher' collection as fallback
              final teacherSnapshot = await languageProvider
                  .getDepartmentsCollectionRef(facultyId)
                  .doc(departmentId)
                  .collection('teacher')
                  .get();
              teacherTotal += teacherSnapshot.size.toInt();
              debugPrint('Found ${teacherSnapshot.size} teachers in faculty $facultyId, department $departmentId (teacher collection)');
            } catch (e2) {
              // Try faculty-level teachers collection as final fallback
              try {
                final facultyTeacherSnapshot = await languageProvider
                    .getFacultiesCollectionRef()
                    .doc(facultyId)
                    .collection('teachers')
                    .get();
                teacherTotal += facultyTeacherSnapshot.size.toInt();
                debugPrint('Found ${facultyTeacherSnapshot.size} teachers in faculty $facultyId (faculty-level teachers collection)');
              } catch (e3) {
                debugPrint('No teachers found in faculty $facultyId, department $departmentId: $e1, $e2, $e3');
              }
            }
          }
        }
      }

      debugPrint('Total departments: $deptTotal, Total teachers: $teacherTotal');

      if (mounted) {
        setState(() {
          departmentsCount = deptTotal;
          teachersCount = teacherTotal;
        });
      }
    } catch (e) {
      debugPrint('Error fetching stats: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, child) {
        if (!languageProvider.isInitialized || languageProvider.isLoading) {
          return Scaffold(
            backgroundColor: const Color(0xFFE5F7FE),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(height: 16),
                  Consumer<LanguageProvider>(
                    builder: (context, languageProvider, child) {
                      return Text(
                        languageProvider.getLocalizedString('loading'),
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: languageProvider.getFontFamily(),
                        ),
                        textDirection: languageProvider.getTextDirection(),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        }

        return Scaffold(
          backgroundColor: const Color(0xFFE5F7FE),
          body: Column(
            children: [
              Consumer<LanguageProvider>(
                builder: (context, languageProvider, child) {
                  return CustomHeader(
                    userName: languageProvider.getLocalizedString('guest_user'),
                    bannerImagePath: 'images/kdr_logo.png',
                    fullText:
                        languageProvider.getLocalizedString('welcome_message'),
                  );
                },
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildUniversityInfo(),
                      _buildStatsRow(),
                      const SizedBox(height: 8),
                      _buildFacultySection(),
                      const SizedBox(height: 24),
                      _buildContactSection(),
                      _buildMapSection(),
                    ],
                  ),
                ),
              ),
            ],
          ),
          bottomNavigationBar: CustomBottomNavBar(
            selectedIndex: _selectedIndex,
            onItemTapped: _onItemTapped,
          ),
        );
      },
    );
  }

  Widget _buildUniversityInfo() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Consumer<LanguageProvider>(
        builder: (context, languageProvider, child) {
          return Column(
            children: [
              // University Name
              Text(
                aboutTitle,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  fontFamily: languageProvider.getFontFamily(),
                ),
                textAlign: TextAlign.center,
                textDirection: languageProvider.getTextDirection(),
              ),
              const SizedBox(height: 8),
              // University Year
              if (universityYear.isNotEmpty)
                Text(
                  universityYear,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade700,
                    fontFamily: languageProvider.getFontFamily(),
                  ),
                  textAlign: TextAlign.center,
                  textDirection: languageProvider.getTextDirection(),
                ),
              const SizedBox(height: 16),
              // Dean Section
              if (universityDean.isNotEmpty)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.blue.shade200),
                  ),
                  child: Column(
                    children: [
                      Text(
                        languageProvider.getLocalizedString('university_dean'),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.blue.shade700,
                          fontFamily: languageProvider.getFontFamily(),
                        ),
                        textAlign: TextAlign.center,
                        textDirection: languageProvider.getTextDirection(),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        universityDean,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.shade800,
                          fontFamily: languageProvider.getFontFamily(),
                        ),
                        textAlign: TextAlign.center,
                        textDirection: languageProvider.getTextDirection(),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 16),
              // University Description
              Text(
                aboutDescription,
                style: TextStyle(
                  fontSize: 16,
                  height: 1.6,
                  fontFamily: languageProvider.getFontFamily(),
                ),
                textAlign: TextAlign.center,
                textDirection: languageProvider.getTextDirection(),
              ),
              const SizedBox(height: 24),
            ],
          );
        },
      ),
    );
  }

  Widget _buildStatsRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Consumer<LanguageProvider>(
        builder: (context, languageProvider, child) {
          return SizedBox(
            height: 150,
            child: Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    languageProvider.getLocalizedString('departments'),
                    '$departmentsCount',
                    languageProvider,
                    context,
                  ),
                ),
                SizedBox(width: ResponsiveUtils.getResponsiveSpacing(context)),
                Expanded(
                  child: _buildStatCard(
                    languageProvider.getLocalizedString('teachers'),
                    '$teachersCount',
                    languageProvider,
                    context,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildFacultySection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Consumer<LanguageProvider>(
        builder: (context, languageProvider, child) {
          return Column(
            children: [
              Text(
                languageProvider.getLocalizedString('faculties'),
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: languageProvider.getFontFamily(),
                ),
                textDirection: languageProvider.getTextDirection(),
              ),
              const SizedBox(height: 16),
              faculties.isEmpty
                  ? const Padding(
                      padding: EdgeInsets.all(24.0),
                      child: Center(child: CircularProgressIndicator()),
                    )
                  : GridView.builder(
                      shrinkWrap: true,
                      padding: ResponsiveUtils.getResponsivePadding(
                        context,
                        mobile: const EdgeInsets.only(bottom: 8),
                        tablet: const EdgeInsets.only(bottom: 12),
                        desktop: const EdgeInsets.only(bottom: 16),
                      ),
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: faculties.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: ResponsiveUtils.getGridCrossAxisCount(
                          context,
                          mobile: 2,
                          tablet: 3,
                          desktop: 4,
                        ),
                        mainAxisSpacing:
                            ResponsiveUtils.getResponsiveSpacing(context),
                        crossAxisSpacing:
                            ResponsiveUtils.getResponsiveSpacing(context),
                        childAspectRatio: context.responsiveValue(
                          mobile: 1.2,
                          tablet: 1.1,
                          desktop: 1.0,
                        ),
                      ),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            _navigateToFaculty(faculties[index]['id']!, faculties[index]['name']!);
                          },
                          child: _buildFacultyCard(
                            title: faculties[index]['name']!,
                            imagePath: faculties[index]['logo']!,
                            languageProvider: languageProvider,
                          ),
                        );
                      },
                    ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildFacultyCard({
    required String title,
    required String imagePath,
    required LanguageProvider languageProvider,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      padding: const EdgeInsets.all(11.0),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: imagePath.isNotEmpty
                ? Hero(
                    tag: 'service_card_${imagePath.hashCode}_${title.hashCode}',
                    child: CachedNetworkImage(
                      imageUrl: imagePath,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                      memCacheWidth: 100,
                      memCacheHeight: 100,
                      placeholder: (context, url) => Container(
                        width: 50,
                        height: 50,
                        color: Colors.grey.shade200,
                        child: const Icon(Icons.image, color: Colors.grey),
                      ),
                      errorWidget: (context, url, error) => Container(
                        width: 50,
                        height: 50,
                        color: Colors.grey.shade300,
                        child:
                            const Icon(Icons.broken_image, color: Colors.grey),
                      ),
                    ),
                  )
                : const Icon(
                    Icons.image_not_supported,
                    size: 50,
                    color: Colors.grey,
                  ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                fontFamily: languageProvider.getFontFamily(),
              ),
              textDirection: languageProvider.getTextDirection(),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    required LanguageProvider languageProvider,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.lightBlue[50],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                size: 32,
                color: Colors.lightBlue,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: languageProvider.getFontFamily(),
              ),
              textDirection: languageProvider.getTextDirection(),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
                fontFamily: languageProvider.getFontFamily(),
              ),
              textDirection: languageProvider.getTextDirection(),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Consumer<LanguageProvider>(
        builder: (context, languageProvider, child) {
          return Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withValues(alpha: 0.1),
                  spreadRadius: 1,
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.contact_phone,
                      color: Colors.blue.shade700,
                      size: 24,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      languageProvider.getLocalizedString('contact_us'),
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade700,
                        fontFamily: languageProvider.getFontFamily(),
                      ),
                      textDirection: languageProvider.getTextDirection(),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildContactItem(
                  icon: Icons.location_on,
                  title: languageProvider.getLocalizedString('address'),
                  content: 'Kandahar City, Afghanistan',
                  languageProvider: languageProvider,
                ),
                const SizedBox(height: 12),
                _buildContactItem(
                  icon: Icons.phone,
                  title: languageProvider.getLocalizedString('phone'),
                  content: universityMobile.isNotEmpty ? universityMobile : '+93 30 222 4444',
                  languageProvider: languageProvider,
                  isClickable: true,
                  onTap: () => _launchPhone(universityMobile.isNotEmpty ? universityMobile : '+93 30 222 4444'),
                ),
                const SizedBox(height: 12),
                _buildContactItem(
                  icon: Icons.email,
                  title: languageProvider.getLocalizedString('email'),
                  content: universityEmail.isNotEmpty ? universityEmail : 'info@kdru.edu.af',
                  languageProvider: languageProvider,
                  isClickable: true,
                  onTap: () => _launchEmail(universityEmail.isNotEmpty ? universityEmail : 'info@kdru.edu.af'),
                ),
                const SizedBox(height: 12),
                _buildContactItem(
                  icon: Icons.web,
                  title: languageProvider.getLocalizedString('website'),
                  content: 'www.kdru.edu.af',
                  languageProvider: languageProvider,
                  isClickable: true,
                  onTap: () => _launchWebsite('www.kdru.edu.af'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildContactItem({
    required IconData icon,
    required String title,
    required String content,
    required LanguageProvider languageProvider,
    bool isClickable = false,
    VoidCallback? onTap,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: Colors.grey.shade600,
          size: 20,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade700,
                  fontFamily: languageProvider.getFontFamily(),
                ),
                textDirection: languageProvider.getTextDirection(),
              ),
              const SizedBox(height: 4),
              isClickable && onTap != null
                  ? GestureDetector(
                      onTap: onTap,
                      child: Text(
                        content,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.blue.shade600,
                          fontFamily: languageProvider.getFontFamily(),
                          decoration: TextDecoration.underline,
                        ),
                        textDirection: languageProvider.getTextDirection(),
                      ),
                    )
                  : Text(
                      content,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade800,
                        fontFamily: languageProvider.getFontFamily(),
                      ),
                      textDirection: languageProvider.getTextDirection(),
                    ),
            ],
          ),
        ),
      ],
    );
  }

  // Helper method to launch phone dialer
  Future<void> _launchPhone(String phoneNumber) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
    try {
      if (await canLaunchUrl(phoneUri)) {
        await launchUrl(phoneUri);
      } else {
        debugPrint('Could not launch phone dialer for $phoneNumber');
      }
    } catch (e) {
      debugPrint('Error launching phone dialer: $e');
    }
  }

  // Helper method to launch email client
  Future<void> _launchEmail(String email) async {
    final Uri emailUri = Uri(scheme: 'mailto', path: email);
    try {
      if (await canLaunchUrl(emailUri)) {
        await launchUrl(emailUri);
      } else {
        debugPrint('Could not launch email client for $email');
      }
    } catch (e) {
      debugPrint('Error launching email client: $e');
    }
  }

  // Helper method to launch website
  Future<void> _launchWebsite(String website) async {
    // Add https:// if not present
    String url = website;
    if (!url.startsWith('http://') && !url.startsWith('https://')) {
      url = 'https://$url';
    }

    final Uri websiteUri = Uri.parse(url);
    try {
      if (await canLaunchUrl(websiteUri)) {
        await launchUrl(websiteUri, mode: LaunchMode.externalApplication);
      } else {
        debugPrint('Could not launch website $url');
      }
    } catch (e) {
      debugPrint('Error launching website: $e');
    }
  }

  Widget _buildMapSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        height: 200,
        child: FlutterMap(
          options: const MapOptions(
            initialCenter: LatLng(31.6289, 65.7372),
            initialZoom: 13.0,
          ),
          children: [
            TileLayer(
              urlTemplate:
                  'https://services.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}',
              subdomains: const ['a', 'b', 'c'],
              userAgentPackageName: 'com.example.app',
            ),
            const MarkerLayer(
              markers: [
                Marker(
                  width: 80.0,
                  height: 80.0,
                  point: LatLng(31.6357988, 65.6959516),
                  child: Icon(
                    Icons.location_pin,
                    color: Colors.red,
                    size: 40,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
