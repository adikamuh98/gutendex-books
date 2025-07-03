import 'package:palmcode/features/home/domain/entities/book.dart';
import 'package:palmcode/features/home/domain/repositories/home_repository.dart';

class GetBookUsecase {
  final HomeRepository homeRepository;
  GetBookUsecase({required this.homeRepository});

  Future<Book> call(int id) async {
    return homeRepository.getBook(id);
  }
}
