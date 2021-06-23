import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:post/utility/graphQl.dart';
import 'package:post/utility/query_mutation.dart';

class ApiProvider{
  QueryMutation addMutation = QueryMutation();


  Future<void> fetchPost() async {
    Map responseData;
    try {
      GraphQLConfiguration graphQLConfiguration1 = GraphQLConfiguration();
      GraphQLClient _client1 = graphQLConfiguration1.clientToQuery();
      var resultData = await _client1.mutate(MutationOptions(
        document: gql(addMutation.postsQuery()),
      ));
      if (resultData.hasException) {
        responseData = {"status": "error"};
      } else {
        if (resultData.data == null ||
            resultData.data["megamenu"].length == 0) {
          responseData = {"status": "empty"};
        } else {
          responseData = {
            "status": "completed",
            "value": resultData.data
          };
        }
      }
    } catch (e) {
      responseData = {"status": "error"};
      print(e);
    }
    return responseData;
  }

  Future<void> fetchPostData() async {
    Map responseData;
    try {
      GraphQLConfiguration graphQLConfiguration1 = GraphQLConfiguration();
      GraphQLClient _client1 = graphQLConfiguration1.clientToQuery();
      var resultData = await _client1.mutate(MutationOptions(
        document: gql(addMutation.post()),
      ));
      if (resultData.hasException) {
        responseData = {"status": "error"};
      } else {
        if (resultData.data == null ||
            resultData.data["megamenu"].length == 0) {
          responseData = {"status": "empty"};
        } else {
          responseData = {
            "status": "completed",
            "value": resultData.data
          };
        }
      }
    } catch (e) {
      responseData = {"status": "error"};
      print(e);
    }
    return responseData;
  }

}