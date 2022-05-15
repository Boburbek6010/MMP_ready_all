
class Content{
  late String description;
  late String example;


  Content({required this.description,required this.example});

  Content.fromJson(Map<String, dynamic> json){
    description = json['description'];
    example = json['example'];
  }

  Map<String, dynamic> toJson() => {
    'description' : description,
    'example' : example,
  };

  @override
  String toString() {
    return 'Description: $description\nExample: $example';
  }

}