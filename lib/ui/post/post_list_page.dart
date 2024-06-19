import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seznam_blog/bloc/post_bloc.dart';
import 'package:seznam_blog/model/post_model.dart';
import 'package:seznam_blog/ui/post/post_detail_page.dart';
import 'package:seznam_blog/ui/widget/app_list_view.dart';
import 'package:seznam_blog/ui/widget/app_loading_indicator.dart';
import 'package:seznam_blog/ui/widget/app_scaffold.dart';

class PostListPage extends StatefulWidget {
  const PostListPage({super.key});

  @override
  State<PostListPage> createState() => _PostListPageState();
}

class _PostListPageState extends State<PostListPage> {
  late List<PostModel> postList = [];

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        title: const Text("Post list page"),
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return BlocProvider(
      create: (context) => PostBloc()..add(GetPostListEvent()),
      child: BlocConsumer<PostBloc, PostState>(
        builder: (context, state) {
          if (state is PostLoadingState) {
            return const AppLoadingIndicator();
          } else {
            return AppListView(listData: postList, itemBuilder: _itemBuilder);
          }
        },
        listener: (context, state) {
          if (state is PostListSuccessState) {
            setState(() {
              postList = state.postList;
            });
          } else if (state is PostFailureState) {
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
          Text(postList[index].id.toString()),
          Text(
            postList[index].title,
          ),
        ],
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PostDetailPage(postModel: postList[index]),
          ),
        );
      },
    );
  }
}
