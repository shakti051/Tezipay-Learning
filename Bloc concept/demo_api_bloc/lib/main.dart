import 'package:flutter/material.dart';
import 'features/posts/ui/posts_page.dart';


void main() async{ 
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false, 
      home: PostsPage(),
    );
  }
}
