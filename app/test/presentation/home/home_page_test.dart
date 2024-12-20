import 'package:external_dependencies/external_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vgv_coffee/presentation/presentation.dart';

class MockHomePageBloc extends Mock implements HomePageBloc {}

void main() {
  late MockHomePageBloc mockBloc;

  setUp(() {
    mockBloc = MockHomePageBloc();
    when(() => mockBloc.loadNewImage()).thenAnswer((_) async {});
    when(() => mockBloc.loadCoffeeAlbum()).thenAnswer((_) async {});
    when(() => mockBloc.stream).thenAnswer((_) => Stream.empty());
  });

  testWidgets('should show loading state initially', (tester) async {
    when(() => mockBloc.state).thenReturn(const HomePageState.loading());

    await tester.runAsync(
      () => tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<HomePageBloc>.value(
            value: mockBloc,
            child: const HomePage(),
          ),
        ),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsWidgets);
  });

  testWidgets('should load new image and coffee album on init', (tester) async {
    when(() => mockBloc.state).thenReturn(const HomePageState.loading());

    await tester.runAsync(
      () => tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<HomePageBloc>.value(
            value: mockBloc,
            child: const HomePage(),
          ),
        ),
      ),
    );

    verify(() => mockBloc.loadNewImage()).called(1);
    verify(() => mockBloc.loadCoffeeAlbum()).called(1);
  });

  testWidgets('should not allow navigation to last tab', (tester) async {
    when(() => mockBloc.state).thenReturn(const HomePageState.loading());

    await tester.runAsync(
      () => tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<HomePageBloc>.value(
            value: mockBloc,
            child: const HomePage(),
          ),
        ),
      ),
    );

    expect(
      () => DefaultTabController.of(tester.element(find.byType(HomePage))),
      throwsAssertionError,
    );

    verify(() => mockBloc.loadNewImage()).called(1);
  });
}
