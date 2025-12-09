import 'package:json_annotation/json_annotation.dart';

part 'quote.g.dart';

@JsonSerializable()
class Quote {
  @JsonKey(name: 'q')
  final String text;
  
  @JsonKey(name: 'a')
  final String author;

  Quote({required this.text, required this.author});

  // Manual fromJSON for http package
  Quote.fromJSON(Map<String, dynamic> map)
      : text = map['q'] ?? '',
        author = map['a'] ?? '';

  // Generated methods for Retrofit/Dio
  factory Quote.fromJson(Map<String, dynamic> json) => _$QuoteFromJson(json);
  Map<String, dynamic> toJson() => _$QuoteToJson(this);
}
