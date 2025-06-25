import 'package:book_application/domain/entities/book.dart';

abstract class BookRepository {
  Future<List<Book>> getBooks();
  Future<bool> toggleBooks(String id);
}
