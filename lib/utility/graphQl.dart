import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:post/utility/api_endpoint.dart';

class GraphQLConfiguration{
  HttpLink httpLink = HttpLink((ApiEndpoint()).graphQlUrl,);

  ValueNotifier<GraphQLClient> initializeClient(){
    ValueNotifier<GraphQLClient> client = ValueNotifier(
      GraphQLClient(
        cache: GraphQLCache(store: HiveStore()),
        link: httpLink,
      ),
    );
    return client;
  }

  GraphQLClient clientToQuery(){
    return GraphQLClient(link: httpLink,
        cache: GraphQLCache(store: HiveStore()),
    );
  }

}