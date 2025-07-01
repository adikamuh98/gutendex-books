import 'package:palmcode/features/book/data/models/love_book.dart';

abstract class BookLocalDatasource {
  void saveLovedBook(int bookId);

  void removeLovedBook(int bookId);

  List<LoveBook> getLovedBooks();

  bool isBookLoved(int bookId);
}
