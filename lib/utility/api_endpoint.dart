class ApiEndpoint {
  String _graphQlUrl;

  ApiEndpoint(){
    //_endpoint = " ";
    _graphQlUrl = "https://graphql-demo.mead.io/ ";
  }
  String get graphQlUrl => _graphQlUrl;
}
ApiEndpoint apiEndpoint = ApiEndpoint();