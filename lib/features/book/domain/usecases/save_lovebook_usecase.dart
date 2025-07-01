import 'package:palmcode/features/book/domain/repositories/book_repository.dart';

class SaveLovebookUsecase {
  final BookRepository bookRepository;
  SaveLovebookUsecase({required this.bookRepository});

  void call(int bookId) {
    bookRepository.saveLovedBook(bookId);
  }
}
