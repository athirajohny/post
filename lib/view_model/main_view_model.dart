import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:post/repository/main_repository.dart';
import 'package:post/utility/query_mutation.dart';


import '../post.dart';

class MainViewModel with ChangeNotifier{

  QueryMutation addMutation = QueryMutation();
  int selectedTopIndex  = 0;
  String status = "loading";
  TopPostData _topPostData;
  final MainRepository mainRepository = MainRepository();
  TopPostData get topPostData {
    return _topPostData;

    fetchPost() async {
      var resultData = await mainRepository.fetchPost();
      status = resultData["status"];
      log(status);
      log(resultData["value"].toString());
      if(status=="completed"){
        _topPostData = TopPostData().fromJson(resultData["value"]);
      }
      notifyListeners();
    }

    selectTopIndex(index){
      selectedTopIndex  = index;
      notifyListeners();
    }

    changeStatus(statusData) {
      status = statusData;
      notifyListeners();
    }



}