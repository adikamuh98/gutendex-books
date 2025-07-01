import 'package:palmcode/features/home/data/datasources/home_datasource.dart';
import 'package:palmcode/features/home/data/models/get_books_response.dart';
import 'package:palmcode/features/home/domain/data/book.dart';
import 'package:palmcode/features/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeDatasource homeDatasource;
  HomeRepositoryImpl({required this.homeDatasource});

  @override
  Future<GetBooksResponse> getBooks(int page) async {
    return homeDatasource.getBooks(page);
  }

  @override
  Future<List<Book>> getBooksByIds(List<int> ids) async {
    final response = await homeDatasource.getBooksByIds(ids);
    return response.results ?? [];
  }

  @override
  Future<Book> getBook(int id) async {
    return homeDatasource.getBook(id);
  }
}
