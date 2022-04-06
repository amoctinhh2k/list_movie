import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movieapp2/bloc/bottom_navbar_bloc.dart';
import 'package:movieapp2/bloc/theme_bloc/theme_controller.dart';
import 'package:movieapp2/repositories/movie_repository.dart';
import 'package:movieapp2/widgets/genres_screen_widgets/genres_widgets/genres_widget.dart';

import 'home_screen/home_screen.dart';
import 'login.dart';

class MainScreen extends StatefulWidget {
  const MainScreen(
      {Key? key, required this.themeController, required this.movieRepository})
      : super(key: key);

  final ThemeController themeController;
  final MovieRepository movieRepository;

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final BottomNavBarBloc _bottomNavBarBloc = BottomNavBarBloc();
  late bool isDarkMode;
  // late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    // // Pointing the video controller to our local asset.
    // _controller = VideoPlayerController.asset("assets/coffee.mp4")
    //   ..initialize().then((_) {
    //     _controller.play();
    //     _controller.setLooping(true);
    //     setState(() {});
    //   });
  }

  @override
  void dispose() {
    _bottomNavBarBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    isDarkMode = widget.themeController.themeMode == ThemeMode.dark;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
          body: StreamBuilder<NavBarItem>(
            stream: _bottomNavBarBloc.itemStream,
            initialData: _bottomNavBarBloc.defaultItem,
            builder:
                (BuildContext context, AsyncSnapshot<NavBarItem> snapshot) {
              switch (snapshot.data) {
                case NavBarItem.home:
                  return HomeScreen(
                      movieRepository: widget.movieRepository,
                      themeController: widget.themeController);
                case NavBarItem.genres:
                  return GenresWidget(
                      movieRepository: widget.movieRepository,
                      themeController: widget.themeController);
                case NavBarItem.search:
                  return Container();
                case NavBarItem.profile:
                  return BackgroundVideo();
                // Container();
                default:
                  return Container();
              }
            },
          ),
          bottomNavigationBar: StreamBuilder(
            stream: _bottomNavBarBloc.itemStream,
            initialData: _bottomNavBarBloc.defaultItem,
            builder:
                (BuildContext context, AsyncSnapshot<NavBarItem> snapshot) {
              return Container(
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(
                            width: 0.5, color: Colors.grey.withOpacity(0.4)))),
                child: BottomNavigationBar(
                  elevation: 0.9,
                  iconSize: 21,
                  unselectedFontSize: 10.0,
                  selectedFontSize: 10.0,
                  type: BottomNavigationBarType.fixed,
                  currentIndex: snapshot.data!.index,
                  onTap: _bottomNavBarBloc.pickItem,
                  items: [
                    BottomNavigationBarItem(
                      label: "Trang chủ",
                      icon: SizedBox(
                        child: SvgPicture.asset(
                          "assets/icons/home.svg",
                          color: Colors.grey.shade700,
                          height: 25.0,
                          width: 25.0,
                        ),
                      ),
                      activeIcon: SizedBox(
                        child: SvgPicture.asset(
                          "assets/icons/home-active.svg",
                          color: Colors.white,
                          height: 25.0,
                          width: 25.0,
                        ),
                      ),
                    ),
                    BottomNavigationBarItem(
                      label: "Thể loại",
                      icon: SvgPicture.asset(
                        "assets/icons/layers.svg",
                        color: Colors.grey.shade700,
                        height: 25.0,
                        width: 25.0,
                      ),
                      activeIcon: SizedBox(
                        child: SvgPicture.asset(
                          "assets/icons/layers-active.svg",
                          color: Colors.white,
                          height: 25.0,
                          width: 25.0,
                        ),
                      ),
                    ),
                    BottomNavigationBarItem(
                      label: "Tìm kiếm",
                      icon: SvgPicture.asset(
                        "assets/icons/search.svg",
                        color: Colors.grey.shade700,
                        height: 25.0,
                        width: 25.0,
                      ),
                      activeIcon: SizedBox(
                        child: SvgPicture.asset(
                          "assets/icons/search-active.svg",
                          color: Colors.white,
                          height: 25.0,
                          width: 25.0,
                        ),
                      ),
                    ),
                    BottomNavigationBarItem(
                      label: "Cá nhân",
                      icon: SvgPicture.asset(
                        "assets/icons/profile.svg",
                        color: Colors.grey.shade700,
                        height: 25.0,
                        width: 25.0,
                      ),
                      activeIcon: SizedBox(
                        child: SvgPicture.asset(
                          "assets/icons/profile-active.svg",
                          color: Colors.white,
                          height: 25.0,
                          width: 25.0,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          )),
    );
  }
}
