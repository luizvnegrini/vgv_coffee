import 'package:design_system/design_system.dart';
import 'package:external_dependencies/external_dependencies.dart';
import 'package:flutter/material.dart';

import '../presentation.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  int _currentPage = 0;
  late final TabController _tabController;
  late final HomePageBloc _bloc;

  final _iconHeight = 55.0;
  final _iconWidth = 40.0;

  @override
  void initState() {
    _tabController = TabController(initialIndex: 1, length: 3, vsync: this);
    _tabController.addListener(_lockLastIndexTap);
    _tabController.animation?.addListener(
      () {
        final value = _tabController.animation!.value.round();
        if (value != _currentPage && mounted) {
          _changePage(value);
        }
      },
    );

    super.initState();
    _bloc = context.read<HomePageBloc>()
      ..loadNewImage()
      ..loadCoffeeAlbum();
  }

  void _lockLastIndexTap() {
    if (_tabController.indexIsChanging) {
      if (_tabController.index == 2) {
        _bloc.loadNewImage();
        _tabController.animateTo(1);
      } else {
        _currentPage = _tabController.index;
      }
    }
  }

  void _changePage(int newPage) => setState(() => _currentPage = newPage);

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = CustomSnackBar(
      message: message,
      backgroundColor: context.colors.primary,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      snackBar,
      snackBarAnimationStyle: AnimationStyle(
        curve: Curves.elasticIn,
        duration: 3.seconds,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(18);

    return BlocListener<HomePageBloc, HomePageState>(
      listener: (_, state) => state.maybeWhen(
        imageSaved: () {
          _bloc.loadNewImage();
          _bloc.loadCoffeeAlbum();
          _showSnackBar(context, 'Image saved on Coffee album');
        },
        orElse: () => {},
      ),
      child: Scaffold(
        body: BottomBar(
          barColor: Color.fromARGB(255, 224, 197, 178),
          clip: Clip.none,
          fit: StackFit.expand,
          borderRadius: BorderRadius.circular(18),
          duration: const Duration(seconds: 1),
          curve: Curves.decelerate,
          child: Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              TabBar(
                controller: _tabController,
                splashBorderRadius: borderRadius,
                indicatorPadding: EdgeInsets.symmetric(horizontal: 6),
                dividerColor: Colors.transparent,
                indicator: UnderlineTabIndicator(
                  borderRadius: borderRadius,
                  borderSide: BorderSide(
                    width: 4,
                  ),
                  insets: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                ),
                tabs: [
                  NavbarButton(
                    height: _iconHeight,
                    width: _iconWidth,
                    icon: Icons.photo_album,
                  ),
                  NavbarButton(
                    height: _iconHeight,
                    width: _iconWidth,
                    icon: Icons.star,
                    color: Colors.transparent,
                  ),
                  BlocBuilder<HomePageBloc, HomePageState>(
                    buildWhen: (previous, current) => current.maybeWhen(
                      loadingNewImage: () => true,
                      imageLoaded: (_) => true,
                      orElse: () => false,
                    ),
                    builder: (_, state) => state.maybeWhen(
                      orElse: () => GestureDetector(
                        onTap: () {
                          _bloc.loadNewImage();
                          _tabController.animateTo(1);
                        },
                        child: NavbarButton(
                          icon: Icons.next_plan,
                        ),
                      ),
                      loadingNewImage: () => SizedBox(
                        height: 16,
                        width: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    ),
                  )
                ],
              ),
              Positioned(
                top: -25,
                child: BlocBuilder<HomePageBloc, HomePageState>(
                  buildWhen: (previous, current) => current.maybeWhen(
                    loadingNewImage: () => true,
                    imageLoaded: (_) => true,
                    orElse: () => false,
                  ),
                  builder: (context, state) {
                    return FloatingActionButton(
                      onPressed: state.maybeWhen(
                        orElse: () => null,
                        imageLoaded: (imgData) => () {
                          //Just save the image if the tab are on focus
                          if (_tabController.index == 1) {
                            _bloc.saveImage(imgData);
                          }
                          _tabController.animateTo(1);
                        },
                      ),
                      child: state.maybeWhen(
                        loadingNewImage: () => SizedBox(
                          height: 16,
                          width: 16,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        ),
                        orElse: () => Icon(Icons.star_border)
                            .animate(
                              onPlay: (controller) => controller.repeat(),
                            )
                            .shake(duration: 500.ms, delay: 2.seconds),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          body: (context, controller) {
            return BlocBuilder<HomePageBloc, HomePageState>(
              buildWhen: (previous, current) => current.maybeWhen(
                coffeeAlbumLoaded: (_) => true,
                error: () => true,
                orElse: () => false,
              ),
              builder: (context, state) {
                return TabBarView(
                  controller: _tabController,
                  physics: BouncingScrollPhysics(),
                  children: [
                    state.maybeWhen(
                      orElse: () => Center(child: CircularProgressIndicator()),
                      error: () => const Text('Error when load gallery'),
                      coffeeAlbumLoaded: (album) => GalleryPage(imgs: album),
                    ),
                    BlocBuilder<HomePageBloc, HomePageState>(
                      buildWhen: (previous, current) => current.maybeWhen(
                        loadingNewImage: () => true,
                        imageLoaded: (_) => true,
                        error: () => true,
                        orElse: () => false,
                      ),
                      builder: (_, state) => state.maybeWhen(
                        orElse: () => Center(
                          child: CircularProgressIndicator().animate().fadeIn(),
                        ),
                        error: () => const Text('Error when load image'),
                        imageLoaded: (image) => ImagePage(image: image.$1),
                      ),
                    ),
                    SizedBox.shrink(),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
