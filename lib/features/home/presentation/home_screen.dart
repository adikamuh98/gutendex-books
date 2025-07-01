import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palmcode/core/di/injectors.dart';
import 'package:palmcode/core/models/state_controller.dart';
import 'package:palmcode/core/themes/themes.dart';
import 'package:palmcode/features/book/presentations/book_screen.dart';
import 'package:palmcode/features/home/domain/usecases/get_books_usecase.dart';
import 'package:palmcode/features/home/presentation/blocs/home_screen_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin<HomeScreen> {
  late final HomeScreenCubit _cubit;
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  int _currentPage = 1;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _cubit = HomeScreenCubit(getBooksUsecase: sl<GetBooksUsecase>())
      ..init(_currentPage);
    _searchController.addListener(_listener);
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _cubit.close();
    _searchController.removeListener(_listener);
    _searchController.dispose();
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _listener() {
    final text = _searchController.text;
    _onSearchChanged(text);
  }

  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query;
    });
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _currentPage++;
      _cubit.init(_currentPage);
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: appColors.black,
      appBar: AppBar(
        title: Text('Home', style: appFonts.titleSmall.bold.ts),
        backgroundColor: appColors.black,
      ),
      body: BlocBuilder<HomeScreenCubit, StateController<HomeScreenState>>(
        bloc: _cubit,
        builder: (context, state) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 12,
                ),
                child: AppTextField(
                  label: 'Search Books',
                  controller: _searchController,
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(
                    children: [
                      ...state.inferredData?.books
                              .where((e) {
                                final title = e.title?.toLowerCase() ?? '';
                                final author =
                                    e.authors?.firstOrNull?.name
                                        ?.toLowerCase() ??
                                    '';
                                final query = _searchQuery.toLowerCase();
                                return title.contains(query) ||
                                    author.contains(query);
                              })
                              .map(
                                (book) => ListTile(
                                  title: Text(
                                    book.title ?? '',
                                    style: appFonts.ts,
                                  ),
                                  subtitle: Text(
                                    book.authors?.firstOrNull?.name ??
                                        'Unknown Author',
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
                          [],
                      if (state is Error)
                        Center(
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Column(
                              spacing: 8,
                              children: [
                                Text(
                                  state.inferredErrorMessage ??
                                      'An error occurred',
                                  style: appFonts.error.ts,
                                ),
                                AppButton(
                                  text: 'Retry',
                                  onTap: () {
                                    _cubit.init(_currentPage);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      if (state is Loading)
                        Center(
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: CircularProgressIndicator(
                              color: appColors.primary,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
