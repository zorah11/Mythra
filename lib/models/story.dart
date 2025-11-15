import 'dart:convert';

class Story {
  final String id;
  final String title;
  final String tribe;
  final String tribeName;
  final String shortDescription;
  final String fullText;
  final String image;
  final String thumbnail;
  final List<String> keywords;
  final String? ageRange;
  final int? readingTimeMins;
  final int? order;

  Story({
    required this.id,
    required this.title,
    required this.tribe,
    required this.tribeName,
    required this.shortDescription,
    required this.fullText,
    required this.image,
    required this.thumbnail,
    required this.keywords,
    this.ageRange,
    this.readingTimeMins,
    this.order,
  });

  factory Story.fromJson(Map<String, dynamic> json) => Story(
    id: json['id'] ?? '',
    title: json['title'] ?? '',
    tribe: json['tribe'] ?? '',
    tribeName: json['tribeName'] ?? '',
    shortDescription: json['shortDescription'] ?? '',
    fullText: json['fullText'] ?? '',
    image: json['image'] ?? '',
    thumbnail: json['thumbnail'] ?? '',
    keywords:
        (json['keywords'] as List<dynamic>?)
            ?.map((e) => e.toString())
            .toList() ??
        [],
    ageRange: json['ageRange'],
    readingTimeMins: json['readingTimeMins'] == null
        ? null
        : int.tryParse(json['readingTimeMins'].toString()),
    order: json['order'] == null
        ? null
        : int.tryParse(json['order'].toString()),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'tribe': tribe,
    'tribeName': tribeName,
    'shortDescription': shortDescription,
    'fullText': fullText,
    'image': image,
    'thumbnail': thumbnail,
    'keywords': keywords,
    'ageRange': ageRange,
    'readingTimeMins': readingTimeMins,
    'order': order,
  };

  @override
  String toString() => jsonEncode(toJson());
}
