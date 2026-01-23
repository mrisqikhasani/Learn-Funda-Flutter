import 'package:flutter/material.dart';
import 'package:practice_class/data/model/tourism.dart';
import 'package:practice_class/provider/detail/bookmark_icon_provider.dart';
import 'package:practice_class/provider/detail/bookmart_list_provider.dart';
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
    final bookmarkListProvider = context.read<BookmartListProvider>();
    final bookmarkIconProvider = context.read<BookmarkIconProvider>();

    Future.microtask(() {
      final tourismInList = bookmarkListProvider.checkItemBookmart(
        widget.tourism,
      );
      bookmarkIconProvider.isBookmarked = tourismInList;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        final bookmarkListProvider = context.read<BookmartListProvider>();
        final bookmarkIconProvider = context.read<BookmarkIconProvider>();
        final isBookmarked = bookmarkIconProvider.isBookmarked;

        if (!isBookmarked) {
          bookmarkListProvider.addBookmart(widget.tourism);
        } else {
          bookmarkListProvider.removeBookmart(widget.tourism);
        }
        bookmarkIconProvider.isBookmarked = !isBookmarked;
      },
      icon: Icon(
        context.watch<BookmarkIconProvider>().isBookmarked
            ? Icons.bookmark
            : Icons.bookmark_outline,
      ),
    );
  }
}
