import 'package:flutter/material.dart';

class DirectorateScreen extends StatelessWidget {
  const DirectorateScreen({super.key});

  static const Color bgColor = Color(0xFFE1F5FE); // lightBlue.shade50

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'د کندهار پوهنتون ریاست',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Intro Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Text(
                      'د کندهار پوهنتون ریاست',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      'assets/p.jpg',
                      width: double.infinity,
                      height: 180,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'د کندهار پوهنتون ریاست د پوهنتون د ټولو علمي، اداري، او څېړنیزو چارو مسؤلیت په غاړه لري. دا اداره د پرمختګ، نوښت، او کیفیت د لوړوالي لپاره هڅې کوي ترڅو محصلین، استادان، او ټولنه اغېزمن خدمات تر لاسه کړي',
                    style: TextStyle(fontSize: 15, height: 1.6),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Main Director
            Center(
              child: _buildProfileCard(
                name: 'انجینر محمد نعیم خان',
                position: 'رئیس - کندهار پوهنتون',
                image: 'assets/a.jpg',
                addDescription:
                    'انجینر محمد نعیم خان د کندهار پوهنتون رئیس دی چې د پوهنتون د پراختیا او علمي معیار لوړولو لپاره ژمن دی.',
              ),
            ),

            const SizedBox(height: 24),

            // Assistants
            Row(
              children: const [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4),
                    child: _buildProfileCard(
                      name: 'دوکتور احمدزی',
                      position: 'علمي مرستیال',
                      image: 'assets/a.jpg',
                      radius: 40,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4),
                    child: _buildProfileCard(
                      name: 'دوکتور بشیر احمد',
                      position: 'اداري او مالي مرستیال',
                      image: 'assets/a.jpg',
                      radius: 40,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Goals Title with styled background
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: Colors.blue.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Text(
                  'موخې او اهداف',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            const SizedBox(height: 12),

            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 3 / 2.5,
              ),
              itemCount: goals.length,
              itemBuilder: (context, index) {
                final goal = goals[index];
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.15),
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            goal['image']!,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        goal['title']!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        goal['desc']!,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                );
              },
            ),

            const SizedBox(height: 24),

            const SectionTitle(title: 'د تماس معلومات'),
            const SizedBox(height: 10),
            Card(
              color: Colors.white,
              child: const ListTile(
                leading: Icon(Icons.phone),
                title: Text('۰۷۰۰۱۲۳۴۵۶'),
                subtitle: Text('شمېره'),
              ),
            ),
            const SizedBox(height: 8),
            Card(
              color: Colors.white,
              child: const ListTile(
                leading: Icon(Icons.email),
                title: Text('director@ku.edu.af'),
                subtitle: Text('برېښنالیک آدرس'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _buildProfileCard extends StatelessWidget {
  final String name;
  final String position;
  final String image;
  final double radius;
  final String? addDescription;

  const _buildProfileCard({
    super.key,
    required this.name,
    required this.position,
    required this.image,
    this.radius = 60,
    this.addDescription,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.blue, width: 2),
            ),
            child: CircleAvatar(
              radius: radius,
              backgroundImage: AssetImage(image),
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Text(
                  name,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 15),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 6),
                Text(
                  position,
                  style: const TextStyle(color: Colors.grey, fontSize: 14),
                  textAlign: TextAlign.center,
                ),
                if (addDescription != null) ...[
                  const SizedBox(height: 6),
                  Text(
                    addDescription!,
                    style: const TextStyle(fontSize: 13, color: Colors.black87),
                    textAlign: TextAlign.center,
                  ),
                ],
              ],
            ),
          ),
        ],
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
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }
}

final List<Map<String, String>> goals = [
  {
    'title': 'د کیفیت لوړوالی',
    'desc': 'د تدریس، څېړنې او خدماتو معیاري کول.',
    'image': 'assets/p.jpg',
  },
  {
    'title': 'ابتکاري پروژه',
    'desc': 'د نوښت او پرمختګ هڅونه.',
    'image': 'assets/p.jpg',
  },
  {
    'title': 'نړیوالې اړیکې',
    'desc': 'د نړیوالو پوهنتونونو سره اړیکې جوړول.',
    'image': 'assets/p.jpg',
  },
  {
    'title': 'محصل تمرکز',
    'desc': 'د محصلینو اړتیاوو ته رسېدنه.',
    'image': 'assets/p.jpg',
  },
];
