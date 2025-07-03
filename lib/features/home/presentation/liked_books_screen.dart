import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palmcode/core/di/injectors.dart';
import 'package:palmcode/core/models/state_controller.dart';
import 'package:palmcode/core/themes/themes.dart';
import 'package:palmcode/features/book/domain/usecases/get_lovedbooks_usecase.dart';
import 'package:palmcode/features/book/presentations/book_screen.dart';
import 'package:palmcode/features/home/domain/entities/book.dart';
import 'package:palmcode/features/home/domain/usecases/get_books_by_ids.dart';
import 'package:palmcode/features/home/presentation/blocs/liked_books_screen_cubit.dart';

class LikedBooksScreen extends StatefulWidget {
  const LikedBooksScreen({super.key});

  @override
  State<LikedBooksScreen> createState() => _LikedBooksScreenState();
}

class _LikedBooksScreenState extends State<LikedBooksScreen> {
  late final LikedBooksScreenCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = LikedBooksScreenCubit(
      getBooksByIds: sl<GetBooksByIds>(),
      getLovedbooksUsecase: sl<GetLovedbooksUsecase>(),
    )..init();
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LikedBooksScreenCubit, StateController<List<Book>>>(
      bloc: _cubit,
      builder: (context, state) {
        return Scaffold(
          backgroundColor: appColors.black,
          appBar: AppBar(
            title: Text('Liked Books', style: appFonts.titleSmall.bold.ts),
            backgroundColor: appColors.black,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                if (state is Loading)
                  Center(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Center(
                        child: CircularProgressIndicator(
                          color: appColors.primary,
                        ),
                      ),
                    ),
                  ),
                if (state is Error)
                  Center(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        spacing: 8,
                        children: [
                          Text(
                            state.inferredErrorMessage ?? 'An error occurred',
                            style: appFonts.error.ts,
                          ),
                          AppButton(
                            text: 'Retry',
                            onTap: () {
                              _cubit.init();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                if (state is Success)
                  ...state.inferredData?.map(
                        (book) => ListTile(
                          title: Text(book.title ?? '', style: appFonts.ts),
                          subtitle: Text(
                            book.authors?.firstOrNull?.name ?? 'Unknown Author',
                            style: appFonts.ts.copyWith(
                              color: appColors.border,
                            ),
                          ),
                          // leading: book.imageUrl != null
                          //     ? Image.network(book.imageUrl!)
                          //     : null,
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    BookScreen(bookId: book.id ?? 0),
                              ),
                            );
                          },
                        ),
                      ) ??
                      const [Text('No liked books found.')],
              ],
            ),
          ),
        );
      },
    );
  }
}
