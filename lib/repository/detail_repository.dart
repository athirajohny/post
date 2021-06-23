
import 'package:post/utility/api_provider.dart';

class DetailRepository {
  ApiProvider _apiProvider = ApiProvider();

  fetchPostData(){
    return _apiProvider.fetchPostData();
  }
}