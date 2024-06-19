import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seznam_blog/bloc/comment_bloc.dart';
import 'package:seznam_blog/model/comment_model.dart';
import 'package:seznam_blog/ui/comment/comment_detail_page.dart';
import 'package:seznam_blog/ui/widget/app_list_view.dart';
import 'package:seznam_blog/ui/widget/app_loading_indicator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CommentListView extends StatefulWidget {
  final int postId;
  const CommentListView({
    super.key,
    required this.postId,
  });

  @override
  State<CommentListView> createState() => _CommentListViewState();
}

class _CommentListViewState extends State<CommentListView> {
  late List<CommentModel> commentList = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _addNewCommentWidget(),
        const SizedBox(height: 20),
        _commentListWidget(),
      ],
    );
  }

  Widget _addNewCommentWidget() {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const CommentDetailPage(commentModel: null),
          ),
        );
      },
      child: Text(AppLocalizations.of(context)!.addNewComment),
    );
  }

  Widget _commentListWidget() {
    return BlocProvider(
      create: (context) => CommentBloc()..add(GetCommentListByPostIdEvent(postId: widget.postId)),
      child: BlocConsumer<CommentBloc, CommentState>(
        builder: (context, state) {
          if (state is CommentLoadingState) {
            return const AppLoadingIndicator();
          } else {
            return AppListView(listData: commentList, itemBuilder: _itemBuilder);
          }
        },
        listener: (context, state) {
          if (state is CommentListSuccessState) {
            setState(() {
              commentList = state.commentList;
            });
          } else if (state is CommentFailureState) {
            print("ERROR: ${state.errorMessage}");
            // TODO: Toast Error
          }
        },
      ),
    );
  }

  Widget _itemBuilder(BuildContext context, int index) {
    return AppListViewItem(
      itemBody: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(commentList[index].email),
          Text(commentList[index].name),
        ],
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CommentDetailPage(commentModel: commentList[index]),
          ),
        );
      },
    );
  }
}
