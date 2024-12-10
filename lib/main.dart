import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sum_app/firebase_options.dart';
import 'package:sum_app/live_score_screen.dart';

Future<void>main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(LiveScoreApp());

}

class LiveScoreApp extends StatelessWidget {
  const LiveScoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: LiveScoreScreen(),
    );
  }
}
