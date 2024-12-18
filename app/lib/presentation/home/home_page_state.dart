import 'dart:typed_data';

import 'package:flutter/foundation.dart';

sealed class HomePageState {
  const HomePageState();

  const factory HomePageState.loading() = LoadingNewImageState;
  const factory HomePageState.imageLoaded(Uint8List image) = ImageLoadedState;
  const factory HomePageState.imageSaved() = ImageSavedState;
  const factory HomePageState.error() = ErrorState;

  T when<T>({
    required T Function() loadingNewImage,
    required T Function(Uint8List image) imageLoaded,
    required T Function() imageSaved,
    required T Function() error,
  });

  T maybeWhen<T>({
    T Function()? loadingNewImage,
    T Function(Uint8List image)? imageLoaded,
    T Function()? imageSaved,
    T Function()? error,
    required T Function() orElse,
  });

  HomePageState copyWith();
}

final class LoadingNewImageState extends HomePageState {
  const LoadingNewImageState();

  @override
  T when<T>({
    required T Function() loadingNewImage,
    required T Function(Uint8List image) imageLoaded,
    required T Function() imageSaved,
    required T Function() error,
  }) {
    return loadingNewImage();
  }

  @override
  T maybeWhen<T>({
    T Function()? loadingNewImage,
    T Function(Uint8List image)? imageLoaded,
    T Function()? imageSaved,
    T Function()? error,
    required T Function() orElse,
  }) {
    return loadingNewImage?.call() ?? orElse();
  }

  @override
  HomePageState copyWith() => const LoadingNewImageState();
}

final class ImageLoadedState extends HomePageState {
  final Uint8List image;

  const ImageLoadedState(this.image);

  @override
  T when<T>({
    required T Function() loadingNewImage,
    required T Function(Uint8List image) imageLoaded,
    required T Function() imageSaved,
    required T Function() error,
  }) {
    return imageLoaded(image);
  }

  @override
  T maybeWhen<T>({
    T Function()? loadingNewImage,
    T Function(Uint8List image)? imageLoaded,
    T Function()? imageSaved,
    T Function()? error,
    required T Function() orElse,
  }) {
    return imageLoaded?.call(image) ?? orElse();
  }

  @override
  HomePageState copyWith() => ImageLoadedState(Uint8List.fromList(image));
}

final class ImageSavedState extends HomePageState {
  const ImageSavedState();

  @override
  T when<T>({
    required T Function() loadingNewImage,
    required T Function(Uint8List image) imageLoaded,
    required T Function() imageSaved,
    required T Function() error,
  }) {
    return imageSaved();
  }

  @override
  T maybeWhen<T>({
    T Function()? loadingNewImage,
    T Function(Uint8List image)? imageLoaded,
    T Function()? imageSaved,
    T Function()? error,
    required T Function() orElse,
  }) {
    return imageSaved?.call() ?? orElse();
  }

  @override
  HomePageState copyWith() => const ImageSavedState();
}

final class ErrorState extends HomePageState {
  const ErrorState();

  @override
  T when<T>({
    required T Function() loadingNewImage,
    required T Function(Uint8List image) imageLoaded,
    required T Function() imageSaved,
    required T Function() error,
  }) {
    return error();
  }

  @override
  T maybeWhen<T>({
    T Function()? loadingNewImage,
    T Function(Uint8List image)? imageLoaded,
    T Function()? imageSaved,
    T Function()? error,
    required T Function() orElse,
  }) {
    return error?.call() ?? orElse();
  }

  @override
  HomePageState copyWith() => const ErrorState();
}
