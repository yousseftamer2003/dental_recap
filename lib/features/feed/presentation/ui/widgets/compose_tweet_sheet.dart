import 'package:dental_recap/core/themes/app_colors.dart';
import 'package:flutter/material.dart';

class ComposeTweetSheet extends StatefulWidget {
  const ComposeTweetSheet({super.key});

  @override
  State<ComposeTweetSheet> createState() => _ComposeTweetSheetState();
}

class _ComposeTweetSheetState extends State<ComposeTweetSheet> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'What is happening?',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _controller,
            maxLines: 4,
            maxLength: 280,
            autofocus: true,
            decoration: const InputDecoration(
              hintText: 'Write a tweet...',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(_controller.text.trim());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.mainBlue,
              ),
              child: const Text(
                'Post',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
