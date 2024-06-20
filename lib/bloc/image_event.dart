part of 'image_bloc.dart';

@immutable
sealed class ImageEvent {}

class GetImageListEvent extends ImageEvent {}
