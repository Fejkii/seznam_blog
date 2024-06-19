import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seznam_blog/api/api_result_handler.dart';
import 'package:seznam_blog/model/post_model.dart';
import 'package:seznam_blog/repository/post_repository.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository postRepository = PostRepository();

  PostBloc() : super(PostInitial()) {
    on<GetPostListEvent>((event, emit) async {
      emit(PostLoadingState());

      try {
        ApiResultHandler apiResultHandler = await postRepository.getPostList();

        if (apiResultHandler is ApiSuccess) {
          List<PostModel> postList = [];
          (jsonDecode(json.encode(apiResultHandler.data))).forEach((element) {
            postList.add(PostModel.fromMap(element));
          });
          emit(PostListSuccessState(postList: postList));
        } else if (apiResultHandler is ApiFailure) {
          emit(PostFailureState(errorMessage: apiResultHandler.message));
        }
      } catch (e) {
        emit(PostFailureState(errorMessage: e.toString()));
      }
    });
  }
}
