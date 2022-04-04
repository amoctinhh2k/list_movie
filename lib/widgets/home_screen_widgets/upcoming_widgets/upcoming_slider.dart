import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:intl/intl.dart';
import 'package:movieapp2/bloc/upcoming_bloc/upcoming_cubit.dart';
import 'package:movieapp2/repositories/movie_repository.dart';
import 'package:shimmer/shimmer.dart';

import 'upcoming_loader.dart';

class UpComingSlider extends StatelessWidget {
  const UpComingSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => UpComingCubit(
        repository: context.read<MovieRepository>(),
      )..fetchUpComing(),
      child: UpComingView(),
    );
  }
}

class UpComingView extends StatelessWidget {
  UpComingView({Key? key}) : super(key: key);
  String date = "${DateFormat('dd-MM-yyyy').format(
    DateTime.parse(
      DateTime.now().toString(),
    ),
  )}";
  @override
  Widget build(BuildContext context) {
    final state = context.watch<UpComingCubit>().state;
    switch (state.status) {
      case ListStatus.failure:
        return const Center(child: Text('Có lỗi '));
      case ListStatus.success:
        return Stack(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                autoPlay: false,
                viewportFraction: 1.0,
                aspectRatio: 2 / 2.8,
                enlargeCenterPage: true,
              ),
              items: state.movies
                  .map((movie) => Stack(
                        children: [
                          Stack(
                            children: [
                              Shimmer.fromColors(
                                baseColor: Colors.black87,
                                highlightColor: Colors.white54,
                                enabled: true,
                                child: const AspectRatio(
                                    aspectRatio: 2 / 2.8,
                                    child: Icon(
                                      FontAwesome5.film,
                                      color: Colors.black26,
                                      size: 40.0,
                                    )),
                              ),
                              AspectRatio(
                                  aspectRatio: 2 / 2.8,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(5.0),
                                    child: Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          // shape: BoxShape.circle,
                                          border: Border.all(
                                            color: Colors.grey,
                                          ),
                                          image: DecorationImage(
                                              fit: BoxFit.fill,
                                              image:
                                                  AssetImage("assets/22.jpg")),
                                        ),
                                      ),
                                    ),
                                    // FadeInImage.memoryNetwork(
                                    //     fit: BoxFit.fitHeight,
                                    //     alignment: Alignment.bottomCenter,
                                    //     placeholder: kTransparentImage,
                                    //     image:
                                    //         "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTty-99wmSoUwPEJJPWz881jp5uxr29vn_FxTu6PbLbTB-L24Fk4YmQytD5EdEynrwwUz4&usqp=CAU" +
                                    //             movie.poster),
                                  )),
                            ],
                          ),
                          AspectRatio(
                            aspectRatio: 2 / 2.8,
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                    stops: const [
                                      0.0,
                                      0.4,
                                      0.4,
                                      1.0
                                    ],
                                    colors: [
                                      Colors.black.withOpacity(1.0),
                                      Colors.black.withOpacity(0.0),
                                      Colors.black.withOpacity(0.0),
                                      Colors.black.withOpacity(0.7),
                                    ]),
                              ),
                            ),
                          ),
                          Positioned(
                              top: 5.0,
                              right: 10.0,
                              child: SafeArea(
                                child: Column(
                                  children: [
                                    Text(
                                      "Ngày : " + date,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey,
                                        fontSize: 12.0,
                                      ),
                                    ),
                                    // Text(
                                    //   movie.releaseDate,
                                    //   style: const TextStyle(
                                    //       fontWeight: FontWeight.bold,
                                    //       fontSize: 12.0,
                                    //       color: Colors.grey),
                                    // ),
                                  ],
                                ),
                              )),
                        ],
                      ))
                  .toList(),
            ),
            Positioned(
                left: 10.0,
                top: 10.0,
                child: SafeArea(
                  child: Text(
                    "Đẩy phim mới",
                    style: TextStyle(
                        fontFamily: 'NunitoBold',
                        fontSize: 18.0,
                        color: Colors.white.withOpacity(0.5)),
                  ),
                )),
          ],
        );
      default:
        return buildLoadingCampaignsWidget(context);
    }
  }
}
