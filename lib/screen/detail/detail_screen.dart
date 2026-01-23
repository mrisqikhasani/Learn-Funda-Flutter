import 'dart:async';

import 'package:flutter/material.dart';
import 'package:practice_class/data/api/api_services.dart';
import 'package:practice_class/data/model/tourism.dart';
import 'package:practice_class/data/model/tourism_detail_response.dart';
import 'package:practice_class/provider/detail/bookmark_icon_provider.dart';
import 'package:practice_class/provider/detail/tourism_detail_provider.dart';
import 'package:practice_class/screen/detail/body_of_detail_screen_widget.dart';
import 'package:practice_class/screen/detail/bookmart_icon_widget.dart';
import 'package:practice_class/static/tourism_detail_result.dart';
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

    // _futureTourismDetail = ApiServices().getTourismDetail(widget.tourismId);

    Future.microtask(() {
      context.read<TourismDetailProvider>().fetchTourismDetail(
        widget.tourismId,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tourism Detail"),
        actions: [
          ChangeNotifierProvider(
            create: (context) => BookmarkIconProvider(),
            child: Consumer<TourismDetailProvider>(
              // future: _completerTourism.future,
              builder: (context, value, child) {
                return switch (value.resultState) {
                  TourismDetailLoadedState(data: var tourism) =>
                    BookmartIconWidget(tourism: tourism),
                  _ => const SizedBox(),
                };
              },
            ),
          ),
        ],
      ),
      body: Consumer<TourismDetailProvider>(
        // future: _futureTourismDetail,
        builder: (context, value, child) {
          return switch (value.resultState) {
            TourismDetailLoadingState() => const Center(
              child: CircularProgressIndicator(),
            ),
            TourismDetailLoadedState(data: var tourism) =>
              BodyOfDetailScreenWidget(tourism: tourism),
            TourismDetailErrorState(error: var message) => Center(
              child: Text(message),
            ),
            _ => const SizedBox(),
          };
        },
      ),
    );
  }
}
