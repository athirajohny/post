import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:post/post.dart';
import 'package:post/author.dart';
import 'package:post/post_comment.dart';
import 'package:post/view/post_detail.dart';
import 'package:post/view_model/main_view_model.dart';


class Main extends StatefulWidget {
  const Main({Key key}) : super(key: key);

  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
//   String postsQuery = """
// query{
//   posts{
//     id
//     title
//     body
//     published
//   }
// }
// """;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Posts'),
        centerTitle: true,
      ),
      body: postList(),

    );
  }
}

postList() {
  return Consumer<MainViewModel>(
      builder: (BuildContext context, value, Widget child) {
        if(value.status == "loading"){
          Provider.of<MainViewModel>(context,listen:false).fetchPost();

          return Container(
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
                    itemCount: value.TopPostData.postdata.length,
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
        }
  }

}


