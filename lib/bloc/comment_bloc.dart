import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:seznam_blog/api/api_result_handler.dart';
import 'package:seznam_blog/model/comment_model.dart';
import 'package:seznam_blog/repository/comment_repository.dart';

part 'comment_event.dart';
part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final CommentRepository commentRepository = CommentRepository();

  CommentBloc() : super(CommentInitial()) {
    on<GetCommentListByPostIdEvent>((event, emit) async {
      emit(CommentLoadingState());

      try {
        ApiResultHandler apiResultHandler = await commentRepository.getCommentListByPostId(event.postId);

        if (apiResultHandler is ApiSuccess) {
          List<CommentModel> commentList = [];
          (jsonDecode(json.encode(apiResultHandler.data))).forEach((element) {
            commentList.add(CommentModel.fromMap(element));
          });
          emit(CommentListSuccessState(commentList: commentList));
        } else if (apiResultHandler is ApiFailure) {
          emit(CommentFailureState(errorMessage: apiResultHandler.message));
        }
      } catch (e) {
        emit(CommentFailureState(errorMessage: e.toString()));
      }
    });

    on<PostNewCommentEvent>((event, emit) async {
      emit(CommentLoadingState());

      try {
        ApiResultHandler apiResultHandler = await commentRepository.postNewComment();

        if (apiResultHandler is ApiSuccess) {
          // TODO - save comment

          emit(CommentCreatedSuccessState());
        } else if (apiResultHandler is ApiFailure) {
          emit(CommentFailureState(errorMessage: apiResultHandler.message));
        }
      } catch (e) {
        emit(CommentFailureState(errorMessage: e.toString()));
      }
    });
  }
}
