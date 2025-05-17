import 'package:flutter/material.dart';
import 'package:teste_mundo_wap/app/core/ui/styles/text_styles.dart';

class TodoCard extends StatefulWidget {
  final String title;
  final String description;
  final bool done;
  final Function() onSelect;
  final Function() onDelete;

  const TodoCard({
    super.key,
    required this.title,
    required this.description,
    this.done = false,
    required this.onSelect,
    required this.onDelete,
  });

  @override
  State<TodoCard> createState() => _TodoCardState();
}

class _TodoCardState extends State<TodoCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onSelect,
      child: Card(
        color: Colors.white,
        elevation: 0.0,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              color: Colors.grey.shade600,
              onPressed: widget.onDelete,
              icon: Icon(Icons.cancel_outlined),
            ),
            Expanded(
              flex: 10,
              child: content(widget.title, widget.description),
            ),
            Checkbox(
              value: false,
              onChanged: (value) => widget.onSelect(),
              side: const BorderSide(color: Colors.grey, width: 2),
            ),
          ],
        ),
      ),
    );
  }

  Widget content(String title, String description) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: context.textStyles.textBold.copyWith(
              fontSize: 20,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text(
            description,
            style: context.textStyles.textMedium.copyWith(
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
}
