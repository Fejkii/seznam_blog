import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:seznam_blog/ui/image/image_list_page.dart';
import 'package:seznam_blog/ui/post/post_list_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentPageIndex = 0;

  final List<Widget> _pages = [
    const PostListPage(),
    const ImageListPage(),
  ];

  void _onPageTap(int index) {
    setState(() {
      _currentPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentPageIndex,
        onTap: _onPageTap,
        items: [
          BottomNavigationBarItem(
            label: AppLocalizations.of(context)!.postListTitle,
            icon: const Icon(Icons.list_alt_sharp),
          ),
          BottomNavigationBarItem(
            label: AppLocalizations.of(context)!.imageListPage,
            icon: const Icon(Icons.image_outlined),
          ),
        ],
      ),
    );
  }
}
