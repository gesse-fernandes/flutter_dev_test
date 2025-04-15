import 'package:flutter/material.dart';
import 'package:flutter_dev_test/app.dart';
import 'package:flutter_dev_test/injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initializeApp();
  runApp(const MyApp());
}

Future<void> _initializeApp() async {
  init();
}
