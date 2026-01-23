import 'package:flutter/material.dart';
import 'package:practice_class/data/api/api_services.dart';
import 'package:practice_class/provider/detail/bookmart_list_provider.dart';
import 'package:practice_class/provider/detail/tourism_detail_provider.dart';
import 'package:practice_class/provider/home/tourism_list_provider.dart';
import 'package:practice_class/provider/main/index_nav_provider.dart';
import 'package:practice_class/screen/detail/detail_screen.dart';
import 'package:practice_class/screen/main_screen.dart';
import 'package:practice_class/static/navigation_route.dart';
import 'package:practice_class/style/theme/tourism_theme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => IndexNavProvider()),
        ChangeNotifierProvider(create: (context) => BookmartListProvider()),
        Provider(create: (context) => ApiServices()),
        ChangeNotifierProvider(
          create: (context) => TourismListProvider(context.read<ApiServices>()),
        ),
        ChangeNotifierProvider(
          create: (context) =>
              TourismDetailProvider(context.read<ApiServices>()),
        ),
      ],
      child: const MyApp(),
    ),
  );
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
          tourismId: ModalRoute.of(context)?.settings.arguments as int,
        ),
      },
    );
  }
}
