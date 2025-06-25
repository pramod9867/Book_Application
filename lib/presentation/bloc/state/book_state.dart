import 'package:book_application/domain/entities/book.dart';
import 'package:equatable/equatable.dart';

sealed class BookBasicState extends Equatable {}

class BooksInitialState extends BookBasicState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class MarkBookAsFavState extends BookBasicState {
  final bool isMarked;

  MarkBookAsFavState(this.isMarked);
  @override
  // TODO: implement props
  List<Object?> get props => [this.isMarked];
}

class BooksLoadingState extends BookBasicState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class BooksErrorState extends BookBasicState {
  final String message;

  BooksErrorState(this.message);

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class FavBooksLoadedState extends BookBasicState {
  final List<Book> booksList;

  FavBooksLoadedState(this.booksList);
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class BooksLoadedState extends BookBasicState {
  final List<Book> booksList;

  BooksLoadedState(this.booksList);

  @override
  // TODO: implement props
  List<Object?> get props => [this.booksList];

  get books => this.booksList;
}
