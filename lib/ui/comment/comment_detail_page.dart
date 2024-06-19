import 'package:flutter/material.dart';
import 'package:seznam_blog/model/comment_model.dart';
import 'package:seznam_blog/ui/widget/app_scaffold.dart';
import 'package:seznam_blog/ui/widget/app_text_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CommentDetailPage extends StatefulWidget {
  final CommentModel? commentModel;

  const CommentDetailPage({
    super.key,
    required this.commentModel,
  });

  @override
  State<CommentDetailPage> createState() => _CommentDetailPageState();
}

class _CommentDetailPageState extends State<CommentDetailPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  late CommentModel? commentModel;

  @override
  void initState() {
    if (widget.commentModel != null) {
      commentModel = widget.commentModel;
      _nameController.text = commentModel!.name;
      _emailController.text = commentModel!.email;
      _bodyController.text = commentModel!.body;
    } else {
      commentModel = null;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        title: commentModel != null ? Text(commentModel!.name) : Text(AppLocalizations.of(context)!.newComment),
        actions: [
          IconButton(
            onPressed: () {
              // TODO:
            },
            icon: const Icon(Icons.save),
          )
        ],
      ),
      body: _body(),
    );
  }

  Form _body() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          AppTextField(
            controller: _nameController,
            label: AppLocalizations.of(context)!.name,
            inputType: InputType.title,
            isRequired: true,
          ),
          const SizedBox(height: 20),
          AppTextField(
            controller: _emailController,
            label: AppLocalizations.of(context)!.email,
            inputType: InputType.email,
            keyboardType: TextInputType.emailAddress,
            isRequired: true,
          ),
          const SizedBox(height: 20),
          AppTextField(
            controller: _bodyController,
            label: AppLocalizations.of(context)!.body,
            isRequired: true,
          ),
        ],
      ),
    );
  }
}
