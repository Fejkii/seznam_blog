import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seznam_blog/bloc/comment_bloc.dart';
import 'package:seznam_blog/model/comment_model.dart';
import 'package:seznam_blog/ui/comment/comment_detail_page.dart';
import 'package:seznam_blog/ui/widget/app_list_view.dart';
import 'package:seznam_blog/ui/widget/app_loading_indicator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:seznam_blog/ui/widget/app_toast_message.dart';

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
  late List<CommentModel> serverCommentList = [];
  late List<CommentModel> localCommentList = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _addNewCommentWidget(),
        const SizedBox(height: 20),
        _serverCommentListWidget(),
        const SizedBox(height: 20),
        _localCommentListWidget()
      ],
    );
  }

  void _getLocalComments() {
    BlocProvider.of<CommentBloc>(context).add(GetLocalCommentListByPostIdEvent(postId: widget.postId));
  }

  Widget _addNewCommentWidget() {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CommentDetailPage(postId: widget.postId, commentModel: null),
          ),
        ).then((value) => _getLocalComments());
      },
      child: Text(AppLocalizations.of(context)!.addNewComment),
    );
  }

  Widget _serverCommentListWidget() {
    return BlocProvider(
      create: (context) => CommentBloc()..add(GetServerCommentListByPostIdEvent(postId: widget.postId)),
      child: BlocConsumer<CommentBloc, CommentState>(
        builder: (context, state) {
          if (state is CommentLoadingState) {
            return const AppLoadingIndicator();
          } else {
            return AppListView(
              title: AppLocalizations.of(context)!.serverComments,
              listData: serverCommentList,
              itemBuilder: _serverItemBuilder,
            );
          }
        },
        listener: (context, state) {
          if (state is CommentListSuccessState) {
            setState(() {
              serverCommentList = state.commentList;
            });
          } else if (state is CommentFailureState) {
            AppToastMessage().showToastMsg(state.errorMessage, ToastState.error);
          }
        },
      ),
    );
  }

  Widget _localCommentListWidget() {
    return BlocProvider(
      create: (context) => CommentBloc()..add(GetLocalCommentListByPostIdEvent(postId: widget.postId)),
      child: BlocConsumer<CommentBloc, CommentState>(
        builder: (context, state) {
          if (state is CommentLoadingState) {
            return const AppLoadingIndicator();
          } else {
            return AppListView(
              title: AppLocalizations.of(context)!.localComments,
              listData: localCommentList,
              itemBuilder: _localItemBuilder,
            );
          }
        },
        listener: (context, state) {
          if (state is CommentListSuccessState) {
            setState(() {
              localCommentList = state.commentList;
            });
          } else if (state is CommentFailureState) {
            AppToastMessage().showToastMsg(state.errorMessage, ToastState.error);
          }
        },
      ),
    );
  }

  Widget _serverItemBuilder(BuildContext context, int index) {
    return AppListViewItem(
      itemBody: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(serverCommentList[index].email),
          Text(serverCommentList[index].name),
        ],
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CommentDetailPage(postId: widget.postId, commentModel: serverCommentList[index]),
          ),
        );
      },
    );
  }

  Widget _localItemBuilder(BuildContext context, int index) {
    return AppListViewItem(
      itemBody: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(localCommentList[index].email),
          Text(localCommentList[index].name),
        ],
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CommentDetailPage(postId: widget.postId, commentModel: localCommentList[index]),
          ),
        ).then((value) => _getLocalComments());
      },
    );
  }
}
