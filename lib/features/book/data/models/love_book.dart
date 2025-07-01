import 'package:objectbox/objectbox.dart';

@Entity()
class LoveBook {
  @Id()
  int id = 0;
  final int bookId;

  LoveBook({required this.bookId});
}
