import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tactix_academy_admin/app.dart';
import 'firebase_options.dart'; // Import the Firebase options

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase with platform-specific options
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}
