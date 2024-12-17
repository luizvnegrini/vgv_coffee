sealed class HomePageState {
  const HomePageState._();

  const factory HomePageState.initial() = _InitialState;
  const factory HomePageState.loading() = _LoadingState;
  const factory HomePageState.imageSaved() = _ImageSavedState;

  /// `when` and `maybeWhen` methods
  R when<R>({
    required R Function() initial,
    required R Function() loading,
    required R Function() imageSaved,
  }) =>
      switch (this) {
        _InitialState() => initial(),
        _LoadingState() => loading(),
        _ImageSavedState() => imageSaved(),
      };

  R maybeWhen<R>({
    R Function()? initial,
    R Function()? loading,
    R Function()? imageSavedState,
    required R Function() orElse,
  }) {
    final handler = switch (this) {
      _InitialState() => initial,
      _LoadingState() => loading,
      _ImageSavedState() => imageSavedState,
    };
    return handler?.call() ?? orElse();
  }

  R map<R>({
    required R Function() initial,
    required R Function() loading,
    required R Function() imageSaved,
  }) =>
      switch (this) {
        _InitialState() => initial(),
        _LoadingState() => loading(),
        _ImageSavedState() => imageSaved(),
      };

  R maybeMap<R>({
    R Function()? initial,
    R Function()? loading,
    R Function()? imageSaved,
    required R Function() orElse,
  }) {
    final handler = switch (this) {
      _InitialState() => initial,
      _LoadingState() => loading,
      _ImageSavedState() => imageSaved,
    };
    return handler?.call() ?? orElse();
  }

  HomePageState copyWith();
}

final class _InitialState extends HomePageState {
  const _InitialState() : super._();

  @override
  HomePageState copyWith() => const _InitialState();
}

final class _LoadingState extends HomePageState {
  const _LoadingState() : super._();

  @override
  HomePageState copyWith() => const _LoadingState();
}

final class _ImageSavedState extends HomePageState {
  const _ImageSavedState() : super._();

  @override
  HomePageState copyWith() => const _ImageSavedState();
}
