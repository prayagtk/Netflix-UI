import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:netflix/application/hot_and_new/hotand_new_bloc.dart';
import 'package:netflix/constants/baseurl/base_url.dart';
import 'package:netflix/constants/colors/colors.dart';
import 'package:netflix/constants/widgets/constants_widgets.dart';
import 'package:netflix/presentation/new_and_hot/widgets/coming_soon_tab.dart';
import 'package:netflix/presentation/new_and_hot/widgets/everyone_watching_widget.dart';

class HotandNewScreen extends StatelessWidget {
  const HotandNewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(90),
          child: AppBar(
            title: Text(
              'Hot & New',
              style: GoogleFonts.montserrat(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.cast,
                      color: kwhite,
                      size: 30,
                    ),
                  ),
                  // kwidth,
                  Container(
                    height: 30,
                    width: 30,
                    decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'asset/image/ntflixAvat.jpg',
              ),
            ),
          ),
                  ),
                  kwidth,
                ],
              ),
            ],
            bottom: TabBar(
              isScrollable: true,
              labelColor: kblack,
              unselectedLabelColor: kwhite,
              labelStyle:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              indicator: BoxDecoration(
                color: kwhite,
                borderRadius: kradius30,
              ),
              tabs: const [
                Tab(
                  text: '🍿 Coming Soon',
                ),
                Tab(
                  text: '👀 EveryOnes Watch',
                )
              ],
            ),
          ),
        ),
        body: const TabBarView(
          children: [
            ComingSonnWidgte(),
            EveryOneWatchingWidget(),
            // _buildComingSoon(),
            // _buildEverythingWatch(),
            // TabBarFirstScreen(),
            // TabBarScondScreen(),
          ],
        ),
      ),
    );
  }

  // Widget _buildComingSoon() {
  //   return ListView.builder(
  //     itemCount: 5,
  //     itemBuilder: (BuildContext context, int index) => const ComingSoonTab(
  //       month: 'SEP',
  //       date: 11,
  //       filmName: 'TALL GIRL 2',
  //       realiseDate: "Coming on september 11",
  //     ),
  //   );
  // }

  // Widget _buildEverythingWatch() {
  //   return ListView.builder(
  //     shrinkWrap: true,
  //     itemCount: 5,
  //     itemBuilder: (BuildContext context, int index) {
  //       return const EveryoneWatchingWidget();
  //     },
  //   );
  // }
}

class ComingSonnWidgte extends StatelessWidget {
  const ComingSonnWidgte({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<HotandNewBloc>(context).add(
        const LoadDatainComingSoon(),
      );
    });
    return RefreshIndicator(
      onRefresh: () async {
        BlocProvider.of<HotandNewBloc>(context).add(
          const LoadDatainComingSoon(),
        );
      },
      child: BlocBuilder<HotandNewBloc, HotandNewState>(
        builder: (context, state) {
          if (state.isError) {
            return const Center(
              child: Text('Error While Fetching'),
            );
          } else if (state.isLoading) {
            return const Center(
              child: CircularProgressIndicator(strokeWidth: 2),
            );
          } else if (state.comingSoonList.isEmpty) {
            return const Center(
              child: Text('List is Empty'),
            );
          } else {
            return ListView.builder(
              padding: const EdgeInsets.only(top: 10),
              itemCount: state.comingSoonList.length,
              itemBuilder: (BuildContext context, int index) {
                final movie = state.comingSoonList[index];
                if (movie.id == null) {
                  return const SizedBox();
                }
                final date = DateTime.parse(movie.releaseDate!);
                final formatedDate = DateFormat.yMMMMd('en_US').format(date);
                return ComingSoonTab(
                  id: movie.id.toString(),
                  month: formatedDate
                      .split(' ')
                      .first
                      .substring(0, 3)
                      .toUpperCase(),
                  day: movie.releaseDate!.split('-')[1],
                  filmName: movie.originalTitle ?? 'No Title',
                  posterPath: '$kImageURL${movie.posterPath}',
                  description: movie.overview ?? ' No Description',
                );
              },
            );
          }
        },
      ),
    );
  }
}

class EveryOneWatchingWidget extends StatelessWidget {
  const EveryOneWatchingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<HotandNewBloc>(context).add(
        const LoadDatainEveryOneWatching(),
      );
    });
    return RefreshIndicator(
      onRefresh: () async {
        BlocProvider.of<HotandNewBloc>(context).add(
          const LoadDatainEveryOneWatching(),
        );
      },
      child: BlocBuilder<HotandNewBloc, HotandNewState>(
        builder: (context, state) {
          if (state.isError) {
            return const Center(
              child: Text('Error While Fetching'),
            );
          } else if (state.isLoading) {
            return const Center(
              child: CircularProgressIndicator(strokeWidth: 2),
            );
          } else if (state.everyOneIsWatching.isEmpty) {
            return const Center(
              child: Text('List is Empty'),
            );
          } else {
            return ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: state.everyOneIsWatching.length,
              itemBuilder: (context, index) {
                final eMovies = state.everyOneIsWatching[index];
                if (eMovies.id == null) {
                  return const SizedBox();
                }
                // log(eMovies.originalTitle.toString());
                // log(eMovies.title.toString());
                return EveryoneWatchingTab(
                  filmName: eMovies.tvTitle ?? 'No Title ',
                  posterPath: '$kImageURL${eMovies.posterPath}',
                  description: eMovies.overview ?? 'No Description',
                );
              },
            );
          }
        },
      ),
    );
  }
}
