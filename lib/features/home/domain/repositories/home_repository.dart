import 'package:palmcode/features/home/data/models/get_books_response.dart';
import 'package:palmcode/features/home/domain/entities/book.dart';

abstract class HomeRepository {
  Future<GetBooksResponse> getBooks(int page);

  Future<List<Book>> getBooksByIds(List<int> ids);

  Future<Book> getBook(int id);
}
