import 'package:palmcode/features/book/domain/repositories/book_repository.dart';

class RemoveLovedbookUsecase {
  final BookRepository _bookRepository;

  RemoveLovedbookUsecase(this._bookRepository);

  void call(int bookId) {
    _bookRepository.removeLovedBook(bookId);
  }
}
