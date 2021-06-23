import 'package:flutter/foundation.dart';
import 'package:post/author.dart';
import 'package:post/post_comment.dart';

class TopPostData{
  List<PostData> postdata;
  TopPostData({this.postdata});
  factory TopPostData.fromJson(Map<String, dynamic> json) =>
      TopPostData(postdata: json["postdata"].length!=0?List<PostData>.from(json["postdata"].map((x) => PostData.fromJson(x))):[PostData()],);

}

class PostData {
  String id;
  String title;
  String body;
  bool published;
  Author author;
  List<PostComment> comment;

  PostData.fromJson(Map<String, dynamic> data) {
    this.id = data['id'];
    this.title = data['title'];
    this.body = data['body'];
    this.published = data['published'];
    this.author =
    (data['author'] != null ? Author.fromJson(data['author']) : null);
    this.comment = (data['comments'] as List)
        ?.map((e) => new PostComment.fromJson(e))
        ?.toList();
  }
}