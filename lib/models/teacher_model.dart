import 'package:cloud_firestore/cloud_firestore.dart';

class TeacherModel {
  final String id;
  final String name;
  final String position;
  final String email;
  final String phone;
  final String logo; // Teacher photo/avatar
  final String biography;
  final String education;
  final String specialization;
  final String experience;
  final List<String> subjects;
  final String officeHours;
  final String officeLocation;

  TeacherModel({
    required this.id,
    required this.name,
    required this.position,
    required this.email,
    required this.phone,
    required this.logo,
    required this.biography,
    required this.education,
    required this.specialization,
    required this.experience,
    required this.subjects,
    required this.officeHours,
    required this.officeLocation,
  });

  factory TeacherModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return TeacherModel(
      id: doc.id,
      name: data['name'] ?? '',
      position: data['position'] ?? '',
      email: data['email'] ?? '',
      phone: data['phone'] ?? '',
      logo: data['logo'] ?? '',
      biography: data['biography'] ?? '',
      education: data['education'] ?? '',
      specialization: data['specialization'] ?? '',
      experience: data['experience'] ?? '',
      subjects: List<String>.from(data['subjects'] ?? []),
      officeHours: data['officeHours'] ?? '',
      officeLocation: data['officeLocation'] ?? '',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'position': position,
      'email': email,
      'phone': phone,
      'logo': logo,
      'biography': biography,
      'education': education,
      'specialization': specialization,
      'experience': experience,
      'subjects': subjects,
      'officeHours': officeHours,
      'officeLocation': officeLocation,
    };
  }
}
