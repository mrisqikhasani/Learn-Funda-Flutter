import 'package:flutter/material.dart';
import 'package:practice_class/providers/local_notification_providers.dart';
import 'package:practice_class/screen/detail_screen.dart';
import 'package:practice_class/screen/home_screen.dart';
import 'package:practice_class/services/HttpService.dart';
import 'package:practice_class/services/local_notification_service.dart';
import 'package:practice_class/static/my_route.dart';
import 'package:provider/provider.dart';

void main() async {
  String route = MyRoute.home.name;

  runApp(
  MultiProvider(
    providers: [
      Provider<HttpService>(
        create: (_) => HttpService(),
      ),

      Provider<LocalNotificationService>(
        create: (context) =>
            LocalNotificationService(
              context.read<HttpService>(),
            )..init()
            ..configureLocalTimeZone(),
      ),

      ChangeNotifierProvider<LocalNotificationProviders>(
        create: (context) => LocalNotificationProviders(
          context.read<LocalNotificationService>(),
        )..requestPermission(),
      ),
    ],
    child: App(initialRoute: route),
  ),
);

}

class App extends StatelessWidget {
  final String initialRoute;

  const App({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: initialRoute,
      routes: {
        MyRoute.home.name: (context) => const HomeScreen(),
        MyRoute.detail.name: (context) => const DetailScreen(),
      },
    );
  }
}
