import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:post/post.dart';
import 'package:post/author.dart';
import 'package:post/post_comment.dart';
import 'package:post/view/main.dart';
import 'package:post/view/post_detail.dart';

void main() async{
  await initHiveForFlutter();
  final HttpLink httpLink = HttpLink(
    'https://graphql-demo.mead.io/',
  );
  final Link link = httpLink;
  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      link: link,
      cache:GraphQLCache(store: HiveStore()),
    ),
  );

  runApp(
      GraphQLProvider(
        client: client,
        child: MyApp(),
      ));
}
class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Main(),
    );
  }
}









