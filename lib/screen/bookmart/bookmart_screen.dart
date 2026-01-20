import 'package:flutter/material.dart';
import 'package:practice_class/model/tourism.dart';
import 'package:practice_class/screen/home/tourism_card_widget.dart';
import 'package:practice_class/static/navigation_route.dart';

class BookmartScreen extends StatefulWidget {
  const BookmartScreen({super.key});

  @override
  State<BookmartScreen> createState() => _BookmartScreenState();
}

class _BookmartScreenState extends State<BookmartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Bookmart List")),
      body: ListView.builder(
        itemCount: bookmartTourismList.length,
        itemBuilder: (context, index) {
          final tourism = bookmartTourismList[index];

          return TourismCard(
            tourism: tourism,
            onTap: () {
              Navigator.pushNamed(
                context,
                NavigationRoute.detailRoute.name,
                arguments: tourism,
              );
              setState(() {
                
              });
            },
          );
        },
      ),
    );
  }
}
