import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:palmcode/core/models/state_controller.dart';
import 'package:palmcode/features/home/domain/data/book.dart';
import 'package:palmcode/features/home/domain/usecases/get_books_usecase.dart';

class HomeScreenState extends Equatable {
  final List<Book> books;
  final bool hasReachedMax;

  const HomeScreenState({required this.books, required this.hasReachedMax});

  factory HomeScreenState.initial() {
    return const HomeScreenState(books: [], hasReachedMax: false);
  }

  HomeScreenState copyWith({List<Book>? books, bool? hasReachedMax}) {
    return HomeScreenState(
      books: books ?? this.books,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [books, hasReachedMax];
}

class HomeScreenCubit extends Cubit<StateController<HomeScreenState>> {
  final GetBooksUsecase getBooksUsecase;
  HomeScreenCubit({required this.getBooksUsecase})
    : super(StateController.idle());

  void init(int page) async {
    final data = state.inferredData ?? HomeScreenState.initial();
    emit(StateController.loading(data: data));
    try {
      final books = data.books;
      final result = await getBooksUsecase(page);
      emit(
        StateController.success(
          data.copyWith(
            books: [...books, ...result.results ?? []],
            hasReachedMax: result.next == null,
          ),
        ),
      );
    } catch (e, s) {
      Logger().e('Error initializing HomeScreenCubit', error: e, stackTrace: s);
      emit(
        StateController.failure(
          errorMessage: "Failed to load books",
          data: data,
        ),
      );
    }
  }
}
