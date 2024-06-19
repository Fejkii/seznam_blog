import 'package:flutter/material.dart';
import 'package:seznam_blog/constant/app_colors.dart';

class AppFloatingButton extends StatelessWidget {
  final dynamic Function() onPressed;
  const AppFloatingButton({
    super.key,
    required this.onPressed,
  });

  @override
  FloatingActionButton build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.white,
      onPressed: onPressed,
      child: const Icon(Icons.add),
    );
  }
}
