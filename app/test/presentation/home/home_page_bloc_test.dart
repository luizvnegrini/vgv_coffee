import 'dart:typed_data';

import 'package:external_dependencies/external_dependencies.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vgv_coffee/domain/domain.dart';
import 'package:vgv_coffee/presentation/presentation.dart';

class MockLoadNewImageUsecase extends Mock implements LoadNewImageUsecase {}

class MockSaveImageUsecase extends Mock implements SaveImageUsecase {}

class MockGetPermissionUsecase extends Mock implements GetPermissionUsecase {}

class MockLoadCoffeeAlbumUsecase extends Mock
    implements LoadCoffeeAlbumUsecase {}

void main() {
  late HomePageBloc bloc;
  late MockLoadNewImageUsecase mockLoadNewImageUsecase;
  late MockSaveImageUsecase mockSaveImageUsecase;
  late MockGetPermissionUsecase mockGetPermissionUsecase;
  late MockLoadCoffeeAlbumUsecase mockLoadCoffeeAlbumUsecase;

  setUp(() {
    mockLoadNewImageUsecase = MockLoadNewImageUsecase();
    mockSaveImageUsecase = MockSaveImageUsecase();
    mockGetPermissionUsecase = MockGetPermissionUsecase();
    mockLoadCoffeeAlbumUsecase = MockLoadCoffeeAlbumUsecase();

    bloc = HomePageBloc(
      loadNewImageUsecase: mockLoadNewImageUsecase,
      saveImageUsecase: mockSaveImageUsecase,
      getPermissionUsecase: mockGetPermissionUsecase,
      loadCoffeeAlbumUsecase: mockLoadCoffeeAlbumUsecase,
    );
  });

  test('initial state should be loading', () {
    expect(bloc.state, const HomePageState.loading());
  });

  group('loadCoffeeAlbum', () {
    test('should emit [LoadingCoffeeAlbum, ErrorState] when fails', () async {
      when(() => mockLoadCoffeeAlbumUsecase())
          .thenAnswer((_) async => Left(Exception()));

      final expectedStates = [
        const HomePageState.loadingCoffeeAlbum(),
        const HomePageState.error(),
      ];

      expectLater(bloc.stream, emitsInOrder(expectedStates));
      await bloc.loadCoffeeAlbum();
    });
  });

  group('loadNewImage', () {
    test('should emit [LoadingNewImageState, ErrorState] when fails', () async {
      when(() => mockLoadNewImageUsecase())
          .thenAnswer((_) async => Left(Exception()));

      final expectedStates = [
        const HomePageState.loading(),
        const HomePageState.error(),
      ];

      expectLater(bloc.stream, emitsInOrder(expectedStates));
      await bloc.loadNewImage();
    });
  });

  group('saveImage', () {
    final mockImageData = (Uint8List(0), 'test.jpg');

    test(
        'should emit [LoadingNewImageState, ImageSavedState] when successful with permission',
        () async {
      when(() => mockGetPermissionUsecase()).thenAnswer((_) async => true);
      when(() => mockSaveImageUsecase(mockImageData))
          .thenAnswer((_) async => const Right(unit));

      final expectedStates = [
        const HomePageState.loading(),
        const HomePageState.imageSaved(),
      ];

      expectLater(bloc.stream, emitsInOrder(expectedStates));
      await bloc.saveImage(mockImageData);
    });

    test('should emit [LoadingNewImageState, ErrorState] when save fails',
        () async {
      when(() => mockGetPermissionUsecase()).thenAnswer((_) async => true);
      when(() => mockSaveImageUsecase(mockImageData))
          .thenAnswer((_) async => Left(Exception()));

      final expectedStates = [
        const HomePageState.loading(),
        const HomePageState.error(),
      ];

      expectLater(bloc.stream, emitsInOrder(expectedStates));
      await bloc.saveImage(mockImageData);
    });

    test('should not emit new states when permission is denied', () async {
      when(() => mockGetPermissionUsecase()).thenAnswer((_) async => false);

      final expectedStates = [
        const HomePageState.loading(),
      ];

      expectLater(bloc.stream, emitsInOrder(expectedStates));
      await bloc.saveImage(mockImageData);
    });
  });
}
