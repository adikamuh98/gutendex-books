import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palmcode/core/di/injectors.dart';
import 'package:palmcode/core/models/state_controller.dart';
import 'package:palmcode/core/themes/themes.dart';
import 'package:palmcode/features/book/domain/usecases/is_book_loved_usecase.dart';
import 'package:palmcode/features/book/domain/usecases/remove_lovedbook_usecase.dart';
import 'package:palmcode/features/book/domain/usecases/save_lovebook_usecase.dart';
import 'package:palmcode/features/book/presentations/blocs/book_screen_cubit.dart';
import 'package:palmcode/features/home/domain/data/author.dart';
import 'package:palmcode/features/home/domain/data/book.dart';
import 'package:palmcode/features/home/domain/usecases/get_book_usecase.dart';

class BookScreen extends StatefulWidget {
  final int bookId;
  const BookScreen({super.key, required this.bookId});

  @override
  State<BookScreen> createState() => _BookScreenState();
}

class _BookScreenState extends State<BookScreen> {
  late final BookScreenCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = BookScreenCubit(
      getBookUsecase: sl<GetBookUsecase>(),
      saveLovebookUsecase: sl<SaveLovebookUsecase>(),
      removeLovedbookUsecase: sl<RemoveLovedbookUsecase>(),
      isBookLovedUsecase: sl<IsBookLovedUsecase>(),
    )..init(widget.bookId);
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookScreenCubit, StateController<Book>>(
      bloc: _cubit,
      builder: (context, state) {
        return Scaffold(
          backgroundColor: appColors.black,
          appBar: AppBar(
            foregroundColor: appColors.white,
            backgroundColor: appColors.black,
            title: state is Success
                ? Text('Book Details', style: appFonts.subtitle.bold.ts)
                : null,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                if (state is Loading)
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Center(
                      child: CircularProgressIndicator(
                        color: appColors.primary,
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
                              _cubit.init(widget.bookId);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                if (state is Success) ...[_buildSuccess(state.inferredData!)],
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSuccess(Book book) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            book.formats?.imageJpeg ?? 'https://placehold.co/600x400',
            height: 300,
            width: double.infinity,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 16.0),
          Row(
            spacing: 16,
            children: [
              Expanded(
                child: Text(
                  book.title ?? 'No Title',
                  style: appFonts.subtitle.bold.ts,
                ),
              ),
              IconButton(
                onPressed: () {
                  _cubit.loveBook(book.id!);
                },
                icon: Icon(
                  book.isLoved == true ? Icons.favorite : Icons.favorite_border,
                  color: book.isLoved == true
                      ? appColors.primary
                      : appColors.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          _buildAuthors(book.authors ?? []),
          const SizedBox(height: 16.0),
          _buildSummaries(book.summaries ?? []),
        ],
      ),
    );
  }

  Widget _buildAuthors(List<Author> authors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Authors:', style: appFonts.bold.ts),
        const SizedBox(height: 8.0),
        ...authors.map(
          (author) => Text(
            author.name ?? 'Unknown Author',
            style: appFonts.ts.copyWith(color: appColors.border),
          ),
        ),
      ],
    );
  }

  Widget _buildSummaries(List<String> summaries) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Summaries:', style: appFonts.bold.ts),
        const SizedBox(height: 8.0),
        ...summaries.map(
          (summary) =>
              Text(summary, style: appFonts.ts, textAlign: TextAlign.justify),
        ),
      ],
    );
  }
}
