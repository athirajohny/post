import 'package:flutter/material.dart';
import 'package:post/utility/query_mutation.dart';

class DetailViewModel with ChangeNotifier{

  QueryMutation addMutation = QueryMutation();
  int selectedTopIndex  = 0;
  String status = "loading";


}