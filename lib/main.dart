import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:post/post.dart';
import 'package:post/author.dart';
import 'package:post/post_comment.dart';

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

class Main extends StatefulWidget {
  const Main({Key key}) : super(key: key);

  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  String postsQuery = """
query{
  posts{
    id
    title
    body
    published
  }
}
""";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Posts'),
        centerTitle: true,
      ),
      body: Container(
        child: Query(
          options:
          QueryOptions(
            document: gql(postsQuery),
            variables: {'nRepositories': 50,},
          ),

          builder: (QueryResult result,{ VoidCallback refetch,FetchMore fetchMore}){
            if (result.hasException) {
            return Text(result.exception.toString());
            }
            if (result.isLoading) {
            return Text('Loading');
            }

            //List<PostData> posts = result.data['posts'] ;
            List<PostData> posts = (result.data['posts'] as List)
            .map((e) => new PostData.fromJson(e)).toList();


            return ListView.builder(
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  final PostData post = posts[index];

                  return InkWell(
                    onTap: (){
                      Navigator.push(context, 
                          MaterialPageRoute(builder: (context) => PostDetail()),
                      );
                    },
                    child: Card(
                      child: ListTile(
                        leading: FlutterLogo(size: 56.0),
                        title: Text(post.title),
                        subtitle: Text(post.body),
                        trailing: Icon(Icons.more_vert),
                      ),
                    ),
                  );
                });
          }, //builder
        ),
      ),

    );
  }
}
class PostDetail extends StatefulWidget {
  final String id;
  const PostDetail({Key key,@required this.id}) : super(key: key);

  @override
  _PostDetailState createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  String postsQuery = """
query post(\$id: ID!){
  post(id: \$id){
    id
    title
    body
    published
    author{
      id
      name
      email
    }
    comments{
      text
      author{
        id
        name
      }
    }
  }
}
""";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Query(
          options: QueryOptions(document: gql(postsQuery),
          variables: {'id':widget.id}),
          builder: (QueryResult result,{ VoidCallback refetch, FetchMore fetchMore}){
            if(result.hasException){
              return Text(result.exception.toString());
            }
            if(result.isLoading){
              return Container(
                child: Center(child: CircularProgressIndicator(),),
              );
            }
            PostData post = PostData.fromJson(result.data['post']);
            return Scaffold(
              appBar: AppBar(
                title: Text(post.title),
                centerTitle: true,
              ),
              body: Center(
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text("${post.author.email}"),
                  ),
                ),
              ),
            );
          }),
    );
  }
}







