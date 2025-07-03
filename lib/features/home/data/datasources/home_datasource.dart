import 'package:palmcode/features/home/data/models/get_books_response.dart';
import 'package:palmcode/features/home/domain/entities/book.dart';

abstract class HomeDatasource {
  Future<GetBooksResponse> getBooks(int page);
  
  Future<GetBooksResponse> getBooksByIds(List<int> ids);

  Future<Book> getBook(int id);
}
