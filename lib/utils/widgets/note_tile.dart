import 'package:flutter/material.dart';
import 'package:writer/data/models/note.dart';
import 'package:writer/utils/helpers/helpers.dart';

class NoteTile extends StatelessWidget {
  final Note note;
  final int index;
  final void Function()? onTap;
  final void Function()? onLongPress;

  const NoteTile({
    super.key, 
    required this.note,
    required this.index, 
    this.onTap, 
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    
    final Widget content = Column(
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
        const SizedBox(height: 8,),
        Text(
          AppHelpers.formatDateTime(note.updatedAt),
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );

    return Card(
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: onTap,
              onLongPress: onLongPress,
              child: Container(
                color: Colors.transparent,
                padding: const EdgeInsets.all(16),
                child: content,
              ),
            ),
          ),
          ReorderableDragStartListener(
            index: index,
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.drag_handle_sharp),
            ),
          ),
        ],
      ),
    );
  }
}