import 'package:flutter/material.dart';
import 'package:practice_class/model/tourism.dart';

class BookmartIconWidget extends StatefulWidget {
  final Tourism tourism;

  const BookmartIconWidget({super.key, required this.tourism});

  @override
  State<BookmartIconWidget> createState() => _BookmartIconWidgetState();
}

class _BookmartIconWidgetState extends State<BookmartIconWidget> {
  late bool _isBookmarked;

  @override
  void initState() {
    final tourismInList = bookmartTourismList.where(
      (element) => element.id == widget.tourism.id,
    );
    setState(() {
      if(tourismInList.isNotEmpty) {
        _isBookmarked = true;
      } else {
        _isBookmarked = false;
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        setState(() {
          if(_isBookmarked) {
            bookmartTourismList.removeWhere((element) => element.id == widget.tourism.id);
          } else {
            bookmartTourismList.add(widget.tourism);
          }
          _isBookmarked = !_isBookmarked;
        });
      },
      icon: Icon(
        _isBookmarked ? Icons.bookmark : Icons.bookmark_outline,
      ),
    );
  }
}
