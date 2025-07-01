import 'package:json_annotation/json_annotation.dart';
import 'package:palmcode/features/home/domain/data/book.dart';

part 'get_books_response.g.dart';

@JsonSerializable()
class GetBooksResponse {
  final int? count;
  final String? next;
  final String? previous;
  final List<Book>? results;

  GetBooksResponse({this.count, this.next, this.previous, this.results});

  factory GetBooksResponse.fromJson(Map<String, dynamic> json) =>
      _$GetBooksResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetBooksResponseToJson(this);
}
