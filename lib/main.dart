import 'package:flutter/material.dart';
import 'package:practice_class/model/tourism.dart';
import 'package:practice_class/screen/detail/detail_screen.dart';
import 'package:practice_class/screen/main_screen.dart';
import 'package:practice_class/static/navigation_route.dart';
import 'package:practice_class/style/theme/tourism_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
 const MyApp({super.key});
 
 @override
 Widget build(BuildContext context) {
   return MaterialApp(
     title: 'Tourism App',
     theme: TourismTheme.lightTheme,
     darkTheme: TourismTheme.darkTheme,
     themeMode: ThemeMode.system,
     initialRoute: NavigationRoute.mainRoute.name,
     routes: {
       NavigationRoute.mainRoute.name: (context) => const MainScreen(),
       NavigationRoute.detailRoute.name: (context) => DetailScreen(
             tourism: ModalRoute.of(context)?.settings.arguments as Tourism,
           ),
     },
   );
 }
}
