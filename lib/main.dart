import 'package:flutter/material.dart';
import 'package:restful_example/src/app.dart';

import 'src/start_app/start_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  StartApp.onAppStart();

  runApp(const MyApp());
}
