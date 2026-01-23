import 'dart:async';

import 'package:flutter/material.dart';
import 'package:practice_class/data/api/api_services.dart';
import 'package:practice_class/data/model/tourism.dart';
import 'package:practice_class/data/model/tourism_detail_response.dart';
import 'package:practice_class/provider/detail/bookmark_icon_provider.dart';
import 'package:practice_class/screen/detail/body_of_detail_screen_widget.dart';
import 'package:practice_class/screen/detail/bookmart_icon_widget.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatefulWidget {
  final int tourismId;

  const DetailScreen({super.key, required this.tourismId});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final Completer<Tourism> _completerTourism = Completer<Tourism>();
  late Future<TourismDetailResponse> _futureTourismDetail;

  @override
  void initState() {
    super.initState();

    _futureTourismDetail = ApiServices().getTourismDetail(widget.tourismId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tourism Detail"),
        actions: [
          ChangeNotifierProvider(
            create: (context) => BookmarkIconProvider(),
            child: FutureBuilder(
              future: _completerTourism.future,
              builder: (context, snaphot) {
                return switch (snaphot.connectionState) {
                  ConnectionState.done => BookmartIconWidget(
                    tourism: snaphot.data!,
                  ),
                  _ => const SizedBox(),
                };
              },
            ),
          ),
        ],
      ),
      body: FutureBuilder(
        future: _futureTourismDetail,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(child: CircularProgressIndicator());
            case ConnectionState.done:
              if (snapshot.hasError) {
                return Center(child: Text(snapshot.error.toString()));
              }
              final tourismData = snapshot.data!.place;
              _completerTourism.complete(tourismData);
              return BodyOfDetailScreenWidget(tourism: tourismData);
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}
