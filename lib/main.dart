import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:seznam_blog/app/dependency_injection.dart';
import 'package:seznam_blog/bloc/comment_bloc.dart';
import 'package:seznam_blog/bloc/post_bloc.dart';
import 'package:seznam_blog/constant/app_colors.dart';
import 'package:seznam_blog/constant/app_hive.dart';
import 'package:seznam_blog/model/comment_model.dart';
import 'package:seznam_blog/ui/home/home.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(CommentModelAdapter());
  await Hive.openBox(AppHive.hiveBox);

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
        BlocProvider<CommentBloc>(create: (context) => instance<CommentBloc>()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
          useMaterial3: true,
        ),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const HomePage(),
      ),
    );
  }
}
