# 📅 Meeting Room Booking App

A Flutter application that allows users to browse meeting rooms and create bookings with time validation.

---

## 🚀 Overview

This project was built as part of a Flutter technical task.  
It demonstrates:

- Clean architecture & project structure
- API integration
- State management using BLoC
- Form validation and business logic
- Cross-platform support (Mobile & Web)

---

## 🛠 How to Run the Project

### 1. Clone the repository
git clone <https://github.com/khaledkhalifa74/meeting_room_booking_application>
cd meeting_room_booking_application

### 2. Install dependencies
flutter pub get

### 3. Run on Mobile
flutter run

### 4. Run on Web
flutter run -d chrome

### 5. Build for Web (Production)
flutter build web

The output will be available in:
build/web

---

## 📦 Libraries Used

- flutter_bloc → State management
- dio → API requests
- skeletonizer → Loading UI (skeleton screens)
- intl → Date & time formatting
- flutter_screenutil → Responsive UI

---

## 🧠 Technical Decisions

### 1. State Management (BLoC)
- Chosen for scalability and clear separation of concerns
- Handles:
  - Loading states
  - Error states
  - Success states
  - Side effects (booking creation)

---

### 2. Clean Architecture
Project is structured into layers:

features/
booking/
data/
presentation/
domain (if needed)

- Separation between UI and data logic
- Improves maintainability and testability

---

### 3. API Handling
- Used Dio for network calls
- Centralized API service
- Error handling for:
  - Network issues
  - Server errors

---

### 4. Booking Conflict Validation
- Implemented custom logic to prevent overlapping bookings
- Converts time into minutes for accurate comparison

---

### 5. Responsive & Cross-Platform Support
- App works on:
  - Mobile
  - Web
- Fixed web scrolling issues using custom ScrollBehavior

---

### 6. UI/UX Enhancements
- Skeleton loading for better UX
- Custom error & empty states
- Form validation with user-friendly messages

---

## ⏱ Time Spent

Approximately 3–4 hours:
- UI & Layout → ~1.5 hours
- API Integration → ~1 hour
- State Management → ~1 hour
- Validation & Edge Cases → ~30–45 minutes

---

## 📂 Features Implemented

✅ Rooms List  
✅ Booking Screen  
✅ Existing Bookings  
✅ Booking Validation (conflict detection)  
✅ Loading & Error handling  
✅ Web support

---

## 📦 Deliverables

### Option 1: APK (Recommended)
You can download the ready-to-install APK from the link below:

👉 [Download APK](https://drive.google.com/file/d/1IKE0wcMp5FcBMVC1cwVXB8-YzZMsjecD/view?usp=sharing)

Or generate it manually using:
flutter build apk

---

### Option 2: Web Build (Optional)
The production-ready web build can be generated using:
flutter build web

The output will be available in:
build/web

You can deploy it to:
- Firebase Hosting
- Netlify
- Vercel

---

## 📌 Notes

- Focused on clean, maintainable code
- Made reasonable assumptions where needed
- Prioritized functionality + UX over unnecessary complexity

---

## 👨‍💻 Author

Khaled Khalifa  
Flutter Developer