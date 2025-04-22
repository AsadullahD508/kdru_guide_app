import 'package:flutter/material.dart';

class ComputerScienceTeacherScreen extends StatelessWidget {
  const ComputerScienceTeacherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('د پوهنځي پروفایل'),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
        ),
        body: const SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                TeacherProfileCard(
                  name: 'پروفسوره نجیبه احمدي',
                  title: 'مشره استاده، د معلوماتي سیستمونو برخه',
                  email: 'n.ahmadi@ku.edu.af',
                  phone: '+93 70 987 6543',
                  officeHours: 'د دفتر ساعتونه: سه شنبه، پنجشنبه ۱۳:۰۰-۱۵:۰۰',
                  specialization: 'تخصص: د ډیټابیس مدیریت، سوداګری استخبارات',
                  research: 'د څېړنې تمرکز: لوی ډیټا تحلیل، مصنوعي ځیرکتیا',
                  degree: 'ډګري: د کمپیوټر ساینس پی ایچ ډي',
                  imageUrl:
                      'https://images.pexels.com/photos/3796217/pexels-photo-3796217.jpeg',
                ),
                TeacherProfileCard(
                  name: 'ډاکټر محمد ظاهر',
                  title: 'مرستیال استاد، سافټویر انجنیرنګ',
                  email: 'm.zahir@ku.edu.af',
                  phone: '+93 70 654 3210',
                  officeHours: 'د دفتر ساعتونه: دوشنبه، چهارشنبه ۱۰:۰۰-۱۲:۰۰',
                  specialization: 'تخصص: سافټویر پراختیا، کلاوډ کمپیوټینګ',
                  research: 'د څېړنې تمرکز: د کلاوډ امنیت، د سافټویر ازموینه',
                  degree: 'ډګري: د سافټویر انجنیرنګ پی ایچ ډي',
                  imageUrl:
                      'https://images.pexels.com/photos/1085593/pexels-photo-1085593.jpeg',
                ),
                TeacherProfileCard(
                  name: 'ډاکټر حبیب الله کریمي',
                  title: 'مشر استاد، سایبر امنیت',
                  email: 'h.karimi@ku.edu.af',
                  phone: '+93 70 832 7645',
                  officeHours: 'د دفتر ساعتونه: سه شنبه، جمعه ۱۴:۰۰-۱۶:۰۰',
                  specialization: 'تخصص: د شبکې امنیت، اخلاقي هېکینګ',
                  research: 'د څېړنې تمرکز: کرپټوګرافي، سایبر دفاع',
                  degree: 'ډګري: د سایبر امنیت پی ایچ ډي',
                  imageUrl:
                      'https://images.pexels.com/photos/374064/pexels-photo-374064.jpeg',
                ),
                TeacherProfileCard(
                  name: 'ډاکټره فوزیه ځدراڼ',
                  title: 'پروفیسوره، کمپیوټر ساینس',
                  email: 'f.zadran@ku.edu.af',
                  phone: '+93 70 246 1357',
                  officeHours: 'د دفتر ساعتونه: چهارشنبه، جمعه ۱۱:۰۰-۱۳:۰۰',
                  specialization: 'تخصص: مصنوعي ځیرکتیا، ماشین زده کړه',
                  research: 'د څېړنې تمرکز: ژور زده کړه، طبیعي ژبې پروسس',
                  degree: 'ډګري: د مصنوعي ځیرکتیا پی ایچ ډي',
                  imageUrl:
                      'https://images.pexels.com/photos/167168/pexels-photo-167168.jpeg',
                ),
                TeacherProfileCard(
                  name: 'ډاکټره سحر ګل',
                  title: 'مرستیاله استاده، سافټویر انجنیرنګ',
                  email: 's.gul@ku.edu.af',
                  phone: '+93 70 332 4559',
                  officeHours: 'د دفتر ساعتونه: دوشنبه، پنجشنبه ۹:۰۰-۱۱:۰۰',
                  specialization: 'تخصص: د سافټویر معماري، موبایل اپلیکیشنونه',
                  research: 'د څېړنې تمرکز: د موبایل امنیت، د سافټویر ازموینه',
                  degree: 'ډګري: د سافټویر انجنیرنګ پی ایچ ډي',
                  imageUrl:
                      'https://images.pexels.com/photos/5185432/pexels-photo-5185432.jpeg',
                ),
                TeacherProfileCard(
                  name: 'ډاکټر عزیز احمدزی',
                  title: 'مشر استاد، د ډیټا ساینس',
                  email: 'a.ahmadzai@ku.edu.af',
                  phone: '+93 70 986 7431',
                  officeHours: 'د دفتر ساعتونه: سه شنبه، چهارشنبه ۱۴:۰۰-۱۶:۰۰',
                  specialization: 'تخصص: د ډیټا تحلیل، احصایوي ماډلینګ',
                  research: 'د څېړنې تمرکز: ډیټا ماینینګ، وړاندوینې تحلیل',
                  degree: 'ډګري: د ډیټا ساینس پی ایچ ډي',
                  imageUrl:
                      'https://images.pexels.com/photos/3184337/pexels-photo-3184337.jpeg',
                ),
                TeacherProfileCard(
                  name: 'ډاکټر خواجه احمد',
                  title: 'پروفیسر، د کمپیوټر شبکې',
                  email: 'k.ahmad@ku.edu.af',
                  phone: '+93 70 593 6812',
                  officeHours: 'د دفتر ساعتونه: دوشنبه، پنجشنبه ۱۳:۰۰-۱۵:۰۰',
                  specialization:
                      'تخصص: د شبکې پروتوکولونه، انټرنیټ شیان (IoT)',
                  research: 'د څېړنې تمرکز: پنځم نسل شبکې (5G)، د IoT امنیت',
                  degree: 'ډګري: د کمپیوټر شبکو پی ایچ ډي',
                  imageUrl:
                      'https://images.pexels.com/photos/714725/pexels-photo-714725.jpeg',
                ),
                TeacherProfileCard(
                  name: 'ډاکټر نورالله جان',
                  title: 'مشر استاد، د ډیټابیس سیستمونه',
                  email: 'n.jan@ku.edu.af',
                  phone: '+93 70 134 5678',
                  officeHours: 'د دفتر ساعتونه: چهارشنبه، جمعه ۱۰:۰۰-۱۲:۰۰',
                  specialization: 'تخصص: وېشل شوي ډیټابیسونه، کلاوډ ډیټابیسونه',
                  research: 'د څېړنې تمرکز: کلاوډ کمپیوټینګ، NoSQL ډیټابیسونه',
                  degree: 'ډګري: د ډیټابیس سیستمونو پی ایچ ډي',
                  imageUrl:
                      'https://images.pexels.com/photos/513812/pexels-photo-513812.jpeg',
                ),
                TeacherProfileCard(
                  name: 'ډاکټره پروین شاه',
                  title: 'لکچرره، معلوماتي ټکنالوجي',
                  email: 'p.shah@ku.edu.af',
                  phone: '+93 70 654 1230',
                  officeHours: 'د دفتر ساعتونه: دوشنبه، پنجشنبه ۹:۰۰-۱۱:۰۰',
                  specialization: 'تخصص: د آی ټي مدیریت، ویب پراختیا',
                  research: 'د څېړنې تمرکز: ای کامرس، د آی ټي حل لارې',
                  degree: 'ډګري: د معلوماتي ټکنالوجۍ پی ایچ ډي',
                  imageUrl:
                      'https://images.pexels.com/photos/213026/pexels-photo-213026.jpeg',
                ),
                TeacherProfileCard(
                  name: 'ډاکټره نبیله کریمي',
                  title: 'مرستیاله استاده، کمپیوټر ساینس',
                  email: 'n.karimi@ku.edu.af',
                  phone: '+93 70 231 4678',
                  officeHours: 'د دفتر ساعتونه: سه شنبه، جمعه ۱۳:۰۰-۱۵:۰۰',
                  specialization: 'تخصص: کلاوډ کمپیوټینګ، بلاکچین',
                  research: 'د څېړنې تمرکز: د بلاکچین ټیکنالوژي، د کلاوډ امنیت',
                  degree: 'ډګري: د کمپیوټر ساینس پی ایچ ډي',
                  imageUrl:
                      'https://images.pexels.com/photos/4386341/pexels-photo-4386341.jpeg',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// د ښوونکو پروفایل کارت
class TeacherProfileCard extends StatelessWidget {
  final String name;
  final String title;
  final String email;
  final String phone;
  final String officeHours;
  final String specialization;
  final String research;
  final String degree;
  final String imageUrl;

  const TeacherProfileCard({
    super.key,
    required this.name,
    required this.title,
    required this.email,
    required this.phone,
    required this.officeHours,
    required this.specialization,
    required this.research,
    required this.degree,
    required this.imageUrl,
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
                child: Image.network(
                  imageUrl,
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
                _buildInfoRow(Icons.access_time, officeHours),
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
