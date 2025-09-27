import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:writer/data/models/note.dart';

class NoteTile extends StatelessWidget {
  final Note note;
  final void Function()? onTap;

  const NoteTile({super.key, required this.note, this.onTap});

  String formatDateTime(DateTime dt) {
    final time = DateFormat.Hm().format(dt); // 22:30
    final day = DateFormat('d').format(dt); // 17
    final suffix = _daySuffix(dt.day); // th
    final month = DateFormat('MMM').format(dt); // Feb
    return '$time @$day$suffix $month';
  }

  String _daySuffix(int day) {
    if (day >= 11 && day <= 13) return 'th';
    switch (day % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: double.infinity,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        note.title,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        note.content,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: Text(
                    formatDateTime(note.updatedAt),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                )
              ],
            )
          ),
        ),
      ),
    );
  }
}