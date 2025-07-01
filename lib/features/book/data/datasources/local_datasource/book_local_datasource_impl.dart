import 'package:palmcode/features/book/data/models/love_book.dart';
import 'package:palmcode/features/book/data/datasources/local_datasource/book_local_datasource.dart';
import 'package:palmcode/main.dart';

class BookLocalDatasourceImpl implements BookLocalDatasource {
  final bookBox = objectBox.store.box<LoveBook>();

  @override
  void saveLovedBook(int bookId) {
    final loveBook = LoveBook(bookId: bookId);
    bookBox.put(loveBook);
  }

  @override
  void removeLovedBook(int bookId) {
    final lovedBooks = bookBox.getAll();
    for (var book in lovedBooks) {
      if (book.bookId == bookId) {
        bookBox.remove(book.id);
        break;
      }
    }
  }

  @override
  List<LoveBook> getLovedBooks() {
    final lovedBooks = bookBox.getAll();
    return lovedBooks;
  }

  @override
  bool isBookLoved(int bookId) {
    final lovedBooks = bookBox.getAll();
    for (var book in lovedBooks) {
      if (book.bookId == bookId) {
        return true;
      }
    }
    return false;
  }
}
