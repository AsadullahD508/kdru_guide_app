import 'package:cloud_firestore/cloud_firestore.dart';
import '../language_provider.dart';

class AdministrativeUnitModel {
  final String id;
  final String name;
  final String director;
  final String information;
  final String vision;
  final String mission;
  final String goals;
  final String year;
  final String logo;
  final String organ;
  final String innovativeProjects;
  final String internationalRelations;
  final String qualityEnhancement;
  final String description;
  final Map<String, dynamic>? contactInfo;

  AdministrativeUnitModel({
    required this.id,
    required this.name,
    required this.director,
    required this.information,
    required this.vision,
    required this.mission,
    required this.goals,
    required this.year,
    required this.logo,
    required this.organ,
    required this.innovativeProjects,
    required this.internationalRelations,
    required this.qualityEnhancement,
    required this.description,
    this.contactInfo,
  });

  factory AdministrativeUnitModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return AdministrativeUnitModel(
      id: doc.id,
      name: data['name'] ?? '',
      director: data['director'] ?? '',
      information: data['information'] ?? '',
      vision: data['Vision'] ?? '',
      mission: data['Mission'] ?? '',
      goals: data['goals'] ?? '',
      year: data['year'] ?? '',
      logo: data['logo'] ?? '',
      organ: data['organ'] ?? '',
      innovativeProjects: data['innovativeProjects'] ?? '',
      internationalRelations: data['internationalRelations'] ?? '',
      qualityEnhancement: data['qualityEnhancement'] ?? '',
      description: data['description'] ?? '',
      contactInfo: data['contactInfo'] is Map<String, dynamic> 
          ? data['contactInfo'] as Map<String, dynamic>
          : null,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'director': director,
      'information': information,
      'Vision': vision,
      'Mission': mission,
      'goals': goals,
      'year': year,
      'logo': logo,
      'organ': organ,
      'innovativeProjects': innovativeProjects,
      'internationalRelations': internationalRelations,
      'qualityEnhancement': qualityEnhancement,
      'description': description,
      if (contactInfo != null) 'contactInfo': contactInfo,
    };
  }

  // Helper method to get the best available image URL
  String get imageUrl {
    if (logo.isNotEmpty) return logo;
    if (organ.isNotEmpty) return organ;
    return '';
  }

  // Helper method to get a short description
  String get shortDescription {
    if (information.isNotEmpty) {
      return information.length > 60
          ? '${information.substring(0, 60)}...'
          : information;
    }
    if (description.isNotEmpty) {
      return description.length > 60
          ? '${description.substring(0, 60)}...'
          : description;
    }
    return '';
  }

  // Helper method to get a short description with localization
  String getShortDescription(LanguageProvider languageProvider) {
    if (information.isNotEmpty) {
      return information.length > 60
          ? '${information.substring(0, 60)}...'
          : information;
    }
    if (description.isNotEmpty) {
      return description.length > 60
          ? '${description.substring(0, 60)}...'
          : description;
    }
    return languageProvider.getLocalizedString('no_information');
  }

  // Helper method to check if the unit has complete information
  bool get hasCompleteInfo {
    return name.isNotEmpty && 
           director.isNotEmpty && 
           (information.isNotEmpty || description.isNotEmpty);
  }

  // Helper method to get formatted establishment year
  String get formattedYear {
    return year.isNotEmpty ? 'د تاسیس کال: $year' : '';
  }

  // Helper method to get formatted establishment year with localization
  String getFormattedYear(LanguageProvider languageProvider) {
    return year.isNotEmpty
        ? '${languageProvider.getLocalizedString('establishment_year')}: $year'
        : '';
  }

  // Helper method to get contact information as a formatted string
  String get formattedContactInfo {
    if (contactInfo == null || contactInfo!.isEmpty) {
      return 'د تماس معلومات نشته';
    }

    List<String> contacts = [];
    contactInfo!.forEach((key, value) {
      contacts.add('$key: $value');
    });

    return contacts.join('\n');
  }

  // Helper method to get contact information as a formatted string with localization
  String getFormattedContactInfo(LanguageProvider languageProvider) {
    if (contactInfo == null || contactInfo!.isEmpty) {
      return languageProvider.getLocalizedString('no_contact_info');
    }

    List<String> contacts = [];
    contactInfo!.forEach((key, value) {
      contacts.add('$key: $value');
    });

    return contacts.join('\n');
  }

  // Helper method to get localized name
  String getLocalizedName(LanguageProvider languageProvider) {
    return name.isNotEmpty ? name : languageProvider.getLocalizedString('no_name');
  }

  // Helper method to get localized director
  String getLocalizedDirector(LanguageProvider languageProvider) {
    return director.isNotEmpty ? director : languageProvider.getLocalizedString('no_director');
  }

  // Helper method to get localized director with label
  String getLocalizedDirectorWithLabel(LanguageProvider languageProvider) {
    if (director.isNotEmpty) {
      return '${languageProvider.getLocalizedString('director_label')}: $director';
    }
    return languageProvider.getLocalizedString('no_director');
  }

  // Helper method to get localized information
  String getLocalizedInformation(LanguageProvider languageProvider) {
    return information.isNotEmpty ? information : languageProvider.getLocalizedString('no_information');
  }

  // Helper method to get localized vision
  String getLocalizedVision(LanguageProvider languageProvider) {
    return vision.isNotEmpty ? vision : languageProvider.getLocalizedString('no_vision');
  }

  // Helper method to get localized mission
  String getLocalizedMission(LanguageProvider languageProvider) {
    return mission.isNotEmpty ? mission : languageProvider.getLocalizedString('no_mission');
  }

  // Helper method to get localized goals
  String getLocalizedGoals(LanguageProvider languageProvider) {
    return goals.isNotEmpty ? goals : languageProvider.getLocalizedString('no_goals');
  }

  // Helper method to get localized description
  String getLocalizedDescription(LanguageProvider languageProvider) {
    return description.isNotEmpty ? description : languageProvider.getLocalizedString('no_description');
  }
}
