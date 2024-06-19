import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seznam_blog/bloc/comment_bloc.dart';
import 'package:seznam_blog/model/comment_model.dart';
import 'package:seznam_blog/ui/widget/app_loading_indicator.dart';
import 'package:seznam_blog/ui/widget/app_scaffold.dart';
import 'package:seznam_blog/ui/widget/app_text_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:seznam_blog/ui/widget/app_toast_message.dart';

class CommentDetailPage extends StatefulWidget {
  final int postId;
  final CommentModel? commentModel;

  const CommentDetailPage({
    super.key,
    required this.commentModel,
    required this.postId,
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
      appBar: _appBar(context),
      body: _body(),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      title: commentModel != null ? Text(commentModel!.name) : Text(AppLocalizations.of(context)!.newComment),
      actions: [
        BlocConsumer<CommentBloc, CommentState>(
          listener: (context, state) {
            if (state is CommentCreatedSuccessState) {
              AppToastMessage().showToastMsg(AppLocalizations.of(context)!.commentCreated, ToastState.success);
              Navigator.pop(context);
            } else if (state is CommentFailureState) {
              AppToastMessage().showToastMsg(state.errorMessage, ToastState.error);
            }
          },
          builder: (context, state) {
            if (state is CommentLoadingState) {
              return const AppLoadingIndicator();
            } else {
              if (commentModel == null) {
                return IconButton(
                  onPressed: () {
                    _onSave();
                  },
                  icon: const Icon(Icons.save),
                );
              }
              return Container();
            }
          },
        ),
      ],
    );
  }

  void _onSave() {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<CommentBloc>(context).add(
        PostNewCommentEvent(
          commentModel: CommentModel(
            postId: widget.postId,
            name: _nameController.text,
            email: _emailController.text,
            body: _bodyController.text,
            id: 0,
          ),
        ),
      );
    }
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
