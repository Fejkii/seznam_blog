import 'package:seznam_blog/api/api_config.dart';
import 'package:seznam_blog/api/api_factory.dart';
import 'package:seznam_blog/api/api_result_handler.dart';
import 'package:seznam_blog/app/dependency_injection.dart';

class PostRepository {
  Future<ApiResultHandler> getPostList() async {
    return instance<ApiFactory>().getMethod(endpoint: ApiConfig.POST_ROUTE);
  }
}
