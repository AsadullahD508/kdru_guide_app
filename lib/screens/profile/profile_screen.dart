import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../header.dart';
import '../../language_provider.dart';
import '../../widgets/buttom_header.dart';


class TeamMember {
  final int id;
  final String name;
  final String title;
  final String bio;
  final String phone;
  final String email;
  final String imageUrl;

  TeamMember({
    required this.id,
    required this.name,
    required this.title,
    required this.bio,
    required this.phone,
    required this.email,
    required this.imageUrl,
  });
}

class TeamProfilePage extends StatefulWidget {
  const TeamProfilePage({super.key});

  @override
  State<TeamProfilePage> createState() => _TeamProfilePageState();
}

class _TeamProfilePageState extends State<TeamProfilePage> {
  int _selectedIndex = 2;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static final List<TeamMember> teamMembers = [
    TeamMember(
      id: 1,
      name: "Engineer Fared Ahmad",
      title: "Project Manager",
      bio:
          "Experienced engineer leading technical development and system architecture.",
      phone: "+93 794165052",
      email: "faredbarak222@gmail.com",
      imageUrl: "images/fared.jpg",
    ),
    TeamMember(
      id: 2,
      name: " Engineer  Qudratullah Afghan",
      title: "Software Developer",
      bio:
          "Skilled software developer with expertise in building robust applications.",
      phone: "+93 707787597",
      email: "qudratullahafghan048@gmail.com",
      imageUrl: "images/qudrat.jpg",
    ),
    TeamMember(
      id: 3,
      name: "Engineer Asadullah Darwish",
      title: "Full Stack Developer",
      bio:
          "Skilled in both frontend and backend development. Builds complete, scalable, and user-friendly web and mobile apps using modern technologies like Flutter, Firebase, and REST APIs",
      phone: "+93 796223247",
      email: "asadullahdarwish29@gmail.com",
      imageUrl: "images/asad.jpg",
    ),

    TeamMember(
      id: 4,
      name: "Shabir Ahmad",
      title: "Backend Developer",
      bio:
          "Dedicated backend developer ensuring robust and scalable server-side logic.",
      phone: "+93 770883246",
      email: "shabirahmadsadaat04@gmail.com",
      imageUrl: "images/darwish.jpg",
    ),
    TeamMember(
      id: 5,
      name: "Hamidullah",
      title: "UI/UX Designer and Scientific Writer ",
      bio:
      "Creative designer focused on creating intuitive and engaging user experiences.",
      phone: "+93 708294078",
      email: "hamidullahrohani0101@gmail.com",
      imageUrl: "images/hamid.jpg",
    ),
  ];

  String getInitials(String name) {
    List<String> parts = name.split(' ');
    if (parts.length > 1) {
      return parts[0][0] + parts.last[0];
    } else {
      return parts[0][0];
    }
  }

  void showContactDialog(BuildContext context, TeamMember member) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Consumer<LanguageProvider>(
          builder: (context, languageProvider, child) {
            return Text(
              '${languageProvider.getLocalizedString('contact')} ${member.name}',
              style: TextStyle(
                fontFamily: languageProvider.getFontFamily(),
              ),
              textDirection: languageProvider.getTextDirection(),
            );
          },
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('📞 Phone: ${member.phone}'),
            const SizedBox(height: 8),
            Text('✉️ Email: ${member.email}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Consumer<LanguageProvider>(
              builder: (context, languageProvider, child) {
                return Text(
                  languageProvider.getLocalizedString('close'),
                  style: TextStyle(
                    fontFamily: languageProvider.getFontFamily(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
      body: Column(
        children: [
          Consumer<LanguageProvider>(
            builder: (context, languageProvider, child) {
              return CustomHeader(
                userName: languageProvider.getLocalizedString('guest_user'),
                bannerImagePath: 'images/kdr_logo.png',
                fullText: languageProvider.getLocalizedString('university_name'),
              );
            },
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 40,
                            child: Text(
                              'F',
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'Group F',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'A talented team of professionals working together to bring innovative solutions to life.',
                            style: TextStyle(color: Colors.white70),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: teamMembers.length,
                      itemBuilder: (context, index) {
                        final member = teamMembers[index];
                        return Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 4,
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CircleAvatar(
                                    radius: 100,
                                    backgroundImage:
                                        AssetImage(member.imageUrl),
                                    child: member.imageUrl.isEmpty
                                        ? Text(
                                            getInitials(member.name),
                                            style: TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.blue.shade700,
                                            ),
                                          )
                                        : null,
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    member.name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    member.title,
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    member.bio,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.black54,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 16),
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      onPressed: () =>
                                          showContactDialog(context, member),
                                      style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12),
                                      ),
                                      child: Consumer<LanguageProvider>(
                                        builder: (context, languageProvider, child) {
                                          return Text(
                                            languageProvider.getLocalizedString('contact'),
                                            style: TextStyle(
                                              fontFamily: languageProvider.getFontFamily(),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
