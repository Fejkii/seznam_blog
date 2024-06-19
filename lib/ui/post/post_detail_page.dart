import 'package:flutter/material.dart';

import 'package:seznam_blog/model/post_model.dart';
import 'package:seznam_blog/ui/widget/app_scaffold.dart';
import 'package:seznam_blog/ui/widget/app_title_with_value.dart';

class PostDetailPage extends StatefulWidget {
  final PostModel postModel;

  const PostDetailPage({
    super.key,
    required this.postModel,
  });

  @override
  State<PostDetailPage> createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {
  late PostModel postModel;

  @override
  void initState() {
    postModel = widget.postModel;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        title: Text(
          postModel.title,
        ),
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return Column(
      children: [
        AppTitleWithValue(title: "Title", value: postModel.title),
        AppTitleWithValue(title: "Body", value: postModel.body),
        AppTitleWithValue(title: "ID", value: postModel.id.toString()),
        AppTitleWithValue(title: "User ID", value: postModel.userId.toString()),
      ],
    );
  }
}
