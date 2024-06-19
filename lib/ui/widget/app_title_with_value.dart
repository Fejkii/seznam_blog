import 'package:flutter/material.dart';
import 'package:seznam_blog/ui/widget/app_text.dart';

class AppTitleWithValue extends StatelessWidget {
  final String title;
  final String value;

  const AppTitleWithValue({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "$title:",
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(width: 20),
        AppText(text: value),
      ],
    );
  }
}
