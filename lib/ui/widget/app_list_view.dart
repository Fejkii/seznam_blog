import 'package:flutter/material.dart';
import 'package:seznam_blog/constant/app_colors.dart';
import 'package:seznam_blog/ui/widget/app_title_text.dart';

class AppListView extends StatelessWidget {
  final String? title;
  final List listData;
  final IndexedWidgetBuilder itemBuilder;

  const AppListView({
    super.key,
    this.title,
    required this.listData,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (title != null)
          Text(
            title!,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        if (title != null) const SizedBox(height: 4),
        listData.isNotEmpty
            ? ListView.builder(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: listData.length,
                itemBuilder: itemBuilder,
              )
            : const Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 15),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.search_off, size: 30),
                    ),
                    AppTitleText(text: "Žádná data"),
                  ],
                ),
              ),
      ],
    );
  }
}

class AppListViewItem extends StatelessWidget {
  final Widget itemBody;
  final Function()? onTap;

  const AppListViewItem({
    super.key,
    required this.itemBody,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 0,
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
          side: BorderSide(color: AppColors.grey, width: 0.5),
        ),
        child: Center(
          heightFactor: 2.5,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: itemBody,
          ),
        ),
      ),
    );
  }
}
