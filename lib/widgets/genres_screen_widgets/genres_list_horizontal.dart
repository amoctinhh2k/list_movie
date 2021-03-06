import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:movieapp2/bloc/theme_bloc/theme_controller.dart';
import 'package:movieapp2/model/genre.dart';
import 'package:movieapp2/repositories/movie_repository.dart';
import 'package:shimmer/shimmer.dart';

import 'genres_by_movie_widgets/genre_movie_widget.dart';

class GenresListHorizontal extends StatelessWidget {
  const GenresListHorizontal(
      {Key? key,
      required this.genres,
      required this.themeController,
      required this.movieRepository})
      : super(key: key);

  final List<Genre> genres;
  final ThemeController themeController;
  final MovieRepository movieRepository;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      appBar: AppBar(
        title: Text(
          "Danh sách thể loại phim",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
      body: GridView.count(
          crossAxisCount: 3,
          crossAxisSpacing: 4.0,
          mainAxisSpacing: 8.0,
          children: List.generate(genres.length, (index) {
            return Padding(
              padding:
                  const EdgeInsets.only(bottom: 10.0, left: 8.0, top: 15.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GenreMovieListWidget(
                          themeController: themeController,
                          movieRepository: movieRepository,
                          genre: genres[index]),
                    ),
                  );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50.0)),
                      child: Stack(
                        children: [
                          Center(
                            child: Shimmer.fromColors(
                              baseColor: Colors.black87,
                              highlightColor: Colors.white54,
                              enabled: true,
                              child: const SizedBox(
                                child: Icon(
                                  FontAwesome5.film,
                                  color: Colors.black26,
                                  size: 40.0,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 40.0,
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 5.0),
                                child: Center(
                                  child: Container(
                                    padding: const EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(30.0)),
                                        color: Colors.white.withOpacity(0.1)),
                                    child: Text(
                                      genres[index].name,
                                      maxLines: 2,
                                      style: const TextStyle(
                                          height: 1.4,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12.0),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          })),
    );
  }
}
