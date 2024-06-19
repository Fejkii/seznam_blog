import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seznam_blog/app/dependency_injection.dart';
import 'package:seznam_blog/bloc/post_bloc.dart';
import 'package:seznam_blog/constant/app_colors.dart';
import 'package:seznam_blog/ui/post/post_list_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  await initAppDependences();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PostBloc>(create: (context) => instance<PostBloc>()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
          useMaterial3: true,
        ),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const PostListPage(),
      ),
    );
  }
}
