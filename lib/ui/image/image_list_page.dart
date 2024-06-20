import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seznam_blog/bloc/image_bloc.dart';
import 'package:seznam_blog/model/image_model.dart';
import 'package:seznam_blog/ui/widget/app_list_view.dart';
import 'package:seznam_blog/ui/widget/app_loading_indicator.dart';
import 'package:seznam_blog/ui/widget/app_scaffold.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:seznam_blog/ui/widget/app_toast_message.dart';

class ImageListPage extends StatefulWidget {
  const ImageListPage({super.key});

  @override
  State<ImageListPage> createState() => _ImageListPageState();
}

class _ImageListPageState extends State<ImageListPage> {
  late List<ImageModel> imageList = [];

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.imageListPage),
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return BlocProvider(
      create: (context) => ImageBloc()..add(GetImageListEvent()),
      child: BlocConsumer<ImageBloc, ImageState>(
        builder: (context, state) {
          if (state is ImageLoadingState) {
            return const AppLoadingIndicator();
          } else {
            return AppListView(listData: imageList, itemBuilder: _itemBuilder);
          }
        },
        listener: (context, state) {
          if (state is ImageListSuccessState) {
            setState(() {
              imageList = state.imageList;
            });
          } else if (state is ImageFailureState) {
            AppToastMessage().showToastMsg(state.errorMessage, ToastState.error);
          }
        },
      ),
    );
  }

  Widget _itemBuilder(BuildContext context, int index) {
    return AppListViewItem(
      itemBody: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(imageList[index].id.toString()),
          Text(imageList[index].thumbnailUrl),
          CachedNetworkImage(
            imageUrl: imageList[index].thumbnailUrl,
            placeholder: (context, url) => const AppLoadingIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.image_not_supported_outlined),
          ),
        ],
      ),
    );
  }
}
