import 'package:flutter/material.dart';
import 'package:practice_class/provider/bookmark/local_database_provider.dart';
import 'package:practice_class/screen/home/tourism_card_widget.dart';
import 'package:practice_class/static/navigation_route.dart';
import 'package:provider/provider.dart';

class BookmartScreen extends StatefulWidget {
  const BookmartScreen({super.key});

  @override
  State<BookmartScreen> createState() => _BookmartScreenState();
}

class _BookmartScreenState extends State<BookmartScreen> {

  @override
  void initState() {
    Future.microtask(() {
      context.read<LocalDatabaseProvider>().loadAllTourism();
    });

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Bookmart List")),
      body: Consumer<LocalDatabaseProvider>(
        builder: (context, value, child) {
          final bookmartList = value.tourismList ?? [];

          return switch (bookmartList.isNotEmpty) {
            true => ListView.builder(
              itemCount: bookmartList.length,
              itemBuilder: (context, index) {
                final tourism = bookmartList[index];
                return TourismCard(
                  tourism: tourism,
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      NavigationRoute.detailRoute.name,
                      arguments: tourism.id,
                    );
                    setState(() {});
                  },
                );
              },
            ),

            _ => const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("No Bookmarked"),
                ],
              ),
            )
          };
        },
      ),
    );
  }
}
