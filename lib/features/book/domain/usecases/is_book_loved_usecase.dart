import 'package:palmcode/features/book/domain/repositories/book_repository.dart';

class IsBookLovedUsecase {
  final BookRepository _bookRepository;
  IsBookLovedUsecase(this._bookRepository);

  bool call(int bookId) {
    return _bookRepository.isBookLoved(bookId);
  }
}
