import 'package:palmcode/features/home/data/models/get_books_response.dart';
import 'package:palmcode/features/home/domain/repositories/home_repository.dart';

class GetBooksUsecase {
  final HomeRepository homeRepository;
  GetBooksUsecase({required this.homeRepository});

  Future<GetBooksResponse> call(int page) async {
    return homeRepository.getBooks(page);
  }
}
