import 'package:seznam_blog/api/api_config.dart';
import 'package:seznam_blog/api/api_factory.dart';
import 'package:seznam_blog/api/api_result_handler.dart';
import 'package:seznam_blog/app/dependency_injection.dart';

class CommentRepository {
  Future<ApiResultHandler> getCommentListByPostId(int postId) async {
    return instance<ApiFactory>().getMethod(
      endpoint: ApiConfig.POST_ROUTE,
      identificator: postId,
      param: ApiConfig.COMMENT_ROUTE,
    );
  }

  Future<ApiResultHandler> postNewComment() async {
    // TODO - nebudu využívat api, ale Hive - locální DB

    return instance<ApiFactory>().postMethod(
      endpoint: ApiConfig.COMMENT_ROUTE,
    );
  }
}
