import 'package:palmcode/features/book/data/datasources/local_datasource/book_local_datasource.dart';
import 'package:palmcode/features/book/data/models/love_book.dart';
import 'package:palmcode/features/book/domain/repositories/book_repository.dart';

class BookRepositoryImpl implements BookRepository {
  final BookLocalDatasource bookLocalDatasource;
  BookRepositoryImpl({required this.bookLocalDatasource});

  @override
  void saveLovedBook(int bookId) {
    bookLocalDatasource.saveLovedBook(bookId);
  }

  @override
  void removeLovedBook(int bookId) {
    bookLocalDatasource.removeLovedBook(bookId);
  }

  @override
  List<LoveBook> getLovedBooks() {
    final lovedBooks = bookLocalDatasource.getLovedBooks();
    return lovedBooks;
  }

  @override
  bool isBookLoved(int bookId) {
    return bookLocalDatasource.isBookLoved(bookId);
  }
}
