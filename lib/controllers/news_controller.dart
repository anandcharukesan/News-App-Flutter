class NewsController {
  final String? title;
  final String? description;
  final String? img;

  NewsController({
    this.title,
    this.description,
    this.img,
  });

  factory NewsController.fromJson(Map<String, dynamic> json) {
    return NewsController(
      title: json['title'],
      description: json['description'],
      img: json['urlToImage'],
    );
  }
}
