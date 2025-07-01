import 'package:palmcode/features/home/domain/data/book.dart';
import 'package:palmcode/features/home/domain/repositories/home_repository.dart';

class GetBooksByIds {
  final HomeRepository _homeRepository;
  GetBooksByIds(this._homeRepository);

  Future<List<Book>> call(List<int> ids) async {
    return _homeRepository.getBooksByIds(ids);
  }
}
