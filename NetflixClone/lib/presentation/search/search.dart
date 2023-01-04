import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix/application/search/search_bloc.dart';
import 'package:netflix/constants/colors/colors.dart';
import 'package:netflix/constants/widgets/constants_widgets.dart';
import 'package:netflix/domain/debounce/debounce.dart';
import 'package:netflix/presentation/search/widgets/search_result.dart';
import 'package:netflix/presentation/search/widgets/serach_idle.dart';

final searchResult = TextEditingController();
ValueNotifier<bool> serachValueNotifier = ValueNotifier(true);

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);

  final _debouncer = Debouncer(milliseconds: 1 * 1000);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<SearchBloc>(context).add(
        const Initialize(),
      );
    });
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ValueListenableBuilder(
                  valueListenable: serachValueNotifier,
                  builder: (context, bool search, _) {
                    return CupertinoSearchTextField(
                      controller: searchResult,
                      placeholder: 'Search',
                      backgroundColor: Colors.grey.withOpacity(0.4),
                      prefixIcon: const Icon(
                        CupertinoIcons.search,
                        color: kgrey,
                      ),
                      suffixIcon: const Icon(
                        CupertinoIcons.xmark_circle_fill,
                        color: kgrey,
                      ),
                      style: const TextStyle(color: ktextwhite),
                      onChanged: (value) {
                        // if (searchResult.text.isEmpty) {
                        //   SearchIdleWidgets();
                        // }
                        // if (value.isEmpty) {
                        //   const Center(
                        //     child: Text('No Data Found'),
                        //   );
                        // }
                        if (value.isNotEmpty) {
                          _debouncer.run(() {
                            BlocProvider.of<SearchBloc>(context).add(
                              SearchMovie(
                                movieQuery: value,
                              ),
                            );
                          });
                          search = false;
                          serachValueNotifier.value = search;
                        } else if (searchResult.text.isEmpty) {
                          search = true;
                          serachValueNotifier.value = search;
                        }
                      },
                    );
                  }),
              kheight20,
              ValueListenableBuilder(
                  valueListenable: serachValueNotifier,
                  builder: (context, bool search, _) {
                    return Expanded(
                      child: BlocBuilder<SearchBloc, SearchState>(
                        builder: (context, state) {
                          // ignore: unnecessary_null_comparison
                          if (serachValueNotifier.value) {
                            return const SearchIdleWidgets();
                          } else if (state.searchResultList.isNotEmpty) {
                            return const SearchResultWidget();
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
