import 'package:flutter/material.dart';
import '../../widgets/custom_header.dart';

class TeamMember {
  final int id;
  final String name;
  final String title;
  final String bio;
  final String phone;
  final String email;

  TeamMember({
    required this.id,
    required this.name,
    required this.title,
    required this.bio,
    required this.phone,
    required this.email,
  });
}

class TeamProfilePage extends StatelessWidget {
  TeamProfilePage({Key? key}) : super(key: key);

  final List<TeamMember> teamMembers = [
    TeamMember(
      id: 1,
      name: "Engineer Fared Ahmad",
      title: "Lead Engineer",
      bio:
          "Experienced engineer leading technical development and system architecture.",
      phone: "+93 700 111 111",
      email: "fared@example.com",
    ),
    TeamMember(
      id: 2,
      name: "Qudratullah",
      title: "Software Developer",
      bio:
          "Skilled software developer with expertise in building robust applications.",
      phone: "+93 700 222 222",
      email: "qudratullah@example.com",
    ),
    TeamMember(
      id: 3,
      name: "Engineer Asadullah Darwish",
      title: "Systems Engineer",
      bio:
          "Specialized in designing and implementing complex system solutions.",
      phone: "+93 700 333 333",
      email: "asadullah@example.com",
    ),
    TeamMember(
      id: 4,
      name: "Hamidullah",
      title: "UI/UX Designer",
      bio:
          "Creative designer focused on creating intuitive and engaging user experiences.",
      phone: "+93 700 444 444",
      email: "hamidullah@example.com",
    ),
    TeamMember(
      id: 5,
      name: "Shabir Ahmad",
      title: "Project Manager",
      bio:
          "Dedicated project manager ensuring successful delivery of all team initiatives.",
      phone: "+93 700 555 555",
      email: "shabir@example.com",
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
        title: Text('Contact ${member.name}'),
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
            child: const Text('Close'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomHeader(
          title: 'Group F',
          selectedIndex: 0,
        ),
        centerTitle: true,
      ),
      body: Padding(
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
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount:
                      1, // you can adjust crossAxisCount based on screen size
                  childAspectRatio: 3 / 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: teamMembers.length,
                itemBuilder: (context, index) {
                  final member = teamMembers[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.blue.shade100,
                            radius: 30,
                            child: Text(
                              getInitials(member.name),
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue.shade700,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            member.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            member.title,
                            style: TextStyle(
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            member.bio,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.black54,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          ElevatedButton(
                            onPressed: () => showContactDialog(context, member),
                            child: const Text('Contact'),
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size.fromHeight(30),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
