import 'package:flutter/material.dart';

class AppLocalizations {
  final String languageCode;

  AppLocalizations(this.languageCode);

  static AppLocalizations of(BuildContext context) {
    return AppLocalizations('ps'); // Default fallback
  }

  // Static method to get localized strings based on language code
  static String getString(String key, String languageCode) {
    final Map<String, String>? strings = _localizedStrings[languageCode];
    return strings?[key] ?? _localizedStrings['ps']?[key] ?? key;
  }

  // All localized strings
  static const Map<String, Map<String, String>> _localizedStrings = {
    // Pashto (ps)
    'ps': {
      // Header
      'university_name': 'د کندهار پوهنتون',
      'welcome_message': 'د کندهار پوهنتون ته ښه راغلاست',
      'you_are_on_main_page': 'تاسو په اصلي صفحه کې یاست.',

      // Menu
      'select_language': 'ژبه وټاکئ',
      'settings': 'تنظیمات',
      'about_app': 'د اپلیکیشن په اړه',
      'ok': 'سمه ده',

      // Language names
      'pashto': 'پښتو',
      'dari': 'دری',
      'english': 'انګلیسي',
      'kdru': 'د کندهار پوهنتون',

      // Language change messages
      'language_changed_to_pashto': 'ژبه پښتو ته بدله شوه',
      'language_changed_to_dari': 'ژبه دری ته بدله شوه',
      'language_changed_to_english': 'ژبه انګلیسي ته بدله شوه',
      'language_changed_to_kdru': 'ژبه د کندهار پوهنتون ته بدله شوه',

      // Home screen
      'faculties': 'پوهنځۍ',
      'departments': 'څانګې',
      'teachers': 'ښوونکي',
      'students': 'زده کړیالان',
      'facilities': 'اسانتیاوې',
      'about': 'په اړه',
      'history': 'تاريخچه',
      'vision': 'لیدلوری',
      'mission': 'ریسالت',
      'objectives': 'موخې',
      'loading': 'پورته کیږي...',

      // Faculty screen
      'faculty_list': 'د کند هار پوهنتون پوهنځي',
      'no_faculty_found': 'هیڅ پوهنځی ونه موندل شو.',
      'error_occurred': 'خطا پېښه شوه. بیا هڅه وکړئ.',
      'for_more_info': 'د نورو معلوماتو لپاره',

      // Department screen
      'department': 'څانګه',
      'department_info': 'د څانګې معلومات',
      'semesters': 'سمسټرونه',
      'curriculum': 'نصاب',

      // Teachers screen
      'all_teachers': 'ټول ښوونکي',
      'teacher_profile': 'د ښوونکي پروفایل',
      'phone': 'ټیلفون',
      'email': 'ایمیل',
      'graduated_school': 'د فراغت پوهنتون',
      'no_teachers_found': 'هیڅ ښوونکی ونه موندل شو.',
      'teacher_error': 'د ښوونکو په ترلاسه کولو کې ستونزه رامنځته شوه.',

      // Subjects/Semesters
      'subjects': 'مضامین',
      'subject_name': 'مضمون',
      'subject_code': 'کوډ',
      'category': 'کټګوري',
      'credit': 'کریډټ',
      'theory': 'نظري',
      'practical': 'عملي',
      'total': 'ټول',
      'prerequisites': 'پیش شرط',
      'semester': 'سمسټر',
      'faculty_level': 'د پوهنځي کچه',
      'teacher_profile_not_available': 'د دغه استاد پروفایل د لاسرسي وړ نه دی',
      'no_subjects_found': 'هیڅ مضمون ونه موندل شو',
      'data_error': 'د معلوماتو په راوړلو کې ستونزه پیدا شوه',

      // Gallery
      'gallery': 'ګالري',
      'no_images': 'هیڅ عکس نشته',
      'show_more_images': 'نور عکسونه شکاره کول',
      'show_less_images': 'لیږ عکسونه شکاره کول',
      'gallery_error': 'د ګالري په لوستلو کې ستونزه',
      'gallery_not_found': 'ګالري ونه موندل شوه',

      // Navigation
      'home': 'کور',
      'search': 'لټون',
      'profile': 'پروفایل',
      'back': 'بیرته',

      // Bottom Navigation
      'home_nav': 'کور',
      'faculties_nav': 'پوهنځۍ',
      'search_nav': 'لټون',
      'profile_nav': 'پروفایل',

      // Faculty Card
      'departments_count': 'څانګې',
      'teachers_count': 'ښوونکي',

      // Home Screen Specific
      'home_page_title': 'کور صفحه',
      'welcome_to_app': 'د کندهار پوهنتون اپلیکیشن ته ښه راغلاست',
      'our_services': 'زموږ خدمتونه',
      'more_info': 'نور معلومات',
      'app_title': 'د کندهار پوهنتون لارښود',

      // University Info
      'university_history': 'د پوهنتون تاریخچه',
      'university_vision': 'د پوهنتون لیدلوری',
      'university_mission': 'د پوهنتون رسالت',
      'university_objectives': 'د پوهنتون موخې',
      'university_facilities': 'د پوهنتون اسانتیاوې',

      // Riyasat Qadari
      'riyasat_qadari': 'ریاست واحدونه',
      'kandahar_university': 'د کندهار پوهنتون',

      // Common Actions
      'details': 'تفصیلات',
      'description': 'تشریح',
      'name': 'نوم',
      'title': 'سرلیک',
      'address': 'پته',
      'website': 'ویب پاڼه',
      'university_address': 'د کندهار ښار، افغانستان',
      'university_website': 'www.kdru.edu.af',
      'default_phone': '+۹۳ ۷۰۰۴۵۰۴۰۲',
      'default_email': 'info@kdru.edu.af',
      'contact': 'اړیکه',
      'more': 'نور',
      'less': 'لږ',
      'show_all': 'ټول وښایاست',
      'hide': 'پټول',
      'refresh': 'بیا تازه کول',
      'retry': 'بیا هڅه',
      'cancel': 'لغوه کول',
      'confirm': 'تایید',
      'save': 'ساتل',
      'edit': 'سمون',
      'select': 'غوره کول',
      'choose': 'ټاکل',
      'download': 'ډاونلوډ',
      'share': 'شریکول',
      'close': 'تړل',
      'next': 'راتلونکی',
      'previous': 'پخوانی',

      // Department Screen
      'department_name': 'څانګه',
      'information': 'معلومات',
      'view_semesters': 'سمسټرونه وګورئ',
      'view_teachers': 'استادان وګورئ',
      'view_gallery': 'ګالري وګورئ',

      // Semester Screen
      'semesters_title': 'سمسټرونه',
      'semester_number': 'سمسټر',
      'subject_name_full': 'د مضمون نوم',
      'subject_code_full': 'کوډ',
      'credit_hours': 'کریډټ ساعتونه',
      'subject_type': 'ډول',
      'compulsory': 'اجباري',
      'optional': 'اختیاري',

      // Teacher Screen
      'all_teachers_title': 'ټول ښوونکي',
      'total_teachers': 'ټول ښوونکي',
      'teacher_name': 'د ښوونکي نوم',
      'teacher_position': 'دنده',
      'teacher_department': 'څانګه',
      'contact_info': 'د اړیکو معلومات',
      'academic_info': 'علمي معلومات',
      'research': 'څیړنه',
      'research_areas': 'د څېړنې ساحې',
      'no_research_available': 'هیڅ څېړنه نشته',
      'view_research': 'څېړنه وګوره',
      'researchers': 'څېړونکي',
      'year': 'کال',
      'view_journal': 'ژورنال وګورئ',
      'age': 'عمر',
      'years_old': 'کلن',
      'rank': 'درجه',
      'published_research': 'خپاره شوې څېړنې',

      // Engineering Faculty
      'civil_engineering': 'ساختماني',
      'electrical_engineering': 'برېښنا',
      'water_environmental': 'اوبه او چاپیریال',
      'civil_description':
          'د ساختماني انجنیري، نقشه جوړونې، او ساختماني موادو تمرکز.',
      'electrical_description':
          'د برېښنا، انرژی تولید او برېښنایی سیستمونو تمرکز.',
      'water_description':
          'د اوبو مدیریت، اوبو رسونې او چاپېریالي مسایلو تمرکز.',
      'teacher_count': 'ښوونکي',
      'course_count': 'کورسونه',

      // Riyasat Qadari
      'riyasat_qadari_title': 'اداری واحدونه',
      'director': 'رئیس',
      'director_name': 'مولوي عبدالرحمن طیبی',

      // Home Services
      'qadari_hospital': 'قادری روغتون',
      'hostel': 'لیلیه',
      'laboratory': 'لابراتوار',
      'conference_hall': 'د غونډو تالار',
      'library': 'کتابتون',
      'research_office': 'ریسرچ معاونیت',

      // Administrative Units
      'administrative_units': 'اداری واحدونه',
      'administrative_units_title': 'د کندهار پوهنتون اداری واحدونه',
      'administrative_units_description':
          'د کندهار پوهنتون اداری واحدونه د پوهنتون د ټولو علمي، اداري، او څېړنیزو چارو مسؤلیت په غاړه لري.',
      'contact_information': 'د تماس معلومات',
      'phone_number': 'شمېره',
      'email_address': 'برېښنالیک آدرس',
      'university_director': 'رئیس - کندهار پوهنتون',

      // Directorate Screen
      'directorate_title': 'اداري ریاستونه',
      'no_administration_data': 'د اداري ریاستونو ډاټا شتون نلري',
      'administration_error': 'خرابي',
      'retry_button': 'بیا هڅه وکړئ',
      'view_details': 'تفصیلات وګورئ',
      'director_label': 'ریس',
      'no_director': 'ریس نشته',
      'no_name': 'نوم نشته',
      'no_information': 'معلومات نشته',

      // Administration Detail Screen
      'general_information': 'عمومي معلومات',

      'goals': 'اهداف',
      'establishment_year': 'د تاسیس کال',
      'innovative_projects': 'نوښتګر پروژې',
      'international_relations': 'نړیوال اړیکې',
      'quality_enhancement': 'د کیفیت ښه والی',
      'additional_information': 'اضافي معلومات',
      'administration_directorate': 'اداري ریاست',

      // Additional localization for administrative unit model
      'no_contact_info': 'د تماس معلومات نشته',
      'no_vision': 'لرلید نشته',
      'no_mission': 'رسالت نشته',
      'no_goals': 'اهداف نشته',
      'no_description': 'تشریح نشته',
      'loading_data': 'ډاټا پورته کیږي...',
      'banner_section': 'د بینر برخه',
      'banner_description': 'دا د بینر برخه ده چې د اداري ریاست د معلوماتو څخه وروسته ښودل کیږي',
      'image_not_available': 'انځور شتون نلري',
      'image_viewer_instructions': 'د لویولو لپاره ګوتې وکاروئ • د حرکت لپاره یې راښکته کړئ • د وتلو لپاره د تړلو تڼۍ ټک کړئ',

      // Teacher Profile Screen
      'teacher_data_error': 'د استاد د معلوماتو په لوستلو کې ستونزه رامنځته شوه',
      'loading_teacher_data': 'د استاد معلومات پورته کیږي...',
      'teacher_not_found': 'استاد ونه موندل شو',
      'academic_rank': 'علمي رتبه',

      'director_description':
          'د کندهار پوهنتون رئیس چې د پوهنتون د پراختیا او علمي معیار لوړولو لپاره ژمن دی.',
      'no_administrative_units': 'د اداری واحدونو معلومات نشته',

      // Administrative Unit Types
      'pdc_department': 'PDC څانګه',
      'decoration_department': 'د ښکلا څانګه',
      'media_center': 'رسنیز مرکز',
      'vice_chancellor_office': 'د مرستیال دفتر',
      'unknown_unit': 'نامعلوم واحد',

      // Administrative Unit Descriptions
      'pdc_description': 'د PDC څانګې تفصیلات',
      'decoration_description': 'د ښکلا څانګې تفصیلات',
      'media_center_description': 'د رسنیز مرکز تفصیلات',
      'vice_chancellor_description': 'د مرستیال دفتر تفصیلات',
      'unit_description': 'د اداری واحد تفصیلات',

      // Faculty Specific
      'engineering_faculty': 'د انجنري پوهنځی',
      'engineering_welcome': 'د انجنري پوهنځي ته ښه راغلاست',
      'engineering_description':
          'د انجنري پوهنځی د هیواد د بیارغونې، پراختیا او تخنیکي ظرفیت لوړولو لپاره جوړ شوی.',
      'faculty_vision': 'لرلید',
      'faculty_mission': 'ریسالت',
      'vision_description':
          'د یوه مسلکي، تخنیکي او تحقیق پر بنسټ انجنري پوهنځی جوړول...',
      'mission_description':
          'د انجنري پوهنځی د هیواد د بیارغونې، پراختیا او تخنیکي ظرفیت لوړولو لپاره جوړ شوی.',

      // Faculty History & Stats
      'faculty_history': 'پېښلیک پوهنځی',
      'faculty_history_description': 'د پوهنځی پېښلیک...',
      'departments_stats': 'څانګې',
      'teachers_stats': 'ښوونکي',
      'staff_count': 'کارکوونکي',
      'laboratories_count': 'لابراتوارونه',
      'students_count': 'زده کړیالان',

      // Computer Science Faculty
      'computer_science_faculty': 'د کمپیوټر ساینس پوهنځی',
      'cs_welcome': 'د کمپیوټر ساینس پوهنځي ته ښه راغلاست',

      // Hospital & Services
      'hospital': 'روغتون',
      'hospital_details': 'د روغتون تفصیلات',

      // Profile & User
      'profile_screen': 'پروفایل',
      'user_profile': 'د کارونکي پروفایل',

      // Objectives & Responsibilities
      'objectives_responsibilities': 'موخې او مسؤلیتونه',
      'quality_education': '۱. د کیفیت ښوونه او روزنه',
      'research_development': '۲. څیړنې او پراختیا',
      'community_engagement': '۳. د ټولنې ګډون',
      'innovation_creativity': '۴. د نوښت او خلاقیت وده',
      'international_collaboration': '۵. د ملي او نړیوالو همکاریو پیاوړتیا',
      'professional_graduates': '۶. د مسلکي او اخلاقي فارغانو روزنه',
      'capacity_building': '۷. د کارکوونکو او استادانو د ظرفیت لوړول',
      'sustainable_development': '۸. د دوامداره پراختیا موخو ملاتړ',

      // Afghan Scholars
      'afghan_scholars': 'افغان پوهان',

      // Semester
      'semester_screen': 'سمسټر',
      'semester_details': 'د سمسټر تفصیلات',

      // Department
      'department_screen': 'څانګه',
      'department_details': 'د څانګې تفصیلات',

      // Faculty Vision, Mission, Objectives
      'vision_title': 'لیدلوری',
      'mission_title': 'دنده',
      'objective_title': 'موخه',
      'objectives_title': 'موخې',

      // Department & Faculty Actions
      'view_semesters_btn': 'سمسټرونه وګورئ',
      'view_teachers_btn': 'استادان وګورئ',
      'view_gallery_btn': 'ګالري وګورئ',
      'view_departments': 'څانګې وګورئ',

      // Gallery & Media
      'gallery_title': 'ګالري',
      'photo_gallery': 'د عکسونو ګالري',
      'video_gallery': 'د ویډیو ګالري',

      // Academic Programs
      'programs_offered': 'وړاندې شوي پروګرامونه',
      'degree': 'درجه',
      'master_degree': 'ماسټري',
      'phd_degree': 'دوکتورا',

      // Statistics & Numbers
      'total_students': 'ټول زده کړیالان',
      'total_faculty': 'ټول ښوونکي',
      'total_departments': 'ټولې څانګې',
      'total_courses': 'ټول کورسونه',

      // App Guide
      'app_guide': 'لارشود افلیکیشن',
      'app_guide_description':
          'دلته تاسی د کندهار پوهنتون په اړه معلومات پیدا کولای شی د ټولو پوهنځیو مضامین او استادانو په اړه معلومات پیدا کولای شی',

      // Error Messages
      'teachers_fetch_error':
          'د استادانو په ترلاسه کولو کې ستونزه رامنځته شوه.',
      'no_teachers_found_error': 'هیڅ استاد ونه موندل شو.',
      'departments_fetch_error':
          'د څانګو په ترلاسه کولو کې ستونزه رامنځته شوه.',
      'no_departments_found': 'هیڅ څانګه ونه موندل شوه.',
      'faculties_fetch_error':
          'د پوهنځیو په ترلاسه کولو کې ستونزه رامنځته شوه.',
      'no_faculties_found': 'هیڅ پوهنځی ونه موندل شو.',
      'subjects_fetch_error': 'د مضامینو په ترلاسه کولو کې ستونزه رامنځته شوه.',
      'no_subjects_found_error': 'هیڅ مضمون ونه موندل شو.',
      'semesters_fetch_error':
          'د سمسټرونو په ترلاسه کولو کې ستونزه رامنځته شوه.',
      'no_semesters_found': 'هیڅ سمسټر ونه موندل شو.',
      'gallery_fetch_error': 'د ګالري په ترلاسه کولو کې ستونزه رامنځته شوه.',
      'no_gallery_found': 'هیڅ ګالري ونه موندل شوه.',
      'data_fetch_error': 'د معلوماتو په ترلاسه کولو کې ستونزه رامنځته شوه.',
      'connection_error': 'د انټرنیټ اتصال کې ستونزه شته.',
      'try_again': 'بیا هڅه وکړئ',

      // Curriculum Screen
      'curriculum_fetch_error': 'د نصاب د معلوماتو په لوستلو کې ستونزه رامنځته شوه',
      'loading_curriculum': 'د نصاب معلومات پورته کیږي...',
      'no_curriculum_found': 'هیڅ نصاب ونه موندل شو',
      'theory_hours': 'نظري ساعتونه',
      'practical_hours': 'عملي ساعتونه',
      'total_hours': 'ټول ساعتونه',

      // Faculty History
      'faculty_history_title': 'د پوهنځي تاریخچه',
      'department_title': 'څانګه',
      'teachers_title': 'ښوونکي',
      'students_title': 'زده کړیالان',
      'staff_title': 'کارکوونکي',
      'courses_title': 'کورسونه',
      'laboratories_title': 'لابراتوارونه',

      // Navigation and UI
      'go_back': 'بیرته ولاړ شه',
      'continue': 'دوام ورکړه',
      'submit': 'وسپاره',
      'reset': 'بیا تنظیم کړه',
      'clear': 'پاک کړه',
      'apply': 'پلي کړه',
      'filter': 'فلټر',
      'sort': 'ترتیب',
      'view_all': 'ټول وګوره',

      'show_more': 'نور وښایه',
      'show_less': 'لږ وښایه',

      // Settings and About Dialog
      'settings_coming_soon': 'د تنظیماتو برخه په راتلونکي کې اضافه کیږي.',
      'about_app_description':
          'د کندهار پوهنتون لارښود اپلیکیشن\nنسخه: ۱.۰.۰\nجوړونکی: د کندهار پوهنتون ټیم',
      'version': 'نسخه',
      'developed_by': 'جوړونکی',
      'kandahar_university_team': 'د کندهار پوهنتون ټیم',
      'contact_us': 'زموږ سره اړیکه ونیسئ',

      // Profile Menu
      'notifications': 'خبرتیاوې',
      'reviews': 'بیاکتنې',
      'payments': 'تادیات',
      'no_notifications': 'هیڅ خبرتیا نشته.',
      'no_reviews': 'هیڅ بیاکتنه نشته.',
      'no_payments': 'هیڅ تادیه نشته.',

      // Cache and Offline Status
      'loaded_from_cache': 'د کیش څخه لوډ شوي (آفلاین)',
      'loaded_from_server': 'د سرور څخه لوډ شوي (آنلاین)',
      'offline': 'آفلاین',
      'online': 'آنلاین',
      'syncing': 'د سینک کولو په انتظار کې',
      'documents_count': 'د اسنادو شمیر',

      'loading_from_cache_if_available': '(د کیش څخه لوډ کیږي که شتون ولري)',
      'clear_cache': 'کیش پاک کړه',
      'cache_cleared': 'کیش پاک شو',
      'cache_status': 'د کیش حالت',
      'data_cached': 'ډاټا کیش شوه',
      'cache_updated': 'کیش تازه شو',
      'offline_mode': 'آفلاین حالت',
      'online_mode': 'آنلاین حالت',
      'sync_pending': 'سینک پاتې دی',
      'sync_complete': 'سینک بشپړ شو',
      'cache_size': 'د کیش اندازه',
      'unlimited_cache': 'لامحدود کیش',

      // Search functionality
      'search_teachers': 'د ښوونکو لټون',
      'search_teacher_hint': 'د ښوونکي نوم یا ایمیل ولیکئ...',
      'searching': 'لټون کیږي...',
      'search_teachers_instruction': 'د ښوونکو د لټون لپاره د ښوونکي نوم یا ایمیل ولیکئ',
      'try_different_search': 'د بل ډول لټون هڅه وکړئ',
      'found_teachers': 'موندل شوي ښوونکي',
      'unknown_teacher': 'نامعلوم ښوونکی',
      'tap_to_expand': 'د لویولو لپاره ټک کړئ',
      'faculty_organ': 'د پوهنځي ارګان',

      // Exit confirmation
      'exit_app': 'د اپلیکیشن پریښودل',
      'exit_app_confirmation': 'ایا تاسو ډاډه یاست چې غواړئ د اپلیکیشن څخه ووځئ؟',
      'exit': 'ووځه',

      // Common
      'unknown': 'نامعلوم',
      'guest_user': 'میلمه کارونکی',
      'university_dean': 'د پوهنتون ریس',
      'chancellor_message': 'د ریس پیغام',
      'university_information': 'د پوهنتون معلومات',
      'committees': 'کمیټې',
      'no_committees_available': 'هیڅ کمیټې شتون نلري',
      'committee_head': 'د کمیټې مشر',
      'committee_members': 'د کمیټې غړي',
      'committee_description': 'د کمیټې تشریح',
      'no_prerequisites_available': 'هیڅ اړتیاوې شتون نلري',
      'active_committee': 'فعاله کمیټه',
      'inactive_committee': 'غیر فعاله کمیټه',
    },

    // Dari (fa)
    'fa': {
      // Header
      'university_name': 'پوهنتون کندهار',
      'welcome_message': 'به پوهنتون کندهار خوش آمدید',
      'you_are_on_main_page': 'شما در صفحه اصلی هستید.',

      // Menu
      'select_language': 'زبان را انتخاب کنید',
      'settings': 'تنظیمات',
      'about_app': 'درباره برنامه',
      'ok': 'تایید',

      // Language names
      'pashto': 'پښتو',
      'dari': 'دری',
      'english': 'English',
      'kdru': 'پوهنتون کندهار',

      // Language change messages
      'language_changed_to_pashto': 'زبان به پښتو تغییر یافت',
      'language_changed_to_dari': 'زبان به دری تغییر یافت',
      'language_changed_to_english': 'زبان به انگلیسی تغییر یافت',
      'language_changed_to_kdru': 'زبان به پوهنتون کندهار تغییر یافت',

      // Home screen
      'faculties': 'پوهنځی‌ها',
      'departments': 'دیپارتمنت‌ها',
      'teachers': 'استادان',
      'students': 'دانشجویان',
      'facilities': 'امکانات',
      'about': 'درباره',
      'history': 'تاریخچه',
      'vision': 'چشم‌انداز',
      'mission': 'مأموریت',
      'objectives': 'اهداف',
      'loading': 'در حال بارگذاری...',

      // Faculty screen
      'faculty_list': 'پوهنځی‌های پوهنتون کندهار',
      'no_faculty_found': 'هیچ پوهنځی یافت نشد.',
      'error_occurred': 'خطا رخ داد. دوباره تلاش کنید.',
      'for_more_info': 'برای اطلاعات بیشتر',

      // Department screen
      'department': 'دیپارتمنت',
      'department_info': 'اطلاعات دیپارتمنت',
      'semesters': 'سمسترها',
      'curriculum': 'برنامه درسی',

      // Teachers screen
      'all_teachers_title': 'همه استادا',
      'total_teachers': 'همه استادا',
      'teacher_profile': 'پروفایل استاد',
      'academic_info': 'اطلاعات علمی',
      'research': 'تحقیق',
      'research_areas': 'حوزه‌های تحقیق',
      'no_research_available': 'هیچ تحقیقی موجود نیست',
      'view_research': 'مشاهده تحقیق',
      'researchers': 'محققان',
      'year': 'سال',
      'degree': 'درجه',
      'view_journal': 'مشاهده ژورنال',
      'age': 'سن',
      'years_old': 'ساله',
      'rank': 'رتبه',
      'published_research': 'تحقیقات منتشر شده',
      'phone': 'تلفن',
      'email': 'ایمیل',
      'graduated_school': 'پوهنتون فارغ‌التحصیلی',
      'no_teachers_found': 'هیچ استادی یافت نشد.',
      'teacher_error': 'مشکل در دریافت اطلاعات استادان.',

      // Subjects/Semesters
      'subjects': 'مضامین',
      'subject_name': 'نام مضمون',
      'subject_code': 'کد',
      'category': 'دسته‌بندی',
      'credit': 'کریدیت',
      'theory': 'نظری',
      'practical': 'عملی',
      'total': 'مجموع',
      'prerequisites': 'پیش‌نیاز',
      'semester': 'سمستر',
      'faculty_level': 'سطح پوهنځی',
      'teacher_profile_not_available': 'پروفایل این استاد در دسترس نیست',
      'no_subjects_found': 'هیچ مضمونی یافت نشد',
      'data_error': 'مشکل در دریافت اطلاعات',

      // Gallery
      'gallery': 'گالری',
      'no_images': 'هیچ تصویری وجود ندارد',
      'show_more_images': 'نمایش تصاویر بیشتر',
      'show_less_images': 'نمایش تصاویر کمتر',
      'gallery_error': 'مشکل در خواندن گالری',
      'gallery_not_found': 'گالری یافت نشد',

      // Navigation
      'home': 'خانه',
      'search': 'جستجو',
      'profile': 'پروفایل',
      'back': 'بازگشت',

      // Error Messages
      'teachers_fetch_error': 'مشکل در دریافت اطلاعات استادان.',
      'no_teachers_found_error': 'هیچ استادی یافت نشد.',
      'departments_fetch_error': 'مشکل در دریافت اطلاعات دیپارتمنت‌ها.',
      'no_departments_found': 'هیچ دیپارتمنتی یافت نشد.',
      'faculties_fetch_error': 'مشکل در دریافت اطلاعات پوهنځی‌ها.',
      'no_faculties_found': 'هیچ پوهنځی یافت نشد.',
      'subjects_fetch_error': 'مشکل در دریافت اطلاعات مضامین.',
      'no_subjects_found_error': 'هیچ مضمونی یافت نشد.',
      'semesters_fetch_error': 'مشکل در دریافت اطلاعات سمسترها.',
      'no_semesters_found': 'هیچ سمستری یافت نشد.',
      'gallery_fetch_error': 'مشکل در دریافت گالری.',
      'no_gallery_found': 'هیچ گالری یافت نشد.',
      'data_fetch_error': 'مشکل در دریافت اطلاعات.',
      'connection_error': 'مشکل در اتصال اینترنت.',
      'try_again': 'دوباره تلاش کنید',
      'retry_button': 'تلاش مجدد',

      // Curriculum Screen
      'curriculum_fetch_error': 'مشکل در دریافت اطلاعات برنامه درسی',
      'loading_curriculum': 'در حال بارگذاری برنامه درسی...',
      'no_curriculum_found': 'هیچ برنامه درسی یافت نشد',
      'theory_hours': 'ساعات نظری',
      'practical_hours': 'ساعات عملی',
      'total_hours': 'مجموع ساعات',

      // Faculty History
      'faculty_history_title': 'تاریخچه پوهنځی',
      'department_title': 'دیپارتمنت',
      'teachers_title': 'استادان',
      'students_title': 'دانشجویان',
      'staff_title': 'کارکنان',
      'courses_title': 'دوره‌ها',
      'laboratories_title': 'آزمایشگاه‌ها',


      // Navigation and UI
      'go_back': 'بازگشت',
      'continue': 'ادامه',
      'submit': 'ارسال',
      'reset': 'تنظیم مجدد',
      'clear': 'پاک کردن',
      'apply': 'اعمال',
      'filter': 'فیلتر',
      'sort': 'مرتب‌سازی',
      'view_all': 'مشاهده همه',
      'view_details': 'مشاهده جزئیات',
      'show_more': 'نمایش بیشتر',
      'show_less': 'نمایش کمتر',
      'qadari_hospital': 'قادری روغتون',
      'hostel': 'لیلیه',
      'laboratory': 'لابراتوار',
      'conference_hall': 'د غونډو تالار',
      'library': 'کتابتون',
     

      // Settings and About Dialog
      'settings_coming_soon': 'بخش تنظیمات در آینده اضافه خواهد شد.',
      'about_app_description':
          'اپلیکیشن راهنمای پوهنتون کندهار\nنسخه: ۱.۰.۰\nتوسعه‌دهنده: تیم پوهنتون کندهار',
      'version': 'نسخه',
      'developed_by': 'توسعه‌دهنده',
      'kandahar_university_team': 'تیم پوهنتون کندهار',
      'contact_us': 'با ما تماس بگیرید',

      // Profile Menu
      'notifications': 'اطلاعیه‌ها',
      'reviews': 'بررسی‌ها',
      'payments': 'پرداخت‌ها',
      'no_notifications': 'هیچ اطلاعیه‌ای وجود ندارد.',
      'no_reviews': 'هیچ بررسی‌ای وجود ندارد.',
      'no_payments': 'هیچ پرداختی وجود ندارد.',


      // Contact Information
      'address': 'آدرس',

      'website': 'وب‌سایت',
      'university_address': 'شهر کندهار، افغانستان',
      'university_website': 'www.kdru.edu.af',
      'default_phone': '+۹۳ ۷۰۰۴۵۰۴۰۲',
      'default_email': 'info@kdru.edu.af',

      // Banner Section
      'banner_section': 'بخش بنر',
      'banner_description': 'این بخش بنر است که پس از اطلاعات ریاست اداری نمایش داده می‌شود',
      'image_not_available': 'تصویر در دسترس نیست',
      'image_viewer_instructions': 'برای بزرگ‌نمایی انگشتان را فشار دهید • برای حرکت بکشید • برای خروج دکمه بستن را لمس کنید',

      // Search functionality
      'search_teachers': 'جستجوی استادان',
      'search_teacher_hint': 'نام یا ایمیل استاد را بنویسید...',
      'searching': 'در حال جستجو...',
      'search_teachers_instruction': 'برای جستجوی استادان، نام یا ایمیل استاد را بنویسید',
      'try_different_search': 'جستجوی متفاوتی امتحان کنید',
      'found_teachers': 'استادان یافت شده',
      'unknown_teacher': 'استاد نامعلوم',
      'tap_to_expand': 'برای بزرگ کردن ضربه بزنید',
      'faculty_organ': 'ارگان پوهنځی',

      // Exit confirmation
      'exit_app': 'خروج از برنامه',
      'exit_app_confirmation': 'آیا مطمئن هستید که می‌خواهید از برنامه خارج شوید؟',
      'exit': 'خروج',

      // Common
      'unknown': 'نامعلوم',
      'guest_user': 'کاربر مهمان',
      'information': 'اطلاعات',
      'university_dean': 'رئیس پوهنتون',
      'chancellor_message': 'پیام ریس',
      'university_information': 'اطلاعات پوهنتون',
      'committees': 'کمیته‌ها',
      'no_committees_available': 'هیچ کمیته‌ای موجود نیست',
      'committee_head': 'رئیس کمیته',
      'committee_members': 'اعضای کمیته',
      'committee_description': 'توضیحات کمیته',
      'no_prerequisites_available': 'هیچ پیش‌نیازی موجود نیست',
      'active_committee': 'کمیته فعال',
      'inactive_committee': 'کمیته غیرفعال',
    },

    // English (en)
    'en': {
      // Header
      'university_name': 'Kandahar University',
      'welcome_message': 'Welcome to Kandahar University',
      'you_are_on_main_page': 'You are on the main page.',

      // Menu
      'select_language': 'Select Language',
      'settings': 'Settings',
      'about_app': 'About App',
      'ok': 'OK',

      // Language names
      'pashto': 'Pashto',
      'dari': 'Dari',
      'english': 'English',
      'kdru': 'Kandahar University',

      // Language change messages
      'language_changed_to_pashto': 'Language changed to Pashto',
      'language_changed_to_dari': 'Language changed to Dari',
      'language_changed_to_english': 'Language changed to English',
      'language_changed_to_kdru': 'Language changed to Kandahar University',

      // Home screen
      'faculties': 'Faculties',
      'departments': 'Departments',
      'teachers': 'Teachers',
      'students': 'Students',
      'facilities': 'Facilities',
      'about': 'About',
      'history': 'History',
      'vision': 'Vision',
      'mission': 'Mission',
      'objectives': 'Objectives',
      'loading': 'Loading...',

      // Faculty screen
      'faculty_list': 'Kandahar University Faculties',
      'no_faculty_found': 'No faculty found.',
      'error_occurred': 'An error occurred. Please try again.',
      'for_more_info': 'For More Information',

      // Department screen
      'department': 'Department',
      'department_info': 'Department Information',
      'semesters': 'Semesters',
      'curriculum': 'Curriculum',

      // Teachers screen
      'all_teachers': 'All Teachers',
      'teacher_profile': 'Teacher Profile',
      'academic_info': 'Academic Information',
      'research': 'Research',
      'research_areas': 'Research Areas',
      'no_research_available': 'No research available',
      'view_research': 'View Research',
      'researchers': 'Researchers',
      'year': 'Year',
      'view_journal': 'View Journal',
      'age': 'Age',
      'years_old': 'years old',
      'rank': 'Rank',
      'published_research': 'Published Research',
      'phone': 'Phone',
      'email': 'Email',
      'graduated_school': 'Graduated University',
      'no_teachers_found': 'No teachers found.',
      'teacher_error': 'Error retrieving teacher information.',

      // Subjects/Semesters
      'subjects': 'Subjects',
      'subject_name': 'Subject',
      'subject_code': 'Code',
      'category': 'Category',
      'credit': 'Credit',
      'theory': 'Theory',
      'practical': 'Practical',
      'total': 'Total',
      'prerequisites': 'Prerequisites',
      'semester': 'Semester',
      'faculty_level': 'Faculty Level',
      'teacher_profile_not_available': 'This teacher\'s profile is not available',
      'no_subjects_found': 'No subjects found',
      'data_error': 'Error retrieving data',

      // Gallery
      'gallery': 'Gallery',
      'no_images': 'No images available',
      'show_more_images': 'Show More Images',
      'show_less_images': 'Show Less Images',
      'gallery_error': 'Error reading gallery',
      'gallery_not_found': 'Gallery not found',

      // Navigation
      'home': 'Home',
      'search': 'Search',
      'profile': 'Profile',
      'back': 'Back',

      // Home Screen Specific
      'home_page_title': 'Home Page',
      'welcome_to_app': 'Welcome to Kandahar University Application',
      'our_services': 'Our Services',
      'more_info': 'More Information',
      'app_title': 'KDRU Guide App',
      'qadari_hospital': 'Qadri Hospital',
      'hostel': 'Hostel',
      'laboratory': 'Laboratory',
      'conference_hall': 'Conference Hall',
      'library': 'Library',
      'research_office': 'Research Office',


      // University Info
      'university_history': 'University History',
      'university_vision': 'University Vision',
      'university_mission': 'University Mission',
      'university_objectives': 'University Objectives',
      'university_facilities': 'University Facilities',

      // Riyasat Qadari
      'riyasat_qadari': 'Riyasat Qadari',
      'kandahar_university': 'Kandahar University',
      'university_administration': 'University Administration',
      'riyasat_qadari_title': 'Administrative Directorate',

      // Directorate Screen
      'directorate_title': 'Administrative Directorates',
      'no_administration_data': 'No administrative directorate data available',
      'administration_error': 'Error',
      'retry_button': 'Try Again',
      'view_details': 'View Details',
      'director_label': 'Director',
      'no_director': 'No Director',
      'no_name': 'No Name',
      'no_information': 'No Information',

      // Administration Detail Screen
      'general_information': 'General Information',

      'goals': 'Goals',
      'establishment_year': 'Establishment Year',
      'innovative_projects': 'Innovative Projects',
      'international_relations': 'International Relations',
      'quality_enhancement': 'Quality Enhancement',
      'additional_information': 'Additional Information',
      'administration_directorate': 'Administrative Directorate',

      // Additional localization for administrative unit model
      'no_contact_info': 'No contact information available',
      'no_vision': 'No vision available',
      'no_mission': 'No mission available',
      'no_goals': 'No goals available',
      'no_description': 'No description available',
      'loading_data': 'Loading data...',
      'banner_section': 'Banner Section',
      'banner_description': 'This is the banner section that appears after the administrative directorate information',
      'image_not_available': 'Image not available',
      'image_viewer_instructions': 'Pinch to zoom • Drag to pan • Tap close button to exit',

      // Teacher Profile Screen
      'teacher_data_error': 'Error occurred while loading teacher data',
      'loading_teacher_data': 'Loading teacher data...',
      'teacher_not_found': 'Teacher not found',
      'academic_rank': 'Academic Rank',
      'degree': 'degree',

      // Error Messages
      'teachers_fetch_error': 'Error retrieving teacher information.',
      'no_teachers_found_error': 'No teachers found.',
      'departments_fetch_error': 'Error retrieving department information.',
      'no_departments_found': 'No departments found.',
      'faculties_fetch_error': 'Error retrieving faculty information.',
      'no_faculties_found': 'No faculties found.',
      'subjects_fetch_error': 'Error retrieving subject information.',
      'no_subjects_found_error': 'No subjects found.',
      'semesters_fetch_error': 'Error retrieving semester information.',
      'no_semesters_found': 'No semesters found.',
      'gallery_fetch_error': 'Error retrieving gallery.',
      'no_gallery_found': 'No gallery found.',
      'data_fetch_error': 'Error retrieving data.',
      'connection_error': 'Internet connection problem.',
      'try_again': 'Please try again',

      // Curriculum Screen
      'curriculum_fetch_error': 'Error occurred while loading curriculum data',
      'loading_curriculum': 'Loading curriculum...',
      'no_curriculum_found': 'No curriculum found',
      'theory_hours': 'Theory Hours',
      'practical_hours': 'Practical Hours',
      'total_hours': 'Total Hours',

      // Teachers screen
      'all_teachers_title': 'All Teachers',
      'total_teachers': 'Total Teachers',

      // Faculty History
      'faculty_history_title': 'Faculty History',
      'department_title': 'Department',
      'teachers_title': 'Teachers',
      'students_title': 'Students',
      'staff_title': 'Staff',
      'courses_title': 'Courses',
      'laboratories_title': 'Laboratories',

      // Navigation and UI
      'go_back': 'Go Back',
      'continue': 'Continue',
      'submit': 'Submit',
      'reset': 'Reset',
      'clear': 'Clear',
      'apply': 'Apply',
      'filter': 'Filter',
      'sort': 'Sort',
      'view_all': 'View All',

      'show_more': 'Show More',
      'show_less': 'Show Less',

      // Settings and About Dialog
      'settings_coming_soon': 'Settings section will be added in the future.',
      'about_app_description':
          'Kandahar University Guide App\nVersion: 1.0.0\nDeveloped by: Kandahar University Team',
      'version': 'Version',
      'developed_by': 'Developed by',
      'kandahar_university_team': 'Kandahar University Team',
      'contact_us': 'Contact Us',

      // Profile Menu
      'notifications': 'Notifications',
      'reviews': 'Reviews',
      'payments': 'Payments',
      'no_notifications': 'No notifications available.',
      'no_reviews': 'No reviews available.',
      'no_payments': 'No payments available.',

      // Contact Information
      'address': 'Address',
      'website': 'Website',
      'university_address': 'Kandahar City, Afghanistan',
      'university_website': 'www.kdru.edu.af',
      'default_phone': '+93 700450402',
      'default_email': 'info@kdru.edu.af',

      // Cache and Offline Status
      'loaded_from_cache': 'Loaded from Cache (Offline)',
      'loaded_from_server': 'Loaded from Server (Online)',
      'offline': 'Offline',
      'online': 'Online',
      'syncing': 'Syncing...',
      'documents_count': 'Documents Count',

      'loading_from_cache_if_available': '(Loading from cache if available)',
      'clear_cache': 'Clear Cache',
      'cache_cleared': 'Cache Cleared',
      'cache_status': 'Cache Status',
      'data_cached': 'Data Cached',
      'cache_updated': 'Cache Updated',
      'offline_mode': 'Offline Mode',
      'online_mode': 'Online Mode',
      'sync_pending': 'Sync Pending',
      'sync_complete': 'Sync Complete',
      'cache_size': 'Cache Size',
      'unlimited_cache': 'Unlimited Cache',

      // Search functionality
      'search_teachers': 'Search Teachers',
      'search_teacher_hint': 'Enter teacher name or email...',
      'searching': 'Searching...',
      'search_teachers_instruction': 'To search for teachers, enter teacher name or email',
      'try_different_search': 'Try a different search',
      'found_teachers': 'Teachers found',
      'unknown_teacher': 'Unknown Teacher',
      'tap_to_expand': 'Tap to expand',
      'faculty_organ': 'Faculty Organ',

      // Exit confirmation
      'exit_app': 'Exit App',
      'exit_app_confirmation': 'Are you sure you want to exit the application?',
      'exit': 'Exit',

      // Common
      'unknown': 'Unknown',
      'guest_user': 'Guest User',
      'information': 'Information',
      'university_dean': 'University Dean',
      'chancellor_message': 'Chancellor Message',
      'university_information': 'University Information',
      'committees': 'Committees',
      'no_committees_available': 'No committees available',
      'committee_head': 'Committee Head',
      'committee_members': 'Committee Members',
      'committee_description': 'Committee Description',
      'no_prerequisites_available': 'No prerequisites available',
      'active_committee': 'Active Committee',
      'inactive_committee': 'Inactive Committee',
    },

    // KDRU (kdru) - Mixed Pashto/Dari for Kandahar University
    'kdru': {
      // Header
      'university_name': 'د کندهار پوهنتون',
      'welcome_message': 'د کندهار پوهنتون ته ښه راغلاست',
      'you_are_on_main_page': 'تاسو په اصلي پاڼه کې یاست.',

      // Menu
      'select_language': 'ژبه وټاکئ',
      'settings': 'امستنې',
      'about_app': 'د غوښتنلیک په اړه',
      'ok': 'سمه ده',

      // Language names
      'pashto': 'پښتو',
      'dari': 'دری',
      'english': 'انګلیسي',
      'kdru': 'د کندهار پوهنتون',

      // Language change messages
      'language_changed_to_pashto': 'ژبه پښتو ته بدله شوه',
      'language_changed_to_dari': 'ژبه دری ته بدله شوه',
      'language_changed_to_english': 'ژبه انګلیسي ته بدله شوه',
      'language_changed_to_kdru': 'ژبه د کندهار پوهنتون ته بدله شوه',

      // Home screen
      'faculties': 'پوهنځۍ',
      'departments': 'څانګې',
      'teachers': 'ښوونکي',
      'students': 'زده کړیالان',
      'facilities': 'اسانتیاوې',
      'about': 'په اړه',
      'history': 'تاریخچه',
      'vision': 'لیدلوری',
      'mission': 'ریسالت',
      'objectives': 'موخې',
      'loading': 'پورته کیږي...',

      // Faculty screen
      'faculty_list': 'د کندهار پوهنتون پوهنځۍ',
      'no_faculty_found': 'هیڅ پوهنځی ونه موندل شو.',
      'error_occurred': 'تېروتنه پېښه شوه. بیا هڅه وکړئ.',
      'for_more_info': 'د نورو معلوماتو لپاره',

      // Department screen
      'department': 'څانګه',
      'department_info': 'د څانګې معلومات',
      'semesters': 'شپږمیاشتنۍ',
      'curriculum': 'زده کړې',

      // Teachers screen
      'all_teachers': 'ټول ښوونکي',
      'all_teachers_title': 'ټول ښوونکي',
      'total_teachers': 'ټول ښوونکي',
      'teacher_profile': 'د ښوونکي پېژندنه',
      'academic_info': 'علمي معلومات',
      'research': 'څیړني',
      'research_areas': 'د څېړنې ساحې',
      'no_research_available': 'هیڅ څېړنه شتون نلري',
      'view_research': 'څېړنه وګوره',
      'researchers': 'څېړونکي',
      'year': 'کال',
      'view_journal': 'ژورنال وګورئ',
      'age': 'عمر',
      'years_old': 'کلن',
      'rank': 'درجه',
      'published_research': 'خپاره شوې څېړنې',
      'phone': 'تلیفون',
      'email': 'برېښنالیک',
      'graduated_school': 'د فراغت پوهنتون',
      'no_teachers_found': 'هیڅ ښوونکی ونه موندل شو.',
      'teacher_error': 'د ښوونکو د معلوماتو په ترلاسه کولو کې ستونزه.',

      // Subjects/Semesters
      'subjects': 'مضامین',
      'subject_name': 'مضمون',
      'subject_code': 'کوډ',
      'category': 'ډول',
      'credit': 'کریډټ',
      'theory': 'تیوري',
      'practical': 'عملي',
      'total': 'ټول',
      'prerequisites': 'مخکینۍ اړتیاوې',
      'semester': 'شپږمیاشتنۍ',
      'faculty_level': 'د پوهنځي کچه',
      'teacher_profile_not_available': 'د دغه ښوونکي پروفایل د لاسرسي وړ نه دی',
      'no_subjects_found': 'هیڅ مضمون ونه موندل شو',
      'data_error': 'د معلوماتو په راوړلو کې ستونزه',

      // Gallery
      'gallery': 'انځورتون',
      'no_images': 'هیڅ انځور نشته',
      'show_more_images': 'نور انځورونه وښایاست',
      'show_less_images': 'لږ انځورونه وښایاست',
      'gallery_error': 'د انځورتون په لوستلو کې ستونزه',
      'gallery_not_found': 'انځورتون ونه موندل شو',

      // Navigation
      'home': 'کور',
      'search': 'پلټنه',
      'profile': 'پېژندنه',
      'back': 'شاته',

      // Home Screen Specific
      'home_page_title': 'کور پاڼه',
      'welcome_to_app': 'د کندهار پوهنتون غوښتنلیک ته ښه راغلاست',
      'our_services': 'زموږ خدماتو',
      'more_info': 'نور معلومات',
      'app_title': 'د کندهار پوهنتون لارښود',

      // University Info
      'university_history': 'د پوهنتون پېښلیک',
      'university_vision': 'د پوهنتون لیدلوری',
      'university_mission': 'د پوهنتون دنده',
      'university_objectives': 'د پوهنتون موخې',
      'university_facilities': 'د پوهنتون اسانتیاوې',

      // Riyasat Qadari
      'riyasat_qadari': 'اداری واحدونه',
      'kandahar_university': 'د کندهار پوهنتون',
      'university_administration': 'د پوهنتون اداره',
      'riyasat_qadari_title': 'اداری واحدونه',

      // Directorate Screen
      'directorate_title': 'اداري ریاستونه',
      'no_administration_data': 'د اداري ریاستونو ډاټا شتون نلري',
      'administration_error': 'خرابي',
      'retry_button': 'بیا هڅه وکړئ',
      'view_details': 'تفصیلات وګورئ',
      'director_label': 'ریس',
      'no_director': 'ریس نشته',
      'no_name': 'نوم نشته',
      'no_information': 'معلومات نشته',

      // Administration Detail Screen
      'general_information': 'عمومي معلومات',

      'goals': 'اهداف',
      'establishment_year': 'د تاسیس کال',
      'innovative_projects': 'نوښتګر پروژې',
      'international_relations': 'نړیوال اړیکې',
      'quality_enhancement': 'د کیفیت ښه والی',
      'additional_information': 'اضافي معلومات',
      'administration_directorate': 'اداري ریاست',

      // Additional localization for administrative unit model
      'no_contact_info': 'د تماس معلومات نشته',
      'no_vision': 'لرلید نشته',
      'no_mission': 'رسالت نشته',
      'no_goals': 'اهداف نشته',
      'no_description': 'تشریح نشته',
      'loading_data': 'ډاټا پورته کیږي...',
      'banner_section': 'د بینر برخه',
      'banner_description': 'دا د بینر برخه ده چې د اداري ریاست د معلوماتو څخه وروسته ښودل کیږي',
      'image_not_available': 'انځور شتون نلري',
      'image_viewer_instructions': 'د لویولو لپاره ګوتې وکاروئ • د حرکت لپاره یې راښکته کړئ • د وتلو لپاره د تړلو تڼۍ ټک کړئ',

      // Teacher Profile Screen
      'teacher_data_error': 'د استاد د معلوماتو په لوستلو کې ستونزه رامنځته شوه',
      'loading_teacher_data': 'د استاد معلومات پورته کیږي...',
      'teacher_not_found': 'استاد ونه موندل شو',
      'academic_rank': 'علمي رتبه',

      // Error Messages
      'teachers_fetch_error': 'د ښوونکو د معلوماتو په ترلاسه کولو کې ستونزه.',
      'no_teachers_found_error': 'هیڅ ښوونکی ونه موندل شو.',
      'departments_fetch_error': 'د څانګو د معلوماتو په ترلاسه کولو کې ستونزه.',
      'no_departments_found': 'هیڅ څانګه ونه موندل شوه.',
      'faculties_fetch_error': 'د پوهنځیو د معلوماتو په ترلاسه کولو کې ستونزه.',
      'no_faculties_found': 'هیڅ پوهنځی ونه موندل شو.',
      'subjects_fetch_error': 'د مضامینو د معلوماتو په ترلاسه کولو کې ستونزه.',
      'no_subjects_found_error': 'هیڅ مضمون ونه موندل شو.',
      'semesters_fetch_error':
          'د شپږمیاشتنیو د معلوماتو په ترلاسه کولو کې ستونزه.',
      'no_semesters_found': 'هیڅ شپږمیاشتنۍ ونه موندل شوه.',
      'gallery_fetch_error': 'د انځورتون په ترلاسه کولو کې ستونزه.',
      'no_gallery_found': 'هیڅ انځورتون ونه موندل شو.',
      'data_fetch_error': 'د معلوماتو په ترلاسه کولو کې ستونزه.',
      'connection_error': 'د انټرنیټ اتصال کې ستونزه.',
      'try_again': 'بیا هڅه وکړئ',

      // Curriculum Screen
      'curriculum_fetch_error': 'د نصاب د معلوماتو په لوستلو کې ستونزه رامنځته شوه',
      'loading_curriculum': 'د نصاب معلومات پورته کیږي...',
      'no_curriculum_found': 'هیڅ نصاب ونه موندل شو',
      'theory_hours': 'نظري ساعتونه',
      'practical_hours': 'عملي ساعتونه',
      'total_hours': 'ټول ساعتونه',

      // Faculty History
      'faculty_history_title': 'د پوهنځي پېښلیک',
      'department_title': 'څانګه',
      'teachers_title': 'ښوونکي',
      'students_title': 'زده کړیالان',
      'staff_title': 'کارکوونکي',
      'courses_title': 'کورسونه',
      'laboratories_title': 'لابراتوارونه',

      // Navigation and UI
      'go_back': 'شاته ولاړ شه',
      'continue': 'دوام ورکړه',
      'submit': 'وسپاره',
      'reset': 'بیا تنظیم کړه',
      'clear': 'پاک کړه',
      'apply': 'پلي کړه',
      'filter': 'فلټر',
      'sort': 'ترتیب',
      'view_all': 'ټول وګوره',

      'show_more': 'نور وښایه',
      'show_less': 'لږ وښایه',

      // Settings and About Dialog
      'settings_coming_soon': 'د تنظیماتو برخه په راتلونکي کې اضافه کیږي.',
      'about_app_description':
          'د کندهار پوهنتون لارښود اپلیکیشن\nنسخه: ۱.۰.۰\nجوړونکی: د کندهار پوهنتون ټیم',
      'version': 'نسخه',
      'developed_by': 'جوړونکی',
      'kandahar_university_team': 'د کندهار پوهنتون ټیم',
      'contact_us': 'زموږ سره اړیکه ونیسئ',

      // Profile Menu
      'notifications': 'خبرتیاوې',
      'reviews': 'بیاکتنې',
      'payments': 'تادیات',
      'no_notifications': 'هیڅ خبرتیا نشته.',
      'no_reviews': 'هیڅ بیاکتنه نشته.',
      'no_payments': 'هیڅ تادیه نشته.',

      // Contact Information
      'address': 'پته',
      'website': 'ویب پاڼه',
      'university_address': 'د کندهار ښار، افغانستان',
      'university_website': 'www.kdru.edu.af',
      'default_phone': '+۹۳ ۷۰۰۴۵۰۴۰۲',
      'default_email': 'info@kdru.edu.af',

      // Common
      'unknown': 'نامعلوم',
      'guest_user': 'میلمه کارونکی',
      'information': 'معلومات',
      'university_dean': 'د پوهنتون ریس',
      'chancellor_message': 'د ریس پیغام',
      'university_information': 'د پوهنتون معلومات',
      'committees': 'کمیټې',
      'no_committees_available': 'هیڅ کمیټې شتون نلري',
      'committee_head': 'د کمیټې مشر',
      'committee_members': 'د کمیټې غړي',
      'committee_description': 'د کمیټې تشریح',
      'no_prerequisites_available': 'هیڅ اړتیاوې شتون نلري',
      'active_committee': 'فعاله کمیټه',
      'inactive_committee': 'غیر فعاله کمیټه',
    },
  };
}
