import 'package:flutter/material.dart';
import 'package:practice_class/data/model/tourism.dart';
import 'package:practice_class/provider/bookmark/local_database_provider.dart';
import 'package:practice_class/provider/detail/bookmark_icon_provider.dart';
import 'package:provider/provider.dart';

class BookmartIconWidget extends StatefulWidget {
  final Tourism tourism;

  const BookmartIconWidget({super.key, required this.tourism});

  @override
  State<BookmartIconWidget> createState() => _BookmartIconWidgetState();
}

class _BookmartIconWidgetState extends State<BookmartIconWidget> {
  @override
  void initState() {
    final localDatabaseProvider = context.read<LocalDatabaseProvider>();
    final bookmarkIconProvider = context.read<BookmarkIconProvider>();

    Future.microtask(() async {
      await localDatabaseProvider.loadTourismById(widget.tourism.id);
      final value = localDatabaseProvider.checkItemBookmark(widget.tourism.id);

      bookmarkIconProvider.isBookmarked = value;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        final localDatabaseProvider = context.read<LocalDatabaseProvider>();
        final bookmarkIconProvider = context.read<BookmarkIconProvider>();
        final isBookmarked = bookmarkIconProvider.isBookmarked;

        if (!isBookmarked) {
          await localDatabaseProvider.saveTourism(widget.tourism);
        } else {
          await localDatabaseProvider.removeTourismById(widget.tourism.id);
        }
        bookmarkIconProvider.isBookmarked = !isBookmarked;
        localDatabaseProvider.loadAllTourism();
      },
      icon: Icon(
        context.watch<BookmarkIconProvider>().isBookmarked
            ? Icons.bookmark
            : Icons.bookmark_outline,
      ),
    );
  }
}
