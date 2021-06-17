class Author{
  String id;
  String name;
  String email;

  Author.fromJson(Map<String, dynamic>data){
    this.id = data['id'];
    this.name = data['name'];
    this.email = data['email'];
  }
}