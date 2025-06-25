sealed class BasicBookEvent {}

class FetchBookDetails extends BasicBookEvent {}

class FilteredBooksByName extends BasicBookEvent {
  final String name;

  FilteredBooksByName(this.name);
}

class FetchFavouriteBookDetails extends BasicBookEvent {}

class AddBookFav extends BasicBookEvent {
  final String id;
  final String type;
  final bool isFav;

  AddBookFav(this.id, this.isFav, this.type);
}
