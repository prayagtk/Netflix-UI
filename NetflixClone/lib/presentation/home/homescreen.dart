import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix/application/home/home_bloc.dart';
import 'package:netflix/constants/baseurl/base_url.dart';
import 'package:netflix/constants/colors/colors.dart';
import 'package:netflix/constants/widgets/constants_widgets.dart';
import 'package:netflix/presentation/home/widgets/number_card_tile.dart';
import 'package:netflix/presentation/widgets/drop_down_list.dart';
import '../widgets/main_title_card.dart';

ValueNotifier scrollNotifier = ValueNotifier(true);

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  String dropdownvalue = 'Item 1';

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<HomeBloc>(context).add(
        const GetHomeScreenData(),
      );
    });
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: scrollNotifier,
        builder: (BuildContext context, index, _) {
          return NotificationListener<UserScrollNotification>(
            onNotification: (notification) {
              final ScrollDirection direction = notification.direction;
              if (direction == ScrollDirection.reverse) {
                scrollNotifier.value = false;
              } else if (direction == ScrollDirection.forward) {
                scrollNotifier.value = true;
              }
              return true;
            },
            child: Stack(
              children: [
                BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    if (state.isLoading) {
                      return const Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      );
                    } else if (state.isError) {
                      return const Center(
                        child: Text(
                          "Somethng Error",
                          style: TextStyle(color: kwhite),
                        ),
                      );
                    }
                    final pastYear = state.pastyearMovie.map((movie) {
                      return '$kImageURL${movie.posterPath}';
                    }).toList();
                    final trenNow = state.trendinNow.map((movie) {
                      return '$kImageURL${movie.posterPath}';
                    }).toList();
                    trenNow.shuffle();
                    final tensDrama = state.tenseDrama.map((movie) {
                      return '$kImageURL${movie.posterPath}';
                    }).toList();
                    tensDrama.shuffle();
                    final southMovie = state.southIndian.map((movie) {
                      return '$kImageURL${movie.posterPath}';
                    }).toList();
                    southMovie.shuffle();
                    // log('${state.trendingTvList.length}');
                    final topList = state.trendingTvList.map((toptv) {
                      return '$kImageURL${toptv.posterPath}';
                    }).toList();
                    // topList.shuffle();
                    // final backgorundImage = state.trendingTvList;
                    //  final backgorundImage = state.trendingTvList.map((toptv) {
                    //   return '$kImageURL${toptv.posterPath}';
                    // }).toList();
                    return ListView(
                      children: [
                        Stack(
                          children: [
                            SizedBox(
                              width: double.infinity,
                              height: 600,
                              // color: Colors.green,
                              // decoration: const BoxDecoration(
                              //   color: Colors.lightBlue,
                              //   image: DecorationImage(
                              //     fit: BoxFit.cover,
                              //     image: AssetImage(),
                              //   ),
                              // ),
                              // child: FadeInImage.assetNetwork(
                              //   placeholder: '',
                              //   image: backImageHome,
                              // ),
                              child: Image.network(
                                backImageHome,
                              ),
                            ),
                            Positioned(
                              left: 0,
                              right: 0,
                              bottom: 20,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const IconsInHome(
                                    icon: Icons.add,
                                    buttonName: 'My List',
                                  ),
                                  _stackIconHomeScreen(),
                                  const IconsInHome(
                                    icon: Icons.info,
                                    buttonName: 'Info',
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        kheight,
                        MainCardTile(
                          cardTitle: 'Released in the past year',
                          posterList: pastYear,
                        ),
                        kheight,
                        MainCardTile(
                          cardTitle: 'Trending Now',
                          posterList: trenNow,
                        ),
                        kheight,
                        NumbeCard(
                          posterList: topList,
                        ),
                        kheight,
                        MainCardTile(
                          cardTitle: 'Tense Dramas',
                          posterList: tensDrama,
                        ),
                        kheight,
                        MainCardTile(
                          cardTitle: 'South Indian Cinema',
                          posterList: southMovie,
                        ),
                      ],
                    );
                  },
                ),
                scrollNotifier.value == true
                    ? AnimatedContainer(
                        duration: const Duration(
                          milliseconds: 1000,
                        ),
                        width: double.infinity,
                        height: 110,
                        color: Colors.black.withOpacity(0.2),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  'asset/image/netflix_PNG22.png',
                                  width: 60,
                                  height: 60,
                                ),
                                const Spacer(),
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
                            // kheight,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Text(
                                  "Tv Shows",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Text(
                                  "Movies",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  children: [
                                    TextButton.icon(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return const DropDownListWidget();
                                          },
                                        );
                                      },
                                      label: const Icon(
                                        Icons.arrow_drop_down,
                                        color: kwhite,
                                      ),
                                      icon: const Text(
                                        "Categories",
                                        style: TextStyle(
                                          color: kwhite,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      // icon: const Icon(Icons.arrow_drop_down),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    : kheight,
              ],
            ),
          );
        },
      ),
    );
  }

  TextButton _stackIconHomeScreen() {
    return TextButton.icon(
      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(kwhite)),
      onPressed: () {},
      icon: const Icon(
        Icons.play_arrow,
        color: kblack,
        size: 30,
      ),
      label: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Text(
          'Play',
          style: TextStyle(
            color: kblack,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class IconsInHome extends StatelessWidget {
  final IconData icon;
  final String buttonName;
  final double iconSize;
  final double textSize;
  const IconsInHome({
    Key? key,
    required this.icon,
    required this.buttonName,
    this.iconSize = 30,
    this.textSize = 16,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          color: kwhite,
          size: iconSize,
        ),
        Text(
          buttonName,
          style: TextStyle(
            color: kwhite,
            fontSize: textSize,
          ),
        )
      ],
    );
  }
}
