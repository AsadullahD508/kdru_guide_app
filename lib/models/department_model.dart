import 'package:cloud_firestore/cloud_firestore.dart';

class DepartmentModel {
  final String id;
  final String name;
  final String description;
  final String logo;
  final int teachersCount;
  final int semestersCount;
  final String establishedYear;
  final String head;
  final String vision;
  final String mission;

  DepartmentModel({
    required this.id,
    required this.name,
    required this.description,
    required this.logo,
    required this.teachersCount,
    required this.semestersCount,
    required this.establishedYear,
    required this.head,
    required this.vision,
    required this.mission,
  });

  factory DepartmentModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return DepartmentModel(
      id: doc.id,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      logo: data['logo'] ?? '',
      teachersCount: data['teachersCount'] ?? 0,
      semestersCount: data['semestersCount'] ?? 0,
      establishedYear: data['establishedYear'] ?? '',
      head: data['head'] ?? '',
      vision: data['vision'] ?? '',
      mission: data['mission'] ?? '',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'description': description,
      'logo': logo,
      'teachersCount': teachersCount,
      'semestersCount': semestersCount,
      'establishedYear': establishedYear,
      'head': head,
      'vision': vision,
      'mission': mission,
    };
  }
}
