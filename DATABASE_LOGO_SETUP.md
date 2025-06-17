# 📊 Database Logo Setup Guide

## 🎯 Overview
This guide explains how to add logo fields to your Firebase database for faculties, departments, teachers, and semesters.

## 📁 Firebase Storage Structure
First, organize your images in Firebase Storage:

```
/logos/
  /faculties/
    - computer_science_logo.jpg
    - engineering_logo.jpg
    - medicine_logo.jpg
  /departments/
    - cs_department_logo.jpg
    - software_engineering_logo.jpg
  /teachers/
    - teacher_001.jpg
    - teacher_002.jpg
  /semesters/
    - semester_1_icon.jpg
    - semester_2_icon.jpg
```

## 🔧 Database Structure Updates

### 1. Faculty Collection (Already has logo field)
```
Kandahar University/kdru/faculties/{facultyId}
{
  "name": "Computer Science Faculty",
  "logo": "https://firebasestorage.googleapis.com/.../faculties/computer_science_logo.jpg",
  "description": "Faculty description",
  "departments": 5,
  "staff": 25,
  "type": "academic"
}
```

### 2. Department Collection (Add logo field)
```
Kandahar University/kdru/faculties/{facultyId}/departments/{departmentId}
{
  "name": "Software Engineering",
  "logo": "https://firebasestorage.googleapis.com/.../departments/software_engineering_logo.jpg",
  "description": "Department description",
  "head": "Dr. Ahmad Ali",
  "teachersCount": 8,
  "semestersCount": 8,
  "establishedYear": "2010"
}
```

### 3. Teacher Collection (Add logo field)
```
Kandahar University/kdru/faculties/{facultyId}/departments/{departmentId}/teachers/{teacherId}
{
  "name": "Dr. Ahmad Ali",
  "logo": "https://firebasestorage.googleapis.com/.../teachers/teacher_001.jpg",
  "position": "Professor",
  "email": "ahmad@university.edu",
  "phone": "+93 700 123 456",
  "biography": "Experienced professor...",
  "education": "PhD in Computer Science",
  "specialization": "Machine Learning",
  "subjects": ["AI", "Machine Learning", "Data Science"],
  "officeHours": "Sunday-Thursday 10:00-12:00",
  "officeLocation": "Room 201, CS Building"
}
```

### 4. Semester Collection (Add logo field)
```
Kandahar University/kdru/faculties/{facultyId}/departments/{departmentId}/semesters/{semesterId}
{
  "name": "First Semester",
  "logo": "https://firebasestorage.googleapis.com/.../semesters/semester_1_icon.jpg",
  "semesterNumber": 1,
  "totalCredits": 18,
  "academicYear": "2024-2025",
  "isActive": true,
  "subjects": [
    {
      "id": "cs101",
      "name": "Introduction to Programming",
      "code": "CS-101",
      "credits": 3,
      "teacherId": "teacher_001",
      "teacherName": "Dr. Ahmad Ali",
      "description": "Basic programming concepts",
      "isRequired": true
    }
  ]
}
```

## 🚀 Implementation Steps

### Step 1: Upload Images to Firebase Storage
1. Go to Firebase Console → Storage
2. Create folder structure as shown above
3. Upload logo images for each entity
4. Copy the download URLs

### Step 2: Update Database Documents
For each collection, add the `logo` field with the Firebase Storage URL:

```javascript
// Example: Update a department document
db.collection('Kandahar University').doc('kdru')
  .collection('faculties').doc('faculty_id')
  .collection('departments').doc('department_id')
  .update({
    logo: 'https://firebasestorage.googleapis.com/.../department_logo.jpg'
  });
```

### Step 3: Batch Update Script (Optional)
You can create a script to batch update multiple documents:

```javascript
// Batch update example
const batch = db.batch();

// Update multiple departments
const departments = [
  { id: 'dept1', logo: 'url1' },
  { id: 'dept2', logo: 'url2' }
];

departments.forEach(dept => {
  const ref = db.collection('path').doc(dept.id);
  batch.update(ref, { logo: dept.logo });
});

batch.commit();
```

## 📱 App Integration

The app is already updated to use these logo fields:

1. **Faculty logos** - Used in CustomHeader
2. **Department logos** - Ready for department cards
3. **Teacher logos** - Ready for teacher profiles
4. **Semester logos** - Ready for semester displays

## 🔍 Testing

After updating the database:

1. **Test faculty screens** - Logo should appear in header
2. **Test department navigation** - Logos ready for display
3. **Test teacher profiles** - Photos ready for display
4. **Test semester views** - Icons ready for display

## 📝 Notes

- **Image sizes**: Recommended 200x200px for logos, 300x300px for teacher photos
- **Formats**: JPG, PNG, WebP supported
- **Naming**: Use descriptive names like `computer_science_logo.jpg`
- **Fallbacks**: App includes fallback images if logo URL is empty
- **Performance**: Images are cached automatically by the app
