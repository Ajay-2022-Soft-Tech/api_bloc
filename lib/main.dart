import 'package:api_with_bloc/bloc/posts/posts_bloc.dart';
import 'package:api_with_bloc/ui/posts/post_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [

        BlocProvider(create: (_) => PostsBloc())
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          color: Colors.grey[400],

          theme: ThemeData(
          ),
          home: PostScreen(),

        //


      )

    );

  }
}


