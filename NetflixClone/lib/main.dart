import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix/application/downloads/downloads_bloc.dart';
import 'package:netflix/application/fast_laugh/fast_laugh_bloc.dart';
import 'package:netflix/application/home/home_bloc.dart';
import 'package:netflix/application/hot_and_new/hotand_new_bloc.dart';
import 'package:netflix/application/search/search_bloc.dart';
import 'package:netflix/constants/colors/colors.dart';
import 'package:netflix/domain/core/dependency_injection/injectable.dart';
import 'package:netflix/presentation/mainpage/navigation_bar.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureInjection();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) {
          return getIt<DownloadsBloc>();
        }),
        BlocProvider(create: (context) {
          return getIt<SearchBloc>();
        }),
        BlocProvider(create: (context) {
          return getIt<FastLaughBloc>();
        }),
        BlocProvider(create: (context) {
          return getIt<HotandNewBloc>();
        }),
        BlocProvider(create: (context) {
          return getIt<HomeBloc>();
        }),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent),
          scaffoldBackgroundColor: bagroundColor,
          primarySwatch: Colors.blue,
          textTheme: const TextTheme(
            bodyText1: TextStyle(
              color: kwhite,
            ),
            bodyText2: TextStyle(
              color: kwhite,
            ),
          ),
        ),
        home: NavigatonBarScreen(),
      ),
    );
  }
}
