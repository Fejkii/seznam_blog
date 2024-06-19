import 'package:hive_flutter/hive_flutter.dart';
import 'package:seznam_blog/api/api_config.dart';
import 'package:seznam_blog/api/api_factory.dart';
import 'package:seznam_blog/api/api_result_handler.dart';
import 'package:seznam_blog/app/dependency_injection.dart';
import 'package:seznam_blog/constant/app_hive.dart';
import 'package:seznam_blog/model/comment_model.dart';

class CommentRepository {
  final _hiveBox = Hive.box(AppHive.hiveBox);

  Future<ApiResultHandler> getCommentListByPostId(int postId) async {
    return instance<ApiFactory>().getMethod(
      endpoint: ApiConfig.POST_ROUTE,
      identificator: postId,
      param: ApiConfig.COMMENT_ROUTE,
    );
  }

  Future saveLocalNewComment(CommentModel commentModel) async {
    _hiveBox.add(commentModel);
    commentModel.save();
  }

  Future<List<CommentModel>> getLocalCommentListByPostId(int postId) async {
    List<CommentModel> list = _hiveBox.values.cast<CommentModel>().toList();
    List<CommentModel> commentList = [];
    for (var element in list) {
      if (element.postId == postId) {
        commentList.add(element);
      }
    }
    return commentList;
  }
}
