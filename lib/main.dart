import 'package:Crew/providers/app_data_provider.dart';
import 'package:Crew/screens/00-Splash-Screen/splash_screen.dart';
import 'package:Crew/theme/default_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Crew',
        theme: defaultTheme,
        home: SplashScreen(),
      ),
    );
  }
}
