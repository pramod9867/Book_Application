import 'package:bloc_test/bloc_test.dart';
import 'package:book_application/core/app_container.dart';
import 'package:book_application/domain/entities/book.dart';
import 'package:book_application/domain/repositories/book_repository.dart';
import 'package:book_application/domain/usecases/get_books.dart';
import 'package:book_application/presentation/bloc/bloc/book_bloc.dart';
import 'package:book_application/presentation/bloc/event/book_event.dart';
import 'package:book_application/presentation/bloc/state/book_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockRepo extends Mock implements BookRepository {}

void main() {
  late BookBloc bookBloc;
  late MockRepo mockRepo;

  final mockBooks = [
    Book(
        id: '1',
        title: 'Flutter Dev',
        author: 'John',
        image: 'url1',
        isFavorite: false),
    Book(
        id: '2',
        title: 'Dart Lang',
        author: 'Doe',
        image: 'url2',
        isFavorite: true),
  ];

  setUp(() {
    mockRepo = MockRepo();
    AppContainer.repo = mockRepo;
    AppContainer.getBooks = GetBooks(mockRepo);
    bookBloc = BookBloc();
  });

  tearDown(() {
    bookBloc.close();
  });

  group('BookBloc Tests', () {
    blocTest<BookBloc, BookBasicState>(
      'emits [Loading, Loaded] when FetchBookDetails is added and returns books',
      build: () {
        when(() => mockRepo.getBooks()).thenAnswer((_) async => mockBooks);
        return bookBloc;
      },
      act: (bloc) => bloc.add(FetchBookDetails()),
      expect: () => [
        BooksLoadingState(),
        BooksLoadedState(mockBooks),
      ],
    );

    blocTest<BookBloc, BookBasicState>(
      'emits [Loading, Error] when FetchBookDetails returns empty list',
      build: () {
        when(() => mockRepo.getBooks()).thenAnswer((_) async => []);
        return bookBloc;
      },
      act: (bloc) => bloc.add(FetchBookDetails()),
      expect: () => [
        BooksLoadingState(),
        BooksErrorState("No Data found"),
      ],
    );
  });
}
