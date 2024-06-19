import 'package:get_it/get_it.dart';
import 'package:seznam_blog/api/api_factory.dart';
import 'package:seznam_blog/bloc/comment_bloc.dart';

final instance = GetIt.instance;

Future<void> initAppDependences() async {
  instance.registerLazySingleton<ApiFactory>(() => ApiFactory());
  instance.registerLazySingleton<CommentBloc>(() => CommentBloc());
}
