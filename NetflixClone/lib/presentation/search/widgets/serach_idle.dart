import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix/application/search/search_bloc.dart';
import 'package:netflix/constants/baseurl/base_url.dart';
import 'package:netflix/constants/colors/colors.dart';
import 'package:netflix/constants/widgets/constants_widgets.dart';
import 'package:netflix/presentation/widgets/maintitle.dart';

class SearchIdleWidgets extends StatelessWidget {
  const SearchIdleWidgets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   BlocProvider.of<SearchBloc>(context).add(
    //     const Initialize(),
    //   );
    // });
    // BlocProvider.of<SearchBloc>(context).add(
    //   const Initialize(),
    // );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const MainTitleWidgets(
          mainTitle: 'Top Searches',
        ),
        kheight,
        // kwidth,
        Expanded(
          child: BlocBuilder<SearchBloc, SearchState>(
            builder: (context, state) {
              if (state.isLodinng) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state.isError) {
                return const Center(
                  child: Text('Error While Getting Data'),
                );
              } else if (state.ideLisst.isEmpty) {
                return const Center(
                  child: Text('No Data Found'),
                );
              }
              return ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final movie = state.ideLisst[index];
                    return TopSearchItemTile(
                      imageUrl: '$kImageURL${movie.posterPath}',
                      title: movie.title ?? "No Title Provided",
                    );
                  },
                  separatorBuilder: (context, index) => kheight20,
                  itemCount: state.ideLisst.length);
            },
          ),
        )
      ],
    );
  }
}

class TopSearchItemTile extends StatelessWidget {
  final String title;
  final String imageUrl;
  const TopSearchItemTile({
    Key? key,
    required this.title,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenwidth = MediaQuery.of(context).size.width;
    return Row(
      children: [
        Container(
          width: screenwidth * 0.35,
          height: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(
                imageUrl,
              ),
            ),
          ),
        ),
        kwidth20,
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              color: ktextwhite,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        CircleAvatar(
          backgroundColor: kwhite,
          radius: 28,
          child: CircleAvatar(
            backgroundColor: kblack,
            radius: 27,
            child: IconButton(
              icon: const Icon(
                CupertinoIcons.play_fill,
                color: kwhite,
              ),
              onPressed: () {},
            ),
          ),
        )
      ],
    );
  }
}
