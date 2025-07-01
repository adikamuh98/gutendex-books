import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:palmcode/core/models/state_controller.dart';
import 'package:palmcode/features/book/domain/usecases/is_book_loved_usecase.dart';
import 'package:palmcode/features/book/domain/usecases/remove_lovedbook_usecase.dart';
import 'package:palmcode/features/book/domain/usecases/save_lovebook_usecase.dart';
import 'package:palmcode/features/home/domain/data/book.dart';
import 'package:palmcode/features/home/domain/usecases/get_book_usecase.dart';

class BookScreenCubit extends Cubit<StateController<Book>> {
  final GetBookUsecase getBookUsecase;
  final SaveLovebookUsecase saveLovebookUsecase;
  final RemoveLovedbookUsecase removeLovedbookUsecase;
  final IsBookLovedUsecase isBookLovedUsecase;
  BookScreenCubit({
    required this.getBookUsecase,
    required this.saveLovebookUsecase,
    required this.removeLovedbookUsecase,
    required this.isBookLovedUsecase,
  }) : super(StateController.idle());

  void init(int id) async {
    emit(StateController.loading());
    try {
      final result = await getBookUsecase(id);
      final isLoved = isBookLovedUsecase(id);
      emit(StateController.success(result.copyWith(isLoved: isLoved)));
    } catch (e, s) {
      Logger().e('Error initializing BookScreenCubit', error: e, stackTrace: s);
      emit(StateController.failure(errorMessage: "Failed to load book"));
    }
  }

  void loveBook(int id) {
    final data = state.inferredData;
    if (data == null) return;

    emit(StateController.loading(data: data));
    try {
      if (data.isLoved == false) {
        saveLovebookUsecase(id);
      } else {
        removeLovedbookUsecase(id);
      }
      emit(StateController.success(data.copyWith(isLoved: !data.isLoved!)));
    } catch (e, s) {
      Logger().e('Error loving book', error: e, stackTrace: s);
      emit(
        StateController.failure(
          errorMessage: "Failed to update love status",
          data: data,
        ),
      );
    }
  }
}
