
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:seznam_blog/api/api_result_handler.dart';
import 'package:seznam_blog/model/image_model.dart';
import 'package:seznam_blog/repository/image_repository.dart';

part 'image_event.dart';
part 'image_state.dart';

class ImageBloc extends Bloc<ImageEvent, ImageState> {
  ImageRepository imageRepository = ImageRepository();

  ImageBloc() : super(ImageInitial()) {
    on<GetImageListEvent>((event, emit) async {
      emit(ImageLoadingState());

      try {
        ApiResultHandler apiResultHandler = await imageRepository.getImageList();

        if (apiResultHandler is ApiSuccess) {
          List<ImageModel> postList = [];
          (jsonDecode(json.encode(apiResultHandler.data))).forEach((element) {
            postList.add(ImageModel.fromMap(element));
          });
          emit(ImageListSuccessState(imageList: postList));
        } else if (apiResultHandler is ApiFailure) {
          emit(ImageFailureState(errorMessage:  apiResultHandler.message));
        }
      } catch (e) {
        emit(ImageFailureState(errorMessage:  e.toString()));
      }
    });
  }
}
