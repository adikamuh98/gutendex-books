import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:palmcode/core/models/state_controller.dart';
import 'package:palmcode/features/book/domain/usecases/get_lovedbooks_usecase.dart';
import 'package:palmcode/features/home/domain/entities/book.dart';
import 'package:palmcode/features/home/domain/usecases/get_books_by_ids.dart';

class LikedBooksScreenCubit extends Cubit<StateController<List<Book>>> {
  final GetBooksByIds getBooksByIds;
  final GetLovedbooksUsecase getLovedbooksUsecase;
  LikedBooksScreenCubit({
    required this.getBooksByIds,
    required this.getLovedbooksUsecase,
  }) : super(StateController.idle());

  void init() async {
    emit(StateController.loading());
    try {
      final bookIds = getLovedbooksUsecase.call().map((e) => e.bookId).toList();
      if (bookIds.isEmpty) {
        emit(StateController.success([]));
      } else {
        final books = await getBooksByIds(bookIds);
        emit(StateController.success(books));
      }
    } catch (e, s) {
      Logger().e(
        'Error initializing LikedBooksScreenCubit',
        error: e,
        stackTrace: s,
      );
      emit(StateController.failure(errorMessage: "Failed to load liked books"));
    }
  }
}
