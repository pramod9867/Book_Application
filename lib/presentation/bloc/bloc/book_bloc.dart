import 'package:bloc/bloc.dart';
import 'package:book_application/core/app_container.dart';
import 'package:book_application/data/datasources/localdatasource.dart';
import 'package:book_application/data/datasources/remotedatasource.dart';
import 'package:book_application/data/repositories/book_repository/book_repositories.dart';
import 'package:book_application/domain/entities/book.dart';
import 'package:book_application/domain/usecases/get_books.dart';
import 'package:book_application/presentation/bloc/event/book_event.dart';
import 'package:book_application/presentation/bloc/state/book_state.dart';

class BookBloc extends Bloc<BasicBookEvent, BookBasicState> {
  List<Book> booksList = [];
  BookBloc() : super(BooksInitialState()) {
    on<FetchBookDetails>(_fetchBookDetails);
    on<AddBookFav>(_addBookAsFav);
    on<FilteredBooksByName>(_filteredbooks);
  }

  Future<void> _filteredbooks(
      BasicBookEvent event, Emitter<BookBasicState> emit) async {
    emit(BooksLoadingState());
    FilteredBooksByName filteredBooksByName = event as FilteredBooksByName;
    List<Book> filteredList = booksList
        .where((element) => element.title
            .toUpperCase()
            .startsWith(filteredBooksByName.name.toUpperCase()))
        .toList();

    if (filteredBooksByName.name.isNotEmpty) {
      emit(BooksLoadedState(filteredList));
    } else {
      emit(BooksLoadedState(booksList));
    }
  }

  Future<void> _addBookAsFav(
      BasicBookEvent event, Emitter<BookBasicState> emit) async {
    AddBookFav addBookFav = event as AddBookFav;

    bool isFav = await AppContainer.repo.toggleBooks(addBookFav.id);
    if (isFav) {
      emit(MarkBookAsFavState(isFav));

      int index =
          booksList.indexWhere((element) => element.id == addBookFav.id);

      if (index >= 0) {
        booksList[index] = Book(
            id: booksList[index].id,
            title: booksList[index].title,
            author: booksList[index].author,
            image: booksList[index].image,
            isFavorite: !booksList[index].isFavorite);
      }

      emit(BooksLoadedState(booksList));
    } else {
      emit(MarkBookAsFavState(isFav));
    }
  }

  Future<void> _fetchBookDetails(
      BasicBookEvent event, Emitter<BookBasicState> emit) async {
    print("Fetch Books");
    emit(BooksLoadingState());

    booksList = [];

    booksList = await AppContainer.getBooks.bookRepository.getBooks();

    if (booksList.length > 0) {
      emit(BooksLoadedState(booksList));
    } else {
      emit(BooksErrorState("No Data found"));
    }
  }
}
