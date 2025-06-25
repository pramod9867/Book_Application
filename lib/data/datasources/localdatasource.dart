import 'package:book_application/data/models/local/book_model.dart';
import 'package:hive/hive.dart';

abstract class BookLocalDataSource {
  Future<List<BookModel>> getCachedBooks();
  Future<void> cacheBooks(List<BookModel> books);
}

class LocalDataSource implements BookLocalDataSource {
  static const BOX_NAME = 'books_box';
  final Box<BookModel> box;

  LocalDataSource(this.box);

  @override
  Future<void> cacheBooks(List<BookModel> books) async {
    await box.clear();
    for (var book in books) {
      await box.add(book);
    }
  }

  Future<bool> updateFavourites(String id) async {
    final bookKey = box.keys.firstWhere(
      (key) => box.get(key)?.id == id,
      orElse: () => null,
    );

    if (bookKey != null) {
      final oldBook = box.get(bookKey)!;

      final updatedBook = BookModel(
          author: oldBook.author,
          id: oldBook.id,
          isFavorite: !oldBook.isFavorite,
          image: oldBook.image,
          title: oldBook.title // keep other fields same
          );

      await box.put(bookKey, updatedBook);
      return true;
    } else {
      return false;
    }

  }

  @override
  Future<List<BookModel>> getCachedBooks() async {
    return box.values.toList();
  }
}
