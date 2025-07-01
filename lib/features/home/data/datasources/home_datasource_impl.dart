import 'package:palmcode/core/constants/api_constant.dart';
import 'package:palmcode/core/networks/networks.dart';
import 'package:palmcode/features/home/data/datasources/home_datasource.dart';
import 'package:palmcode/features/home/data/models/get_books_response.dart';
import 'package:palmcode/features/home/domain/data/book.dart';

class HomeDatasourceImpl implements HomeDatasource {
  final DioClient dioClient;
  HomeDatasourceImpl({required this.dioClient});

  @override
  Future<GetBooksResponse> getBooks(int page) async {
    final result = await dioClient.dio.get("${ApiConstant.getBooks}/?page=$page");
    if (result.statusCode == 200) {
      return GetBooksResponse.fromJson(result.data);
    } else {
      throw Exception('Failed to load books');
    }
  }

  @override
  Future<GetBooksResponse> getBooksByIds(List<int> ids) async {
    final response = await dioClient.dio.get(
      ApiConstant.getBooks,
      queryParameters: {'ids': ids.join(',')},
    );
    if (response.statusCode == 200) {
      return GetBooksResponse.fromJson(response.data);
    } else {
      throw Exception('Failed to load books by ids');
    }
  }

  @override
  Future<Book> getBook(int id) async {
    final result = await dioClient.dio.get("${ApiConstant.getBooks}/$id");
    if (result.statusCode == 200) {
      return Book.fromJson(result.data);
    } else {
      throw Exception('Failed to load book with id $id');
    }
  }
}
