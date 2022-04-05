import 'package:flutter/material.dart';
import 'package:movieapp2/bloc/theme_bloc/theme_controller.dart';
import 'package:movieapp2/repositories/movie_repository.dart';
import 'package:movieapp2/widgets/home_screen_widgets/popular_movies_widgets/popular_movies_widget.dart';
import 'package:movieapp2/widgets/home_screen_widgets/upcoming_widgets/upcoming_widget.dart';

import '../../widgets/home_screen_widgets/now_playing_widgets/now_playing_widget.dart';
import '../../widgets/home_screen_widgets/top_rated_movies_widgets/top_rated_movies_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen(
      {Key? key, required this.themeController, required this.movieRepository})
      : super(key: key);

  final ThemeController themeController;
  final MovieRepository movieRepository;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          UpComingWidget(
              movieRepository: widget.movieRepository,
              themeController: widget.themeController),
          const Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
            child: Text(
              "TỔNG HỢP PHIM HOT",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          TopRatedMoviesWidget(
              movieRepository: widget.movieRepository,
              themeController: widget.themeController),
          const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                " PHIM MỚI NHẤT",
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
          NowPlayingWidget(
              movieRepository: widget.movieRepository,
              themeController: widget.themeController),
          const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                "XEM NGAY !",
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
          PopularMoviesWidget(
              movieRepository: widget.movieRepository,
              themeController: widget.themeController),
        ],
      ),
    );
  }
}
