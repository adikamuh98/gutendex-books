import 'package:palmcode/features/book/data/models/love_book.dart';
import 'package:palmcode/features/book/domain/repositories/book_repository.dart';

class GetLovedbooksUsecase {
  final BookRepository _bookRepository;
  GetLovedbooksUsecase(this._bookRepository);

  List<LoveBook> call() {
    return _bookRepository.getLovedBooks();
  }
}
