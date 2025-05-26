import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../header.dart';
import '../../../widgets/buttom_header.dart';
import '../../Departement/Departement.dart';
import 'Cs_Department/CS_department.dart';
import 'Teachers/Cs_teachers.dart';
import 'Teachers/Cs_teachers.dart';

class FacultyScreen extends StatefulWidget {
  final String facultyId;
  final String galleryId;
  final String departmentId;

  const FacultyScreen(
      {Key? key,
      required this.facultyId,
      required this.galleryId,
      required this.departmentId})
      : super(key: key);

  @override
  State<FacultyScreen> createState() => _FacultyScreenState();
}

class _FacultyScreenState extends State<FacultyScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  int selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  Future<Map<String, int>> _getStats() async {
    final departmentsSnapshot = await _firestore
        .collection('Kandahar University')
        .doc('kdru')
        .collection('faculties')
        .doc(widget.facultyId)
        .collection('departments')
        .get();

    final staffSnapshot = await _firestore
        .collection('Kandahar University')
        .doc('kdru')
        .collection('faculties')
        .doc(widget.facultyId)
        .collection('staff')
        .get();

    return {
      'departmentsCount': departmentsSnapshot.size,
      'staffCount': staffSnapshot.size,
      'labCount': staffSnapshot.size,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      bottomNavigationBar: CustomBottomNavBar(
        onItemTapped: _onItemTapped,
        selectedIndex: 1,
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: _firestore
            .collection('Kandahar University')
            .doc('kdru')
            .collection('faculties')
            .doc(widget.facultyId)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
                child: Text('د معلوماتو په لوستلو کې تېروتنه وشوه',
                    style: TextStyle(fontFamily: 'pashto')));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(
                child: Text('پوهنځی ونه موندل شو',
                    style: TextStyle(fontFamily: 'pashto')));
          }

          Map<String, dynamic> facultyData =
              snapshot.data!.data() as Map<String, dynamic>;

