import 'package:seznam_blog/api/api_config.dart';
import 'package:seznam_blog/api/api_factory.dart';
import 'package:seznam_blog/api/api_result_handler.dart';
import 'package:seznam_blog/app/dependency_injection.dart';

class ImageRepository {
  Future<ApiResultHandler> getImageList() async {
    return instance<ApiFactory>().getMethod(endpoint: "${ApiConfig.IMAGE_ROUTE}?_limit=10");
  }
}