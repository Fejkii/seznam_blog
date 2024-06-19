import 'package:flutter/material.dart';

import 'package:seznam_blog/model/post_model.dart';
import 'package:seznam_blog/ui/widget/app_scaffold.dart';
import 'package:seznam_blog/ui/widget/app_title_with_value.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
        AppTitleWithValue(title: AppLocalizations.of(context)!.title, value: postModel.title),
        AppTitleWithValue(title: AppLocalizations.of(context)!.body, value: postModel.body),
        AppTitleWithValue(title: AppLocalizations.of(context)!.id, value: postModel.id.toString()),
        AppTitleWithValue(title: AppLocalizations.of(context)!.userId, value: postModel.userId.toString()),
      ],
    );
  }
}
