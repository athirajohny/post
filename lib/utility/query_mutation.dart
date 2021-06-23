class QueryMutation {

postsQuery(){
  return """ mutation postsQuery{
  posts{
    id
    title
    body
    published
  }
}
""";
}

post(){
  return """mutation post(\$id: ID!){
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
}


}