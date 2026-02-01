import 'package:flutter/material.dart';
import 'package:practice_class/provider/notification_state_provider.dart';
import 'package:practice_class/provider/shared_references_provider.dart';
import 'package:practice_class/screen/settting_page.dart';
import 'package:practice_class/services/shared_preferences_service.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => NotificationStateProvider(),
      ),
      Provider(create: (context) => SharedPreferencesService(prefs)
      ),
      ChangeNotifierProvider(create: (context) => SharedPreferencesProvider(
        context.read<SharedPreferencesService>(),
      ))
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SettingPage(),
    );
  }
}