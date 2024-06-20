part of 'image_bloc.dart';

@immutable
sealed class ImageState {}

final class ImageInitial extends ImageState {}

final class ImageLoadingState extends ImageState {}

final class ImageListSuccessState extends ImageState {
  final List<ImageModel> imageList;

  ImageListSuccessState({required this.imageList});
}

final class ImageFailureState extends ImageState {
  final String errorMessage;

  ImageFailureState({required this.errorMessage});
}
