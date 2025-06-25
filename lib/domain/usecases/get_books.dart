import 'package:book_application/domain/entities/book.dart';
import 'package:book_application/domain/repositories/book_repository.dart';

class GetBooks {
  final BookRepository bookRepository;

  GetBooks(this.bookRepository);

  Future<List<Book>> call() => bookRepository.getBooks();

  Future<bool> markFav(String id)=> bookRepository.toggleBooks(id);
}
