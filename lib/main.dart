import 'package:flutter/material.dart';
import 'package:seznam_blog/constant/app_colors.dart';
import 'package:seznam_blog/ui/post/post_list_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
        useMaterial3: true,
      ),
      home: const PostListPage(),
    );
  }
}
