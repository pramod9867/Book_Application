import 'package:book_application/core/app_container.dart';
import 'package:book_application/presentation/bloc/bloc/book_bloc.dart';

import 'package:book_application/presentation/screens/base_screen/base_screen.dart';
import 'package:book_application/presentation/screens/base_screen/book_list_screen/book_list_screen.dart';
import 'package:book_application/presentation/screens/base_screen/favourite_screen/books_favourite_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppContainer.init();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<BookBloc>(create: (BuildContext context) => BookBloc()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Basic Book Application',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // TRY THIS: Try running your application with "flutter run". You'll see
          // the application has a purple toolbar. Then, without quitting the app,
          // try changing the seedColor in the colorScheme below to Colors.green
          // and then invoke "hot reload" (save your changes or press the "hot
          // reload" button in a Flutter-supported IDE, or press "r" if you used
          // the command line to start the app).
          //
          // Notice that the counter didn't reset back to zero; the application
          // state is not lost during the reload. To reset the state, use hot
          // restart instead.
          //
          // This works for code too, not just values: Most code changes can be
          // tested with just a hot reload.
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: SafeArea(
          child: BaseScreen(
            isFavScreen: true,
            baseWidget: BookListScreen(),
          ),
        ));
  }
}
