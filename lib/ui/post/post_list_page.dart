import 'package:flutter/material.dart';
import 'package:seznam_blog/ui/widget/app_scaffold.dart';

class PostListPage extends StatefulWidget {
  const PostListPage({super.key});

  @override
  State<PostListPage> createState() => _PostListPageState();
}

class _PostListPageState extends State<PostListPage> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        title: const Text("Post list page"),
      ),
      body: const Text("content"),
    );
  }
}
