import 'package:flutter/material.dart';
import 'package:writer/data/models/note.dart';
import 'package:writer/utils/helpers/helpers.dart';

class NoteTile extends StatelessWidget {
  final Note note;
  final void Function()? onTap;
  final void Function()? onLongPress;

  const NoteTile({super.key, required this.note, this.onTap, this.onLongPress});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
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
                    AppHelpers.formatDateTime(note.updatedAt),
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