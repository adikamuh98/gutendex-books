import 'package:json_annotation/json_annotation.dart';

part 'format.g.dart';

@JsonSerializable()
class Format {
  final String? textHtml;
  final String? applicationEpubZip;
  final String? applicationXMobipocketEbook;
  final String? textPlainCharsetUsAscii;
  final String? applicationRdfXml;
  @JsonKey(name: 'image/jpeg')
  final String? imageJpeg;
  final String? applicationOctetStream;
  final String? textHtmlCharsetUtf8;
  final String? textPlainCharsetUtf8;
  final String? textPlainCharsetIso88591;
  final String? textHtmlCharsetIso88591;
  final String? textPlain;

  Format({
    this.textHtml,
    this.applicationEpubZip,
    this.applicationXMobipocketEbook,
    this.textPlainCharsetUsAscii,
    this.applicationRdfXml,
    this.imageJpeg,
    this.applicationOctetStream,
    this.textHtmlCharsetUtf8,
    this.textPlainCharsetUtf8,
    this.textPlainCharsetIso88591,
    this.textHtmlCharsetIso88591,
    this.textPlain,
  });

  factory Format.fromJson(Map<String, dynamic> json) => _$FormatFromJson(json);

  Map<String, dynamic> toJson() => _$FormatToJson(this);
}
