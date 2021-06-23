import 'package:post/utility/api_provider.dart';

class MainRepository {
  ApiProvider _apiProvider = ApiProvider();

  fetchPostData(){
    return _apiProvider.fetchPost();
  }
}