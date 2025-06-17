import 'package:cloud_firestore/cloud_firestore.dart';

class SemesterModel {
  final String id;
  final String name;
  final String description;
  final String logo; // Semester icon/image
  final int semesterNumber;
  final int totalCredits;
  final List<SubjectModel> subjects;
  final String academicYear;
  final bool isActive;

  SemesterModel({
    required this.id,
    required this.name,
    required this.description,
    required this.logo,
    required this.semesterNumber,
    required this.totalCredits,
    required this.subjects,
    required this.academicYear,
    required this.isActive,
  });

  factory SemesterModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    
    List<SubjectModel> subjectsList = [];
    if (data['subjects'] != null) {
      subjectsList = (data['subjects'] as List)
          .map((subject) => SubjectModel.fromMap(subject))
          .toList();
    }

    return SemesterModel(
      id: doc.id,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      logo: data['logo'] ?? '',
      semesterNumber: data['semesterNumber'] ?? 1,
      totalCredits: data['totalCredits'] ?? 0,
      subjects: subjectsList,
      academicYear: data['academicYear'] ?? '',
      isActive: data['isActive'] ?? true,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'description': description,
      'logo': logo,
      'semesterNumber': semesterNumber,
      'totalCredits': totalCredits,
      'subjects': subjects.map((subject) => subject.toMap()).toList(),
      'academicYear': academicYear,
      'isActive': isActive,
    };
  }
}

class SubjectModel {
  final String id;
  final String name;
  final String code;
  final int credits;
  final String teacherId;
  final String teacherName;
  final String description;
  final bool isRequired;

  SubjectModel({
    required this.id,
    required this.name,
    required this.code,
    required this.credits,
    required this.teacherId,
    required this.teacherName,
    required this.description,
    required this.isRequired,
  });

  factory SubjectModel.fromMap(Map<String, dynamic> data) {
    return SubjectModel(
      id: data['id'] ?? '',
      name: data['name'] ?? '',
      code: data['code'] ?? '',
      credits: data['credits'] ?? 0,
      teacherId: data['teacherId'] ?? '',
      teacherName: data['teacherName'] ?? '',
      description: data['description'] ?? '',
      isRequired: data['isRequired'] ?? true,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'code': code,
      'credits': credits,
      'teacherId': teacherId,
      'teacherName': teacherName,
      'description': description,
      'isRequired': isRequired,
    };
  }
}