          return Directionality(
            textDirection: TextDirection.rtl,
            child: Column(
              children: [
                CustomHeader(
                  userName: 'Guest User',
                  bannerImagePath:
                      facultyData['backgroundUrl'] ?? 'images/kdr_logo.png',
                  fullText: facultyData['name'] ?? 'پوهنځی',
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Image.asset('images/kdr_logo.png',
                                width: 25, height: 25),
                            const SizedBox(width: 12),
                            Text(
                              facultyData['name'] ?? '',
                              style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'pashto',
                                  color: Color(0xFF0D3B66)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 32),
                        _buildSectionTitleWithIcon(
                            'تاریخچه پوهنځی', 'images/hospital.png'),
                        const SizedBox(height: 12),
                        _buildInfoCard(facultyData['description'] ??
                            'د پوهنځی تاریخچه...'),
                        const SizedBox(height: 40),
                        FutureBuilder<Map<String, int>>(
                          future: _getStats(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }

                            int departmentsCount =
                                snapshot.data!['departmentsCount']!;
                            int staffCount = snapshot.data!['staffCount']!;
                            int labcount = snapshot.data!['staffCount']!;

                            return Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                        child: _buildStatCard(
                                            'دیپارتمینت', '$departmentsCount')),
                                    const SizedBox(width: 12),
                                    Expanded(
                                        child: _buildStatCard(
                                            'استادان', '$staffCount')),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                Row(
                                  children: [
                                    Expanded(
                                        child: _buildStatCard('کمپیوټر لیب',
                                            facultyData['ComputerLeb'])),
                                    const SizedBox(width: 12),
                                  ],
                                ),
                              ],
                            );
                          },
                        ),
                        const SizedBox(height: 30),
                        Center(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFFFFFF),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 12),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            onPressed: () {},
                            child: const Text(
                              'ټول استادان',
                              style: TextStyle(
                                fontFamily: 'pashto',
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        _buildSectionTitleWithIcon(
                            ' لر لید', 'images/view.png'),
                        const SizedBox(height: 12),
                        _buildInfoCard(facultyData['vision'] ?? ''),
                        const SizedBox(height: 30),
                        _buildSectionTitleWithIcon('رسالت', 'images/view.png'),
                        const SizedBox(height: 12),
                        _buildInfoCard(facultyData['Mission'] ?? ''),
                        const SizedBox(height: 30),
                        _buildSectionTitleWithIcon('موخه', 'images/view.png'),
                        const SizedBox(height: 12),
                        _buildInfoCard(facultyData['objectiv'] ?? ''),
                        const SizedBox(height: 30),
                        _buildDepartmentsSection(widget.facultyId),
                        const SizedBox(height: 30),
                        _buildGallerySection(widget.facultyId),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionTitleWithIcon(String title, String iconPath) {
    return Row(
      children: [
        Image.asset(iconPath, width: 40, height: 40),
        const SizedBox(width: 12),
        Text(title,
            style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'pashto',
                color: Color(0xFF0D3B66))),
      ],
    );
  }

  Widget _buildInfoCard(String content) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 6,
              offset: const Offset(0, 3))
        ],
      ),
      child: Text(content,
          style: const TextStyle(
              fontSize: 16,
              fontFamily: 'pashto',
              height: 1.5,
              color: Colors.black87),
          textAlign: TextAlign.right),
    );
  }

  static Widget _buildStatCard(String title, String value) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontFamily: 'pashto',
                ),
              ),
              Image.asset(
                'images/seo.png',
                width: 24,
                height: 24,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            value,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0D3B66),
              fontFamily: 'pashto',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDepartmentsSection(String facultyId) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection('Kandahar University')
          .doc('kdru')
          .collection('faculties')
          .doc(facultyId)
          .collection('departments')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError || !snapshot.hasData) return const SizedBox();
        List<DocumentSnapshot> departments = snapshot.data!.docs;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Center(
                child: Text('څانګې',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'pashto',
                        color: Color(0xFF0D3B66)))),
            const SizedBox(height: 12),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: departments.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> dept =
                    departments[index].data() as Map<String, dynamic>;
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  elevation: 3,
                  child: ListTile(
                    title: Text(dept['name'] ?? '',
                        style: const TextStyle(
                            fontFamily: 'pashto',
                            fontWeight: FontWeight.w600,
                            fontSize: 18)),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DepartmentScreen(
                            facultyId: facultyId,
                            departmentId: departments[index].id,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildGallerySection(String facultyId) {
    bool showAllImages = false;

    return StatefulBuilder(
      builder: (context, setState) {
        void _showFullImage(BuildContext context, String imageUrl) {
          showDialog(
            context: context,
            builder: (_) => Dialog(
              backgroundColor: Colors.transparent,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Hero(
                  tag: imageUrl,
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    fit: BoxFit.contain,
                    placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              ),
            ),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Center(
              child: Text(
                'ګالري',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'pashto',
                  color: Color(0xFF0D3B66),
                ),
              ),
            ),
            const SizedBox(height: 12),
            StreamBuilder<DocumentSnapshot>(
              stream: _firestore
                  .collection('Kandahar University')
                  .doc('kdru')
                  .collection('faculties')
                  .doc(facultyId)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Text('د ګالري په لوستلو کې ستونزه',
                      style: TextStyle(fontFamily: 'pashto'));
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || !snapshot.data!.exists) {
                  return const Text('ګالري ونه موندل شوه',
                      style: TextStyle(fontFamily: 'pashto'));
                }

                List<dynamic>? galleryList = snapshot.data!['gellery'];
                if (galleryList == null || galleryList.isEmpty) {
                  return const Text(
                    'هیڅ عکس نشته',
                    style: TextStyle(fontFamily: 'pashto'),
                  );
                }

                List<String> allImages = galleryList.cast<String>();

                int imagesToShow = showAllImages
                    ? allImages.length
                    : (allImages.length >= 3 ? 3 : allImages.length);

                return Column(
                  children: [
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: List.generate(imagesToShow, (index) {
                        String imageUrl = allImages[index];
                        return GestureDetector(
                          onTap: () => _showFullImage(context, imageUrl),
                          child: Hero(
                            tag: imageUrl,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: CachedNetworkImage(
                                imageUrl: imageUrl,
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => const SizedBox(
                                  width: 100,
                                  height: 100,
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                ),
                                errorWidget: (context, url, error) =>
                                    const SizedBox.shrink(),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 10),
                    if (allImages.length > 3)
                      Center(
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              showAllImages = !showAllImages;
                            });
                          },
                          child: Text(
                            showAllImages
                                ? 'لیږ عکسونه شکاره کول'
                                : 'نور عکسونه شکاره کول',
                            style: const TextStyle(
                              fontFamily: 'pashto',
                              fontSize: 16,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
          ],
        );
      },
    );
  }
}
