import 'package:get_it/get_it.dart';
import 'package:palmcode/core/constants/api_constant.dart';
import 'package:palmcode/core/networks/networks.dart';
import 'package:palmcode/features/book/data/datasources/local_datasource/book_local_datasource.dart';
import 'package:palmcode/features/book/data/datasources/local_datasource/book_local_datasource_impl.dart';
import 'package:palmcode/features/book/data/repositories/book_repository_impl.dart';
import 'package:palmcode/features/book/domain/repositories/book_repository.dart';
import 'package:palmcode/features/book/domain/usecases/get_lovedbooks_usecase.dart';
import 'package:palmcode/features/book/domain/usecases/is_book_loved_usecase.dart';
import 'package:palmcode/features/book/domain/usecases/remove_lovedbook_usecase.dart';
import 'package:palmcode/features/book/domain/usecases/save_lovebook_usecase.dart';
import 'package:palmcode/features/home/data/datasources/home_datasource.dart';
import 'package:palmcode/features/home/data/datasources/home_datasource_impl.dart';
import 'package:palmcode/features/home/data/repositories/home_repository_impl.dart';
import 'package:palmcode/features/home/domain/repositories/home_repository.dart';
import 'package:palmcode/features/home/domain/usecases/get_book_usecase.dart';
import 'package:palmcode/features/home/domain/usecases/get_books_by_ids.dart';
import 'package:palmcode/features/home/domain/usecases/get_books_usecase.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> initCoreDependencies() async {
  /// Shared preferences
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  ////

  /// Dio Client
  sl.registerLazySingleton<DioClient>(
    () => DioClient(baseUrl: ApiConstant.baseUrl),
  );
  ////

  /// Data Source
  sl.registerLazySingleton<HomeDatasource>(
    () => HomeDatasourceImpl(dioClient: sl<DioClient>()),
  );
  sl.registerLazySingleton<BookLocalDatasource>(
    () => BookLocalDatasourceImpl(),
  );
  ////

  /// Repository
  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(homeDatasource: sl<HomeDatasource>()),
  );
  sl.registerLazySingleton<BookRepository>(
    () => BookRepositoryImpl(bookLocalDatasource: sl<BookLocalDatasource>()),
  );
  ////

  /// Usecase
  sl.registerLazySingleton<GetBooksUsecase>(
    () => GetBooksUsecase(homeRepository: sl<HomeRepository>()),
  );
  sl.registerLazySingleton<GetBookUsecase>(
    () => GetBookUsecase(homeRepository: sl<HomeRepository>()),
  );
  sl.registerLazySingleton<GetLovedbooksUsecase>(
    () => GetLovedbooksUsecase(sl<BookRepository>()),
  );
  sl.registerLazySingleton<SaveLovebookUsecase>(
    () => SaveLovebookUsecase(bookRepository: sl<BookRepository>()),
  );
  sl.registerLazySingleton<RemoveLovedbookUsecase>(
    () => RemoveLovedbookUsecase(sl<BookRepository>()),
  );
  sl.registerLazySingleton<IsBookLovedUsecase>(
    () => IsBookLovedUsecase(sl<BookRepository>()),
  );
  sl.registerLazySingleton<GetBooksByIds>(
    () => GetBooksByIds(sl<HomeRepository>()),
  );
  ////

  /// Cubits / Blocs
  ////
}
