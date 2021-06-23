import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:post/post.dart';
import 'package:post/author.dart';
import 'package:post/post_comment.dart';

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