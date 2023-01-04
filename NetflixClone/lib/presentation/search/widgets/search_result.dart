import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix/application/search/search_bloc.dart';
import 'package:netflix/constants/widgets/constants_widgets.dart';
import 'package:netflix/presentation/widgets/maintitle.dart';

class SearchResultWidget extends StatelessWidget {
  const SearchResultWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const MainTitleWidgets(
          mainTitle: 'Movies & Tv',
        ),
        kheight,
        Expanded(
          child: BlocBuilder<SearchBloc, SearchState>(
            builder: (context, state) {
              return GridView.count(
                shrinkWrap: true,
                crossAxisCount: 3,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 1 / 1.4,
                children: List.generate(
                  state.searchResultList.length,
                  (index) {
                    final movie = state.searchResultList[index];
                    return MainMovieCardLidtItem(
                      imageUri: movie.posterImageUrl,
                    );
                  },
                ),
              );
            },
          ),
        )
      ],
    );
  }
}

class MainMovieCardLidtItem extends StatelessWidget {
  final String imageUri;
  const MainMovieCardLidtItem({
    Key? key,
    required this.imageUri,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
            imageUri,
          ),
          fit: BoxFit.fill,
        ),
        borderRadius: BorderRadius.circular(7),
      ),
    );
  }
}
