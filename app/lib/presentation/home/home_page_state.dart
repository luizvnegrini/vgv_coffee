import 'dart:typed_data';

import 'package:flutter/foundation.dart';

sealed class HomePageState {
  const HomePageState();

  const factory HomePageState.loading() = LoadingNewImageState;
  const factory HomePageState.imageLoaded((Uint8List, String) image) =
      ImageLoadedState;
  const factory HomePageState.imageSaved() = ImageSavedState;
  const factory HomePageState.error() = ErrorState;
  const factory HomePageState.coffeeAlbumLoaded(List<String> coffeeAlbum) =
      CoffeeAlbumLoadedState;

  T when<T>({
    required T Function() loadingNewImage,
    required T Function((Uint8List, String) image) imageLoaded,
    required T Function() imageSaved,
    required T Function() error,
    required T Function(List<String> coffeeAlbum) coffeeAlbumLoaded,
  }) {
    return switch (this) {
      LoadingNewImageState() => loadingNewImage(),
      ImageLoadedState(image: final image) => imageLoaded(image),
      ImageSavedState() => imageSaved(),
      ErrorState() => error(),
      CoffeeAlbumLoadedState(coffeeAlbum: final coffeeAlbum) =>
        coffeeAlbumLoaded(coffeeAlbum),
    };
  }

  T maybeWhen<T>({
    T Function()? loadingNewImage,
    T Function((Uint8List, String) image)? imageLoaded,
    T Function()? imageSaved,
    T Function()? error,
    T Function(List<String> coffeeAlbum)? coffeeAlbumLoaded,
    required T Function() orElse,
  }) {
    return switch (this) {
      LoadingNewImageState() => loadingNewImage?.call() ?? orElse(),
      ImageLoadedState(image: final image) =>
        imageLoaded?.call(image) ?? orElse(),
      ImageSavedState() => imageSaved?.call() ?? orElse(),
      ErrorState() => error?.call() ?? orElse(),
      CoffeeAlbumLoadedState(coffeeAlbum: final coffeeAlbum) =>
        coffeeAlbumLoaded?.call(coffeeAlbum) ?? orElse(),
    };
  }

  HomePageState copyWith() {
    return switch (this) {
      LoadingNewImageState() => const LoadingNewImageState(),
      ImageLoadedState(image: final image) => ImageLoadedState(image),
      ImageSavedState() => const ImageSavedState(),
      ErrorState() => const ErrorState(),
      CoffeeAlbumLoadedState(coffeeAlbum: final coffeeAlbum) =>
        CoffeeAlbumLoadedState(coffeeAlbum),
    };
  }
}

final class LoadingNewImageState extends HomePageState {
  const LoadingNewImageState();
}

final class ImageLoadedState extends HomePageState {
  final (Uint8List, String) image;

  const ImageLoadedState(this.image);
}

final class ImageSavedState extends HomePageState {
  const ImageSavedState();
}

final class ErrorState extends HomePageState {
  const ErrorState();
}

final class CoffeeAlbumLoadedState extends HomePageState {
  final List<String> coffeeAlbum;

  const CoffeeAlbumLoadedState(this.coffeeAlbum);
}
