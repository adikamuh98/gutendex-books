import 'package:palmcode/features/home/domain/data/author.dart';
import 'package:palmcode/features/home/domain/data/format.dart';
import 'package:json_annotation/json_annotation.dart';

part 'book.g.dart';

@JsonSerializable()
class Book {
  final int? id;
  final String? title;
  final List<Author>? authors;
  final List<String>? summaries;
  // final List<Translator>? translators;
  final List<String>? subjects;
  final List<String>? bookshelves;
  final List<String>? languages;
  final bool? copyright;
  final String? mediaType;
  final Format? formats;
  final int? downloadCount;
  final bool? isLoved;

  Book({
    this.id,
    this.title,
    this.authors,
    this.summaries,
    // this.translators,
    this.subjects,
    this.bookshelves,
    this.languages,
    this.copyright,
    this.mediaType,
    this.formats,
    this.downloadCount,
    this.isLoved,
  });

  factory Book.fromJson(Map<String, dynamic> json) => _$BookFromJson(json);

  Map<String, dynamic> toJson() => _$BookToJson(this);

  Book copyWith({
    int? id,
    String? title,
    List<Author>? authors,
    List<String>? summaries,
    List<String>? subjects,
    List<String>? bookshelves,
    List<String>? languages,
    bool? copyright,
    String? mediaType,
    Format? formats,
    int? downloadCount,
    bool? isLoved,
  }) {
    return Book(
      id: id ?? this.id,
      title: title ?? this.title,
      authors: authors ?? this.authors,
      summaries: summaries ?? this.summaries,
      subjects: subjects ?? this.subjects,
      bookshelves: bookshelves ?? this.bookshelves,
      languages: languages ?? this.languages,
      copyright: copyright ?? this.copyright,
      mediaType: mediaType ?? this.mediaType,
      formats: formats ?? this.formats,
      downloadCount: downloadCount ?? this.downloadCount,
      isLoved: isLoved ?? this.isLoved,
    );
  }
}
